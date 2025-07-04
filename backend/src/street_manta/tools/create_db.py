import contextlib
from io import BytesIO
import os
import argparse
import asyncio

import cv2
from fastapi import UploadFile
import numpy as np
from sqlalchemy import create_engine, text

from street_manta.utils import create_video_geocapture_proto

from ..server import finalize_geocapture, get_fs, get_storage_path, ingest_geocapture_chunk, upload_geo_capture

from ..data.models import GeoCaptureDescriptor, GeoCapturePhoto, GeoPosition
from ..data.schemas import Base, SessionLocal
from ..data.storage_interface import (
    init_geocapture,
    add_photo_from_bytes,
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
    Base.metadata.tables["geocapture_chunks"].create(engine)
    Base.metadata.tables["geophotos"].create(engine)
    Base.metadata.tables["geovideos"].create(engine)
    Base.metadata.tables["users"].create(engine)
    with engine.connect() as con:
        statement = text(
            "CREATE VIRTUAL TABLE geocaptures_rtree USING rtree(id, latitude_min, latitude_max, longitude_min, longitude_max, +capture_id TEXT);"
        )
        con.execute(statement)


def create_example_database(path: Path, overwrite: bool = False):
    create_database(path=path, overwrite=overwrite)
    print("Adding example GeoPhotos to database...")
    db = SessionLocal()
    tester_user = asyncio.run(create_user(email="test", password="test", db=db))
    storage_path = get_storage_path()
    with contextlib.contextmanager(get_fs)() as fs:
        # Add 5 single photo geocaptures
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
            add_photo_from_bytes(
                img_bytes,
                capture_id=capture_id,
                photo_id=0,
                position=pos,
                fs=fs,
                db=db,
                data_format="png",
                make_thumbnail=True,
            )
            create_geocapture_from_model(
                db=db,
                geocapture=GeoCaptureDescriptor(
                    capture_id=capture_id,
                    bbox_min=pos,
                    bbox_max=pos,
                    photos=[
                        GeoCapturePhoto(
                            photo_id="photo_{0}",
                            position=pos,
                            url=f"images/{capture_id}/0.png",
                        )
                    ],
                    description="example single photo capture",
                ),
                user=tester_user,
            )
        # Add 1 video geocapture
        capture_id = "example_video_capture"
        start_position = (51.813571, 12.215657)
        end_position = (51.822251, 12.215679)
        num_positions = 300
        video_positions = [
            (
                start_position[0]
                + (end_position[0] - start_position[0]) * i / num_positions,
                start_position[1]
                + (end_position[1] - start_position[1]) * i / num_positions,
                100.0,
            )
            for i in range(num_positions)
        ]
        video_capture_proto = create_video_geocapture_proto(
            capture_id=capture_id, positions=video_positions
        )
        ingest_geocapture_chunk(
            geocapture=video_capture_proto,
            fs=fs,
            db=db,
        )
        if video_capture_proto.is_last_chunk:
            finalize_geocapture(
                user_token=tester_user.current_token,
                capture_id=video_capture_proto.identifier,
                storage_path=storage_path,
                db=db,
                description=video_capture_proto.description,
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
