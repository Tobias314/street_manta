from io import BytesIO
import sys
from pathlib import Path
import time

from street_manta.protobufs import geo_capture_pb2


sys.path.append("./")

from fastapi.datastructures import FormData
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import numpy as np
import cv2
from fastapi.testclient import TestClient
from fs.memoryfs import MemoryFS

from street_manta.server import app, get_db, get_fs
from street_manta.tools.create_db import create_database
from street_manta.data.schemas import User

from ..test_utils.photo import create_single_photo_geocapture
from ..test_utils.video import create_video_geocapture


IMAGE_FS = None


async def override_get_db():
    SQLALCHEMY_DATABASE_URL = "sqlite:///./test_database.db"
    engine = create_engine(
        SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False}
    )
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


async def override_get_fs():
    yield IMAGE_FS


async def override_get_current_user():
    yield User(
        email="tester@tester.com",
        password_hash="password",
        salt="salt",
        current_token="current_token",
        token_expiry=1719266029000,
    )


client = TestClient(app)
app.dependency_overrides[get_db] = override_get_db
app.dependency_overrides[get_fs] = override_get_fs
# app.dependency_overrides[get_current_user] = override_get_current_user


def setup_module(module):
    """setup any state specific to the execution of the given module."""
    create_database(Path("./test_database.db"), overwrite=True)
    global IMAGE_FS
    IMAGE_FS = MemoryFS()


def get_token(email: str, password: str):
    response = client.post(
        "/api/token", data=FormData({"username": email, "password": password})
    )
    assert response.status_code == 200
    return response.json()["access_token"]


def create_user(email: str, password: str):
    client.post("/api/account", json={"email": email, "password": password})


def upload_geocapture_chunk(
    capture_id: str, token: str, geocapture_chunk: geo_capture_pb2.GeoCaptureChunk
):
    response = client.post(
        f"/api/geocaptures/{capture_id}",
        headers={"Authorization": f"Bearer {token}"},
        files={
            "geocapture": (
                f"{capture_id}.cap",
                BytesIO(geocapture_chunk.SerializeToString()),
                "application/zip",
            )
        },
    )
    assert response.status_code == 200
    return response.json()


def test_single_photo_end_to_end():
    create_user("tester@example.com", "password")
    token = get_token("tester@example.com", "password")
    upload_geocapture_chunk(
        "capture_1",
        token=token,
        geocapture_chunk=create_single_photo_geocapture(longitude=0.5, latitude=0.5),
    )
    upload_geocapture_chunk(
        "capture_2",
        token=token,
        geocapture_chunk=create_single_photo_geocapture(longitude=1.0, latitude=2.0),
    )
    upload_geocapture_chunk(
        "capture_3",
        token=token,
        geocapture_chunk=create_single_photo_geocapture(longitude=3.0, latitude=3.0),
    )

    video_positions = [
        (0.5, 0.5, 100.0),
        (1.0, 1.0, 100.0),
        (1.5, 1.5, 100.0),
    ]
    video_capture = create_video_geocapture(positions=video_positions)
    upload_geocapture_chunk(
        "video_capture_1", token=token, geocapture_chunk=video_capture
    )

    region_res = client.get(
        "/api/geocaptures_for_region/0.0,0.0,2.5,2.5",
        headers={"Authorization": f"Bearer {token}"},
    )
    print(region_res.json())
    assert len(region_res.json()) == 3
