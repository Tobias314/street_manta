import io
import json
from pathlib import Path
from typing import Dict, List, Annotated
import logging
import zipfile

import cv2
from fastapi import (
    FastAPI,
    Request,
    Response,
    UploadFile,
    APIRouter,
    Depends,
    HTTPException,
)
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
from .data import storage_interface
from .data.schemas import get_db
from .globals import DATASTORE_PATH, WAYPOINT_MIN_TIME_DELTA_SECONDS
from .authentication import (
    create_user,
    get_current_user,
    is_correct_password_for_user,
    user_generate_token,
)
from .data.storage_interface import (
    THUMBNAIL_FORMAT,
    add_video_from_bytes,
    get_photos_for_capture,
    init_geocapture,
    read_photo_bytes,
    read_thumbnail_bytes,
    add_capture_chunk,
    add_photo_from_bytes,
)
from .protobufs.geo_capture_pb2 import GeoCaptureChunk


logger = logging.getLogger(__name__)
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)
formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
ch.setFormatter(formatter)

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


def get_fs():
    fs_dir = Path(f"{DATASTORE_PATH}")
    print(f"Using datastore path: {fs_dir}")
    fs_dir.mkdir(parents=True, exist_ok=True)
    fs = OSFS(str(fs_dir))
    try:
        yield fs
    finally:
        fs.close()


def get_thumbnail_url(base_url: str, capture_id: str) -> str:
    return f"{base_url}api/geocaptures/{capture_id}/thumbnail.{THUMBNAIL_FORMAT}"


def get_photo_url(
    base_url: str, capture_id: str, image_id: str, data_format: str
) -> str:
    return f"{base_url}api/geocaptures/{capture_id}/photos/{image_id}.{data_format}"


def get_video_url(
    base_url: str, capture_id: str, video_id: str, data_format: str
) -> str:
    return f"{base_url}api/geocaptures/{capture_id}/video/{video_id}.{data_format}"


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
    user = storage_interface.get_user_by_email(form_data.username, db)
    print(user)
    if not user:
        raise HTTPException(status_code=400, detail="Incorrect username or password")
    if not is_correct_password_for_user(user, form_data.password):
        raise HTTPException(status_code=400, detail="Incorrect username or password")
    user_generate_token(user, db=db)
    print(user.current_token)
    return {"access_token": user.current_token, "token_type": "bearer"}


@api_router.get(
    "/geocaptures_for_region/{lat_min},{lon_min},{lat_max},{lon_max}",
    response_model=List[models.GeoCaptureDescriptor],
)
def get_geocaptures_for_region(
    user: Annotated[models.User, Depends(get_current_user)],
    lat_min: float,
    lon_min: float,
    lat_max: float,
    lon_max: float,
    request: Request,
    db: Session = Depends(get_db),
    fs: FS = Depends(get_fs),
) -> List[models.GeoCaptureDescriptor]:
    captures = storage_interface.get_geocaptures_for_region(
        lat_min=lat_min,
        lon_min=lon_min,
        lat_max=lat_max,
        lon_max=lon_max,
        db=db,
        user=user,
    )
    logger.info(
        f"Found {len(captures)} captures for region: {lat_min}, {lon_min}, {lat_max}, {lon_max}"
    )
    result = []
    for capture in captures:
        capture_videos = storage_interface.get_videos_for_capture(
            capture_id=capture.capture_id, db=db
        )
        thumbnail_url = (
            get_thumbnail_url(capture_id=capture.capture_id, base_url=request.base_url)
            if fs.exists(f"{capture.capture_id}/thumbnail.{THUMBNAIL_FORMAT}")
            else None
        )
        print(f"Thumbnail URL: {thumbnail_url}")
        result.append(
            models.GeoCaptureDescriptor(
                capture_id=capture.capture_id,
                bbox_min=models.GeoPosition(
                    latitude=capture.latitude_min,
                    longitude=capture.longitude_min,
                    elevation=capture.elevation_min,
                ),
                bbox_max=models.GeoPosition(
                    latitude=capture.latitude_max,
                    longitude=capture.longitude_max,
                    elevation=capture.elevation_max,
                ),
                photos=[
                    models.GeoCapturePhoto(
                        photo_id=photo.photo_id,
                        position=models.GeoPosition(
                            latitude=photo.latitude,
                            longitude=photo.longitude,
                            elevation=photo.elevation,
                        ),
                        url=get_photo_url(
                            base_url=request.base_url,
                            capture_id=capture.capture_id,
                            image_id=photo.photo_id,
                            data_format=photo.data_format,
                        ),
                    )
                    for photo in storage_interface.get_photos_for_capture(
                        capture_id=capture.capture_id, db=db
                    )
                ],
                description=capture.description,
                video=models.GeoCaptureVideo(
                    video_id=capture_videos[0].video_id,
                    waypoints=[
                        models.GeoPosition(**pos)
                        for pos in json.loads(capture_videos[0].waypoints)
                    ],
                    url=get_video_url(
                        base_url=request.base_url,
                        capture_id=capture.capture_id,
                        video_id=capture_videos[0].video_id,
                        data_format=capture_videos[0].data_format,
                    ),
                )
                if capture_videos
                else None,
                thumbnail_url=thumbnail_url,
            )
        )
    return result


