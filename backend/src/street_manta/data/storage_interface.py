from typing import List, Optional
import logging
import json

from fs.base import FS
import cv2
import numpy as np
from sqlalchemy.orm import Session
from sqlalchemy import select
from street_manta.globals import WAYPOINT_MIN_TIME_DELTA_SECONDS

from . import schemas
from .models import GeoCaptureDescriptor, GeoCapturePhoto, User, GeoPosition
from ..protobufs.geo_capture_pb2 import GeoCaptureChunk
from street_manta.data import models

logger = logging.getLogger(__name__)

THUMBNAIL_FORMAT = "jpg"


def create_geocapture_from_model(
    db: Session, geocapture: GeoCaptureDescriptor, user: User
) -> int:
    print(f"Creating geocapture {geocapture.capture_id} for user {user.email}")
    # data = {
    #     "photo_ids": geocapture.photo_ids,
    #     "positions": [tuple(pos) for pos in geocapture.positions],
    #     "video_id": geocapture.video_id,
    #     "waypoints": [tuple[pos] for pos in geocapture.waypoints],
    # }
    db_geocapture = schemas.GeoCapture(
        capture_id=geocapture.capture_id,
        user=user,
        latitude_min=geocapture.bbox_min.latitude,
        longitude_min=geocapture.bbox_min.longitude,
        elevation_min=geocapture.bbox_min.elevation,
        latitude_max=geocapture.bbox_max.latitude,
        longitude_max=geocapture.bbox_max.longitude,
        elevation_max=geocapture.bbox_max.elevation,
        description=geocapture.description,
    )
    db.add(db_geocapture)
    db.flush()
    capture_id = db_geocapture.capture_id
    rtree_location = schemas.GeoCaptureRTreeBbox(
        id=None,  # Auto-incremented by the database
        capture_id=capture_id,
        latitude_min=geocapture.bbox_min.latitude,
        latitude_max=geocapture.bbox_max.latitude,
        longitude_min=geocapture.bbox_min.longitude,
        longitude_max=geocapture.bbox_max.longitude,
    )
    db.add(rtree_location)
    db.commit()


def create_user(user: schemas.User, db: Session) -> None:
    db.add(user)
    db.commit()


def get_geocaptures_for_region(
    lat_min: float,
    lon_min: float,
    lat_max: float,
    lon_max: float,
    db: Session,
    user: Optional[schemas.User] = None,
) -> List[schemas.GeoCapture]:
    query = (
        select(schemas.GeoCapture)
        .where(
            (schemas.GeoCaptureRTreeBbox.latitude_max >= lat_min)
            & (schemas.GeoCaptureRTreeBbox.latitude_min <= lat_max)
            & (schemas.GeoCaptureRTreeBbox.longitude_max >= lon_min)
            & (schemas.GeoCaptureRTreeBbox.longitude_min <= lon_max)
        )
        .join_from(
            schemas.GeoCapture,
            schemas.GeoCaptureRTreeBbox,
            onclause=schemas.GeoCapture.capture_id
            == schemas.GeoCaptureRTreeBbox.capture_id,
        )
    )
    if user:
        query = query.where(schemas.GeoCapture.user_id == user.email)
    captures = [gp[0] for gp in db.execute(query).all()]
    return captures


def get_chunks_for_capture(
    capture_id: str, db: Session
) -> List[schemas.GeoCaptureChunk]:
    query_result = (
        db.query(schemas.GeoCaptureChunk)
        .filter(schemas.GeoCaptureChunk.capture_id == capture_id)
        .order_by(schemas.GeoCaptureChunk.chunk_index)
        .all()
    )
    return query_result


def get_photos_for_capture(capture_id: str, db: Session) -> List[schemas.GeoPhoto]:
    query_result = (
        db.query(schemas.GeoPhoto)
        .filter(schemas.GeoPhoto.capture_id == capture_id)
        .all()
    )
    return query_result


def get_videos_for_capture(capture_id: str, db: Session) -> List[schemas.GeoVideo]:
    query_result = (
        db.query(schemas.GeoVideo)
        .filter(schemas.GeoVideo.capture_id == capture_id)
        .all()
    )
    return query_result


def get_user_by_email(email: str, db: Session) -> Optional[schemas.User]:
    query_result = db.query(schemas.User).filter(schemas.User.email == email).all()
    assert len(query_result) <= 1
    if len(query_result):
        return query_result[0]
    else:
        return None


def get_user_for_token(token: str, db: Session) -> Optional[schemas.User]:
    query_result = (
        db.query(schemas.User).filter(schemas.User.current_token == token).all()
    )
    assert len(query_result) <= 1
    if len(query_result):
        return query_result[0]
    else:
        return None


def update_user(user: schemas.User, db: Session):
    db_user = db.query(schemas.User).filter(schemas.User.email == user.email).first()
    db_user.email = user.email
    db_user.password_hash = user.password_hash
    db_user.salt = user.salt
    db_user.current_token = user.current_token
    db_user.token_expiry = user.token_expiry
    db.commit()


def init_geocapture(capture_id, fs: FS):
    fs.makedir(capture_id, recreate=True)
    capture_fs = fs.opendir(capture_id)
    capture_fs.makedir("images", recreate=True)
    capture_fs.makedirs("videos", recreate=True)
    capture_fs.makedirs("chunks", recreate=True)


