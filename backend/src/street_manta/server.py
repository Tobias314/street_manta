from collections import defaultdict
import json
from pathlib import Path
import shutil
from tempfile import TemporaryDirectory
from typing import Dict, List, Annotated
import logging
from fastapi import (
    FastAPI,
    Header,
    Request,
    Response,
    UploadFile,
    APIRouter,
    Depends,
    HTTPException,
    status,
)
from fastapi import BackgroundTasks
from fastapi.responses import FileResponse, RedirectResponse
from fastapi.staticfiles import StaticFiles
from fastapi.security import OAuth2PasswordRequestForm
import numpy as np
from sqlalchemy.orm import Session
from fastapi.middleware.cors import CORSMiddleware
from fs.osfs import OSFS
from fs.base import FS
from upath import UPath

from .video import concatenate_video_chunks
from .utils import register_exception
from .data import models
from .data import storage_interface
from .data.schemas import get_db
from .globals import (
    DATASTORE_PATH,
    VIDEO_SERVING_CHUNK_SIZE,
    VIDEO_STORAGE_FORMAT,
)
from .authentication import (
    create_user,
    get_current_user,
    is_correct_password_for_user,
    user_generate_token,
)
from .data.storage_interface import (
    THUMBNAIL_FORMAT,
    get_photos_for_capture,
    get_user_for_token,
    get_video_file_path,
    get_video_storage_path,
    init_geocapture,
    read_photo_bytes,
    read_thumbnail_bytes,
    add_capture_chunk,
    add_photo_from_bytes,
    register_video,
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


def get_storage_path() -> UPath:
    """
    Returns the path to the storage directory.
    """
    storage_path = UPath(DATASTORE_PATH)
    storage_path.mkdir(parents=True, exist_ok=True)
    return storage_path


def get_thumbnail_url(base_url: str, capture_id: str) -> str:
    return f"{base_url}api/geocaptures/{capture_id}/thumbnail.{THUMBNAIL_FORMAT}"


def get_photo_url(
    base_url: str, capture_id: str, image_id: str, data_format: str
) -> str:
    return f"{base_url}api/geocaptures/{capture_id}/photos/{image_id}.{data_format}"


def get_video_url(
    base_url: str, capture_id: str, video_id: str, data_format: str
) -> str:
    video_url = f"{base_url}api/geocaptures/{capture_id}/video/{video_id}.{data_format}"
    print(f"Video URL: {video_url}")
    return video_url


def finalize_geocapture(
    capture_id: str,
    user_token: str,
    storage_path: UPath,
    db: Session,
    description: str = "",
) -> None:
    """
    Finalizes the geocapture by processing the video and generating a thumbnail.
    """
    # The given session is probably already closed, when this is run as a background task,
    # so we need to create a new session for the same database.
    with Session(
        bind=db.get_bind(),
        autocommit=False,
        autoflush=False,
    ) as db_session:
        logger.info(f"Finalizing geocapture {capture_id}")
        user = get_user_for_token(token=user_token, db=db_session)
        capture_photos = get_photos_for_capture(capture_id=capture_id, db=db_session)
        capture_chunks = storage_interface.get_chunks_for_capture(
            capture_id=capture_id, db=db_session
        )
        positions = [[photo.latitude, photo.longitude] for photo in capture_photos]
        trace_chunk_paths = defaultdict(list)
        trace_waypoints = defaultdict(list)
        for chunk in capture_chunks:
            trace_chunk_paths[chunk.trace_id].append(
                storage_path / f"{capture_id}/chunks/{chunk.chunk_index}.cap"
            )
            for pos in json.loads(chunk.waypoints):
                positions.append([pos["latitude"], pos["longitude"]])
                trace_waypoints[chunk.trace_id].append(
                    models.GeoPosition(
                        latitude=pos["latitude"],
                        longitude=pos["longitude"],
                        elevation=pos["elevation"],
                    )
                )
            positions.append((chunk.latitude_min, chunk.longitude_min))
            positions.append((chunk.latitude_max, chunk.longitude_max))
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
        for trace_id, chunk_paths in trace_chunk_paths.items():
            is_video_created = concatenate_video_chunks(
                chunk_paths=chunk_paths,
                output_path=get_video_storage_path(
                    capture_id=capture_id,
                    video_id=trace_id,
                    storage_path=storage_path,
                    video_format=VIDEO_STORAGE_FORMAT,
                ),
            )
            if is_video_created:
                register_video(
                    video_id=trace_id,
                    capture_id=capture_id,
                    waypoints=trace_waypoints[trace_id],
                    data_format=VIDEO_STORAGE_FORMAT,
                    db=db_session,
                )
        geocapture_model = models.GeoCaptureDescriptor(
            capture_id=capture_id,
            bbox_min=bbox_min,
            bbox_max=bbox_max,
            photos=[],  # can be left empty, not needed for db here
            video=None,  # can be left empty, not needed for db here
            description=description,
        )
        storage_interface.create_geocapture_from_model(
            db=db_session, geocapture=geocapture_model, user=user
        )


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


def ingest_geocapture_chunk(
    geocapture: GeoCaptureChunk,
    fs: FS,
    db: Session,
) -> None:
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


@api_router.post("/upload_geocapture_chunk")
async def upload_geo_capture(
    user: Annotated[models.User, Depends(get_current_user)],
    geocapture: UploadFile,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
    fs: FS = Depends(get_fs),
    storage_path: UPath = Depends(get_storage_path),
) -> str:
    geo_capture_bytes = await geocapture.read()
    geocapture = GeoCaptureChunk()
    geocapture.ParseFromString(geo_capture_bytes)
    ingest_geocapture_chunk(
        geocapture=geocapture,
        fs=fs,
        db=db,
    )
    if geocapture.is_last_chunk:
        background_tasks.add_task(
            finalize_geocapture,
            user_token=user.current_token,
            capture_id=geocapture.identifier,
            storage_path=storage_path,
            db=db,
            description=geocapture.description,
        )
    return geocapture.identifier


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


# @api_router.get("/geocaptures/{capture_id}/video/{file_name}")
# async def fetch_video(
#     capture_id: str,
#     file_name: str,
#     user: Annotated[models.User, Depends(get_current_user)],
#     fs: FS = Depends(get_fs),
# ) -> str:
#     return Response(
#         content=read_photo_bytes(capture_id, file_name, fs),
#         media_type=f"image/{Path(file_name).suffix}",
#     )


@api_router.get("/geocaptures/{capture_id}/video/{file_name}")
async def serve_video(
    capture_id: str,
    file_name: str,
    user: Annotated[models.User, Depends(get_current_user)],
    request: Request,
    range: str = Header(None),
    fs: FS = Depends(get_fs),
    storage_path: UPath = Depends(get_storage_path),
) -> Response:
    print(request.headers)
    if range is None or not range.startswith("bytes="):
        start, end = 0, None
    else:
        start, end = range.replace("bytes=", "").split("-")
    start = int(start)
    end = int(end) if end else start + VIDEO_SERVING_CHUNK_SIZE
    video_path = get_video_file_path(
        capture_id=capture_id, file_name=file_name, storage_path=storage_path
    )
    with video_path.open("rb") as video:
        video.seek(start)
        data = video.read(end - start)
        filesize = str(video_path.stat().st_size)
        headers = {
            "Content-Range": f"bytes {str(start)}-{str(end)}/{filesize}",
            "Accept-Ranges": "bytes",
        }
        return Response(
            data,
            status_code=206,
            headers=headers,
            media_type=f"video/{Path(file_name).suffix}",
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


def cleanup_temp_dir(temp_dir: Path):
    """
    Cleans up the temporary directory.
    """
    if temp_dir.exists():
        shutil.rmtree(temp_dir)
        logger.info(f"Temporary directory {temp_dir} cleaned up.")


@api_router.get("/geocaptures/{capture_id}/download")
async def download_geocapture(
    capture_id: str,
    user: Annotated[models.User, Depends(get_current_user)],
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
    fs: FS = Depends(get_fs),
    storage_path: UPath = Depends(get_storage_path),
) -> FileResponse:
    """
    Downloads the geocapture as a zip file.
    """
    temp_dir = Path(TemporaryDirectory().name)
    logger.info(f"created temporary directory at {temp_dir}")
    capture_directory_path = storage_path / capture_id
    if not capture_directory_path.exists():
        raise HTTPException(status_code=404, detail="Geocapture not found")
    shutil.make_archive(str(temp_dir / capture_id), "zip", str(capture_directory_path))
    # Create a zip file from the exported geocapture
    zip_file_path = temp_dir / f"{capture_id}.zip"
    background_tasks.add_task(cleanup_temp_dir, temp_dir)
    return FileResponse(
        path=zip_file_path,
        media_type="application/zip",
        filename=f"{capture_id}.zip",
    )


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
