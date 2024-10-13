from typing import List, Optional
from uuid import uuid4
import logging
from fs.base import FS

import cv2
import numpy as np
from sqlalchemy.orm import Session
from sqlalchemy import select
from . import schemas
from .models import GeoPhotoCreate, User

logger = logging.getLogger(__name__)


def create_geophoto(db: Session, geophoto: GeoPhotoCreate, user: User) -> int:
    # with db.begin():
    db_geophoto = schemas.GeoPhoto(
        image_id=geophoto.image_id,
        user=user,
        latitude=geophoto.latitude,
        longitude=geophoto.longitude,
        elevation=geophoto.elevation,
        pitch=geophoto.pitch,
        roll=geophoto.roll,
        yaw=geophoto.yaw,
        description=geophoto.description,
    )
    db.add(db_geophoto)
    db.flush()
    geophoto_id = db_geophoto.id
    rtree_location = schemas.RTreeLocation(
        id=geophoto_id,
        latitude_min=geophoto.latitude,
        latitude_max=geophoto.latitude,
        longitude_min=geophoto.longitude,
        longitude_max=geophoto.longitude,
    )
    db.add(rtree_location)
    db.commit()
    return geophoto_id


def create_user(user: schemas.User, db: Session) -> None:
    db.add(user)
    db.commit()


def get_geophotos_for_region(
    lat_min: float,
    lon_min: float,
    lat_max: float,
    lon_max: float,
    db: Session,
    user: Optional[schemas.User] = None,
) -> List[schemas.GeoPhoto]:
    query = (
        select(schemas.GeoPhoto)
        .where(
            (schemas.RTreeLocation.latitude_max >= lat_min)
            & (schemas.RTreeLocation.latitude_min <= lat_max)
            & (schemas.RTreeLocation.longitude_max >= lon_min)
            & (schemas.RTreeLocation.longitude_min <= lon_max)
        )
        .join_from(
            schemas.GeoPhoto,
            schemas.RTreeLocation,
            onclause=schemas.GeoPhoto.id == schemas.RTreeLocation.id,
        )
    )
    if user:
        query = query.where(schemas.GeoPhoto.user_id == user.email)
    res = [gp[0] for gp in db.execute(query).all()]
    return res


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


def save_image_from_bytes(
    image_bytes: bytes, image_id: str, image_fs: FS, create_thumbnail: bool = True
) -> str:
    nparr = np.fromstring(image_bytes, np.uint8)
    image_fs.writebytes(f"{image_id}.jpg", image_bytes)
    logger.info(f"Saved image with {image_id}")
    if create_thumbnail:
        img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
        scaling_factor = 100 / max(img.shape[:2])
        thumbnail = cv2.resize(img, None, fx=scaling_factor, fy=scaling_factor)
        thumbnail_bytes = cv2.imencode(".png", thumbnail)[1].tobytes()
        image_fs.writebytes(f"{image_id}_thumbnail.png", thumbnail_bytes)
        logger.info(f"Saved thumbnail with {image_id}")
    return image_id
