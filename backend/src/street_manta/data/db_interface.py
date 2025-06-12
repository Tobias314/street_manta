from typing import List, Optional
from uuid import uuid4
import logging
import json

from fs.base import FS
import cv2
import numpy as np
from sqlalchemy.orm import Session
from sqlalchemy import select

from . import schemas
from .models import GeoCaptureModel, User
from ..protobufs.geo_capture_pb2 import PhotoCapture

logger = logging.getLogger(__name__)


def create_geocapture_from_model(
    db: Session, geocapture: GeoCaptureModel, user: User
) -> int:
    # with db.begin():
    data = {
        "positions": geocapture.positions,
        "waypoints": geocapture.waypoints,
    }
    db_geophoto = schemas.GeoCapture(
        capture_id=geocapture.capture_id,
        user=user,
        latitude_min=geocapture.bbox_min[0],
        longitude_min=geocapture.bbox_min[1],
        elevation_min=geocapture.bbox_min[2],
        latitude_max=geocapture.bbox_max[0],
        longitude_max=geocapture.bbox_max[1],
        elevation_max=geocapture.bbox_max[2],
        data=json.dumps(data),
        description=geocapture.description,
    )
    db.add(db_geophoto)
    db.flush()
    geophoto_id = db_geophoto.id
    rtree_location = schemas.RTreeLocation(
        id=geophoto_id,
        latitude_min=geocapture.bbox_min[0],
        latitude_max=geocapture.bbox_max[0],
        longitude_min=geocapture.bbox_min[1],
        longitude_max=geocapture.bbox_max[1],
    )
    db.add(rtree_location)
    db.commit()
    return geophoto_id


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
) -> List[GeoCaptureModel]:
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
    return [
        GeoCaptureModel(
            capture_id=capture.capture_id,
            bbox_min=(
                capture.latitude_min,
                capture.longitude_min,
                capture.elevation_min,
            ),
            bbox_max=(
                capture.latitude_max,
                capture.longitude_max,
                capture.elevation_max,
            ),
            positions=json.loads(capture.data)["positions"],
            waypoints=json.loads(capture.data)["waypoints"],
            description=capture.description,
        )
        for capture in captures
    ]


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


def save_image_from_bytes(
    image_bytes: bytes,
    capture_id: str,
    image_id: str,
    fs: FS,
    make_thumbnail: bool = False,
) -> str:
    nparr = np.frombuffer(image_bytes, np.uint8)
    fs.opendir(capture_id).opendir("images").writebytes(f"{image_id}.jpg", image_bytes)
    logger.info(f"Saved image with {image_id}")
    if make_thumbnail:
        img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
        scaling_factor = 100 / max(img.shape[:2])
        thumbnail = cv2.resize(img, None, fx=scaling_factor, fy=scaling_factor)
        thumbnail_bytes = cv2.imencode(".jpg", thumbnail)[1].tobytes()
        fs.opendir(capture_id).writebytes("thumbnail.jpg", thumbnail_bytes)
        logger.info(
            f"Created and saved thumbnail for capture {capture_id} using image {image_id}"
        )
    return image_id