def add_capture_chunk(geocapture_chunk: GeoCaptureChunk, db: Session, fs: FS) -> str:
    capture_id = geocapture_chunk.identifier
    chunk_index = geocapture_chunk.chunk_index
    chunk_bytes = geocapture_chunk.SerializeToString()
    fs.opendir(capture_id).opendir("chunks").writebytes(
        f"{chunk_index}.cap", chunk_bytes
    )

    positions = []
    waypoints = []
    for photo in geocapture_chunk.photos:
        if photo.HasField("gps"):
            positions.append(
                (
                    photo.gps.position.latitude,
                    photo.gps.position.longitude,
                    photo.gps.position.elevation,
                )
            )
    if geocapture_chunk.HasField("gps"):
        last_reading_time = None
        for reading in geocapture_chunk.gps.readings:
            positions.append(
                (
                    reading.position.latitude,
                    reading.position.longitude,
                    reading.position.elevation,
                )
            )
            if (
                last_reading_time is None
                or reading.epoch_micro_seconds - last_reading_time
                > WAYPOINT_MIN_TIME_DELTA_SECONDS * 1_000_000
            ):
                waypoints.append(
                    models.GeoPosition(
                        latitude=reading.position.latitude,
                        longitude=reading.position.longitude,
                        elevation=reading.position.elevation,
                    )
                )
                last_reading_time = reading.epoch_micro_seconds
    positions = np.array(positions, dtype=np.float64)
    bbox_min = GeoPosition(
        latitude=np.min(positions[:, 0]),
        longitude=np.min(positions[:, 1]),
        elevation=np.min(positions[:, 2]),
    )
    bbox_max = GeoPosition(
        latitude=np.max(positions[:, 0]),
        longitude=np.max(positions[:, 1]),
        elevation=np.max(positions[:, 2]),
    )

    db_geovideo = schemas.GeoCaptureChunk(
        chunk_index=chunk_index,
        capture_id=capture_id,
        waypoints=json.dumps([pos.model_dump(mode="json") for pos in waypoints]),
        latitude_min=bbox_min.latitude,
        longitude_min=bbox_min.longitude,
        latitude_max=bbox_max.latitude,
        longitude_max=bbox_max.longitude,
    )
    db.add(db_geovideo)
    db.commit()

    print(f"wrote capture file: {capture_id}.cap")


def add_photo_from_bytes(
    image_bytes: bytes,
    capture_id: str,
    photo_id: str,
    position: GeoPosition,
    db: Session,
    fs: FS,
    make_thumbnail: bool = False,
    data_format: str = "jpg",
) -> None:
    nparr = np.frombuffer(image_bytes, np.uint8)
    fs.opendir(capture_id).opendir("images").writebytes(
        f"{photo_id}.{data_format}", image_bytes
    )
    logger.info(f"Saved image with id {photo_id}")
    if make_thumbnail:
        img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
        scaling_factor = 100 / max(img.shape[:2])
        thumbnail = cv2.resize(img, None, fx=scaling_factor, fy=scaling_factor)
        thumbnail_bytes = cv2.imencode(f".{THUMBNAIL_FORMAT}", thumbnail)[1].tobytes()
        fs.opendir(capture_id).writebytes(
            f"thumbnail.{THUMBNAIL_FORMAT}", thumbnail_bytes
        )
        logger.info(
            f"Created and saved thumbnail for capture {capture_id} using image {photo_id}"
        )

    db_geophoto = schemas.GeoPhoto(
        photo_id=photo_id,
        capture_id=capture_id,
        latitude=position.latitude,
        longitude=position.longitude,
        elevation=position.elevation,
        data_format=data_format,
    )
    db.add(db_geophoto)
    db.commit()


def add_video_from_bytes(
    video_bytes: bytes,
    capture_id: str,
    video_id: str,
    waypoints: list[GeoPosition],
    db: Session,
    fs: FS,
    bbox_min: GeoPosition | None = None,
    bbox_max: GeoPosition | None = None,
    make_thumbnail: bool = False,
    data_format: str = "jpg",
) -> None:
    fs.opendir(capture_id).opendir("videos").writebytes(
        f"{video_id}.{data_format}", video_bytes
    )
    logger.info(f"Stored video with id {video_id}")

    if bbox_min is None:
        bbox_min = GeoPosition(
            latitude=min(pos.latitude for pos in waypoints),
            longitude=min(pos.longitude for pos in waypoints),
            elevation=min(pos.elevation for pos in waypoints),
        )
    if bbox_max is None:
        bbox_max = GeoPosition(
            latitude=max(pos.latitude for pos in waypoints),
            longitude=max(pos.longitude for pos in waypoints),
            elevation=max(pos.elevation for pos in waypoints),
        )
    db_geovideo = schemas.GeoVideo(
        video_id=video_id,
        capture_id=capture_id,
        waypoints=json.dumps([pos.model_dump(mode="json") for pos in waypoints]),
        latitude_min=bbox_min.latitude,
        longitude_min=bbox_min.longitude,
        latitude_max=bbox_max.latitude,
        longitude_max=bbox_max.longitude,
        data_format=data_format,
    )
    db.add(db_geovideo)
    db.commit()


def read_thumbnail_bytes(capture_id: str, fs: FS) -> bytes:
    return fs.opendir(capture_id).readbytes(f"thumbnail.{THUMBNAIL_FORMAT}")


def read_photo_bytes(capture_id: str, file_name: str, fs: FS) -> bytes:
    return fs.opendir(capture_id).opendir("images").readbytes(file_name)
