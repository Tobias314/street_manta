from typing import List, Optional
import logging
import json

from fs.base import FS
import cv2
import numpy as np
from sqlalchemy.orm import Session
from sqlalchemy import select

from . import schemas
from .models import GeoCaptureDescriptor, GeoCapturePhoto, User, GeoPosition

logger = logging.getLogger(__name__)

THUMBNAIL_FORMAT = "jpg"


def create_geocapture_from_model(
    db: Session, geocapture: GeoCaptureDescriptor, user: User
) -> int:
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
    rtree_location = schemas.RTreeLocation(
        id=capture_id,
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
            (schemas.RTreeLocation.latitude_max >= lat_min)
            & (schemas.RTreeLocation.latitude_min <= lat_max)
            & (schemas.RTreeLocation.longitude_max >= lon_min)
            & (schemas.RTreeLocation.longitude_min <= lon_max)
        )
        .join_from(
            schemas.GeoCapture,
            schemas.RTreeLocation,
            onclause=schemas.GeoCapture.id == schemas.RTreeLocation.id,
        )
    )
    if user:
        query = query.where(schemas.GeoCapture.user_id == user.email)
    captures = [gp[0] for gp in db.execute(query).all()]
    return captures


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


def save_capture_chunk_bytes(
    capture_id: str, chunk_index: str, chunk_bytes: bytes, fs: FS
) -> str:
    fs.opendir(capture_id).writebytes(f"{chunk_index}.cap", chunk_bytes)
    print(f"wrote capture file: {capture_id}.cap")


def write_photo_from_bytes(
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
    logger.info(f"Saved image with {photo_id}")
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


def read_thumbnail_bytes(capture_id: str, fs: FS) -> bytes:
    return fs.opendir(capture_id).readbytes(f"thumbnail.{THUMBNAIL_FORMAT}")


def read_photo_bytes(capture_id: str, file_name: str, fs: FS) -> bytes:
    return fs.opendir(capture_id).opendir("images").readbytes(file_name)
