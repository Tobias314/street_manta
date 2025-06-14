import contextlib
import os
import argparse
import asyncio

import cv2
import numpy as np
from sqlalchemy import create_engine, text

from ..server import get_fs

from ..data.models import GeoCaptureDescriptor, GeoCapturePhoto, GeoPosition
from ..data.schemas import Base, SessionLocal
from ..data.storage_interface import (
    init_geocapture,
    write_photo_from_bytes,
    create_geocapture_from_model,
)
from ..globals import DATASTORE_PATH
from ..authentication import create_user

from pathlib import Path


def create_database(path: Path, overwrite: bool = False):
    print(f"Creating database at {path} ...")
    if path.exists():
        if overwrite:
            print("Database already exists, removing it")
            path.unlink()
        else:
            print(
                "Database already exists, and overwrite is not set. Using the existing database."
            )
            return
    print("Creating database...")
    engine = create_engine(
        f"sqlite:///{str(path)}", connect_args={"check_same_thread": False}
    )
    Base.metadata.tables["geocaptures"].create(engine)
    Base.metadata.tables["geophotos"].create(engine)
    Base.metadata.tables["users"].create(engine)
    with engine.connect() as con:
        statement = text(
            "CREATE VIRTUAL TABLE geo_photos_rtree USING rtree(id, latitude_min, latitude_max, longitude_min, longitude_max);"
        )
        con.execute(statement)
    with contextlib.contextmanager(get_fs)() as fs:
        fs.makedir("images", recreate=True)
        fs.makedir("videos", recreate=True)
        fs.makedir("captures", recreate=True)


def create_example_database(path: Path, overwrite: bool = False):
    create_database(path=path, overwrite=overwrite)
    print("Adding example GeoPhotos to database...")
    db = SessionLocal()
    tester_user = asyncio.run(create_user(email="test", password="test", db=db))
    with contextlib.contextmanager(get_fs)() as fs:
        for i in range(5):
            capture_id = f"example_capture_{i}"
            init_geocapture(
                capture_id=capture_id,
                fs=fs,
            )
            img = (np.arange(1000000).reshape(1000, 1000) / 1000000 * 255).astype(
                np.uint8
            )
            _, encoded_image = cv2.imencode(".png", img)
            img_bytes = encoded_image.tobytes()
            pos = GeoPosition(
                latitude=51.8268 + i * 0.01,
                longitude=12.2371 + i * 0.01,
                elevation=100.0,
            )
            write_photo_from_bytes(img_bytes, capture_id=capture_id, photo_id=0, position=pos, fs=fs, db=db, data_format="png")
            create_geocapture_from_model(
                db=db,
                geocapture=GeoCaptureDescriptor(
                    capture_id=str(i),
                    bbox_min=pos,
                    bbox_max=pos,
                    photos=[GeoCapturePhoto(photo_id="photo_{0}", position=pos, url=f"images/{capture_id}/0.png")],
                    description="example single photo capture",
                ),
                user=tester_user,
            )


def __main__(args):
    print(os.getcwd())
    p = Path(f"{DATASTORE_PATH}/database.db")
    p.parent.mkdir(parents=True, exist_ok=True)
    images_dir = p.parent / "images"
    print("Images dir:", images_dir)
    images_dir.mkdir(parents=True, exist_ok=True)

    if args.example:
        create_example_database(p, overwrite=args.overwrite)
    else:
        create_database(p, overwrite=args.overwrite)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Helper tool for database schema creation"
    )
    parser.add_argument(
        "-e",
        "--example",
        help="Create database with example values",
        default=False,
        action="store_true",
    )
    parser.add_argument(
        "--overwrite",
        help="Overwrite existing database",
        default=False,
        action="store_true",
    )
    args = parser.parse_args()
    __main__(args)
