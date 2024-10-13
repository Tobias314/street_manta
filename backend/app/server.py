from typing import Dict, List, Annotated
import logging

import cv2
from fastapi import FastAPI, Response, UploadFile, APIRouter, Depends, HTTPException
from fastapi.responses import FileResponse, RedirectResponse
from fastapi.staticfiles import StaticFiles
from fastapi.security import OAuth2PasswordRequestForm
import numpy as np
from sqlalchemy.orm import Session
from fastapi.middleware.cors import CORSMiddleware
from uuid import uuid4
from fs.osfs import OSFS
from fs.base import FS

from .utils import register_exception

from .data import models
from .data import db_interface
from .data.schemas import get_db
from .globals import DATASTORE_PATH
from .authentication import (
    create_user,
    get_current_user,
    is_correct_password_for_user,
    user_generate_token,
)
from .data.db_interface import save_image_from_bytes

logger = logging.getLogger(__name__)

app = FastAPI()
register_exception(app)
app.add_middleware(
    CORSMiddleware,
    allow_origins="*",
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
api_router = APIRouter(prefix="/api")


def get_image_fs():
    image_fs = OSFS(f"{DATASTORE_PATH}/images")
    try:
        yield image_fs
    finally:
        image_fs.close()


@app.get("/")
async def root():
    return RedirectResponse(url="/static/index.html")


@api_router.post("/account")
async def create_account(
    create_account_request: models.CreateAccountRequest,
    db: Session = Depends(get_db),
) -> None:
    await create_user(
        email=create_account_request.email,
        password=create_account_request.password,
        db=db,
    )


@api_router.post("/token")
async def login(
    form_data: Annotated[OAuth2PasswordRequestForm, Depends()],
    db: Session = Depends(get_db),
) -> Dict[str, str]:
    user = db_interface.get_user_by_email(form_data.username, db)
    print(user)
    if not user:
        raise HTTPException(status_code=400, detail="Incorrect username or password")
    if not is_correct_password_for_user(user, form_data.password):
        raise HTTPException(status_code=400, detail="Incorrect username or password")
    user_generate_token(user, db=db)
    print(user.current_token)
    return {"access_token": user.current_token, "token_type": "bearer"}


@api_router.get(
    "/geophoto/get_for_region/{lat_min},{lon_min},{lat_max},{lon_max}",
    response_model=List[models.GeoPhoto],
)
def get_geophotos_for_region(
    user: Annotated[models.User, Depends(get_current_user)],
    lat_min: float,
    lon_min: float,
    lat_max: float,
    lon_max: float,
    db: Session = Depends(get_db),
) -> List[models.GeoPhoto]:
    res = db_interface.get_geophotos_for_region(
        lat_min=lat_min,
        lon_min=lon_min,
        lat_max=lat_max,
        lon_max=lon_max,
        db=db,
        user=user,
    )
    return res


@api_router.get("/geophoto/fetch_image/{image_id}")
async def fetch_image(
    image_id: str,
    user: Annotated[models.User, Depends(get_current_user)],
    image_fs: FS = Depends(get_image_fs),
) -> str:
    image_bytes = image_fs.readbytes(f"{image_id}.png")
    return Response(content=image_bytes, media_type="image/png")


@api_router.get("/geophoto/fetch_thumbnail/{image_id}")
async def fetch_thumbnail(
    image_id: str,
    user: Annotated[models.User, Depends(get_current_user)],
    image_fs: FS = Depends(get_image_fs),
) -> str:
    image_bytes = image_fs.readbytes(f"{image_id}_thumbnail.png")
    return Response(content=image_bytes, media_type="image/png")


@api_router.post("/geophoto/upload_image")
async def upload_image(
    user: Annotated[models.User, Depends(get_current_user)],
    image: UploadFile,
    image_fs: FS = Depends(get_image_fs),
) -> str:
    image_bytes = await image.read()
    image_id = str(uuid4())
    save_image_from_bytes(image_bytes, image_id, image_fs)
    return image_id


@api_router.post("/geophoto/create")
def create_single_geophoto(
    geophoto: models.GeoPhotoCreate,
    user: Annotated[models.User, Depends(get_current_user)],
    db: Session = Depends(get_db),
    image_fs: FS = Depends(get_image_fs),
) -> int:
    image_path = f"{geophoto.image_id}.png"
    print(image_path)
    assert image_fs.exists(image_path)
    geophoto_id = db_interface.create_geophoto(db=db, geophoto=geophoto, user=user)
    return geophoto_id


app.include_router(api_router)
app.mount(
    "/static", StaticFiles(directory="../frontend/build/web"), name="static"
)


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8080)