@api_router.get("/geocaptures/{capture_id}/photos/{file_name}")
async def fetch_photo(
    capture_id: str,
    file_name: str,
    user: Annotated[models.User, Depends(get_current_user)],
    fs: FS = Depends(get_fs),
) -> str:
    image_bytes = read_photo_bytes(capture_id=capture_id, file_name=file_name, fs=fs)
    return Response(content=image_bytes, media_type=f"image/{Path(file_name).suffix}")


@api_router.get("/geocaptures/{capture_id}/video/{file_name}")
async def fetch_video(
    capture_id: str,
    file_name: str,
    user: Annotated[models.User, Depends(get_current_user)],
    fs: FS = Depends(get_fs),
) -> str:
    return Response(
        content=read_photo_bytes(capture_id, file_name, fs),
        media_type=f"image/{Path(file_name).suffix}",
    )


@api_router.get("/geocaptures/{capture_id}/thumbnail." + THUMBNAIL_FORMAT)
async def fetch_thumbnail(
    capture_id: str,
    user: Annotated[models.User, Depends(get_current_user)],
    fs: FS = Depends(get_fs),
) -> str:
    return Response(
        content=read_thumbnail_bytes(capture_id, fs), media_type="image/jpeg"
    )


@api_router.post("/upload_geocapture_chunk")
async def upload_geo_capture(
    user: Annotated[models.User, Depends(get_current_user)],
    geocapture: UploadFile,
    db: Session = Depends(get_db),
    fs: FS = Depends(get_fs),
) -> str:
    geo_capture_bytes = await geocapture.read()
    geocapture = GeoCaptureChunk()
    geocapture.ParseFromString(geo_capture_bytes)
    capture_id = geocapture.identifier
    chunk_index = geocapture.chunk_index
    logger.info(
        f"Received geocapture chunk for capture {capture_id}, chunk index {chunk_index}, is_last_chunk: {geocapture.is_last_chunk}"
    )
    if chunk_index == 0:
        init_geocapture(
            capture_id=capture_id,
            fs=fs,
        )
    if chunk_index == 0 and geocapture.is_last_chunk and geocapture.video is None:
        if len(geocapture.photos) != 1:
            raise ValueError(
                f"Non-contiguous captures (one chunk, no video) are expected to be single image captures containing exactly one photo but {len(geocapture.photos)} photos were found."
            )
    add_capture_chunk(
        geocapture_chunk=geocapture,
        db=db,
        fs=fs,
    )
    for i, photo_capture in enumerate(geocapture.photos):
        image_bytes = photo_capture.data
        add_photo_from_bytes(
            image_bytes,
            capture_id=capture_id,
            photo_id=photo_capture.identifier,
            position=models.GeoPosition(
                latitude=photo_capture.gps.position.latitude,
                longitude=photo_capture.gps.position.longitude,
                elevation=photo_capture.gps.position.elevation,
            ),
            db=db,
            fs=fs,
            make_thumbnail=True,
            data_format=photo_capture.format,
        )

    if geocapture.is_last_chunk:
        capture_photos = get_photos_for_capture(capture_id=capture_id, db=db)
        capture_chunks = storage_interface.get_chunks_for_capture(
            capture_id=capture_id, db=db
        )
        positions = [[photo.latitude, photo.longitude] for photo in capture_photos]
        for chunk in capture_chunks:
            for pos in json.loads(chunk.waypoints):
                positions.append([pos["latitude"], pos["longitude"]])
        positions = np.array(positions)
        min_pos = np.min(positions, axis=0)
        max_pos = np.max(positions, axis=0)
        bbox_min = models.GeoPosition(
            latitude=min_pos[0],
            longitude=min_pos[1],
            elevation=0,  # Elevation is not used in bounding box calculations yet
        )
        bbox_max = models.GeoPosition(
            latitude=max_pos[0],
            longitude=max_pos[1],
            elevation=0,  # Elevation is not used in bounding box calculations yet
        )
        geocapture_model = models.GeoCaptureDescriptor(
            capture_id=capture_id,
            bbox_min=bbox_min,
            bbox_max=bbox_max,
            photos=[],
            video=None,
            description=geocapture.description,
        )
        storage_interface.create_geocapture_from_model(
            db=db, geocapture=geocapture_model, user=user
        )
    return capture_id


# @api_router.post("/geophoto/upload_image")
# async def upload_image(
#     user: Annotated[models.User, Depends(get_current_user)],
#     image: UploadFile,
#     fs: FS = Depends(get_fs),
# ) -> str:
#     image_bytes = await image.read()
#     image_id = str(uuid4())
#     save_image_from_bytes(image_bytes, image_id, fs)
#     return image_id


# @api_router.post("/geophoto/create")
# def create_single_geophoto(
#     geophoto: models.GeoPhotoCreate,
#     user: Annotated[models.User, Depends(get_current_user)],
#     db: Session = Depends(get_db),
#     fs: FS = Depends(get_fs),
# ) -> int:
#     image_path = f"{geophoto.image_id}.png"
#     print(image_path)
#     assert fs.opendir("images").exists(image_path)
#     geophoto_id = db_interface.create_geophoto(db=db, geophoto=geophoto, user=user)
#     return geophoto_id


app.include_router(api_router)
app.mount(
    "/static",
    StaticFiles(
        directory=Path(__file__).parent.resolve() / "../../../frontend/build/web"
    ),
    name="static",
)


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8080)
