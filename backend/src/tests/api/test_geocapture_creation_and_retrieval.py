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

from street_manta.server import app, get_db, get_image_fs
from street_manta.tools.create_db import create_database
from street_manta.data.schemas import User


client = TestClient(app)


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


async def override_get_image_fs():
    yield IMAGE_FS


async def override_get_current_user():
    yield User(
        email="tester@tester.com",
        password_hash="password",
        salt="salt",
        current_token="current_token",
        token_expiry=1719266029000,
    )


app.dependency_overrides[get_db] = override_get_db
app.dependency_overrides[get_image_fs] = override_get_image_fs
# app.dependency_overrides[get_current_user] = override_get_current_user


def setup_module(module):
    """setup any state specific to the execution of the given module."""
    create_database(Path("./test_database.db"), overwrite=True)
    global IMAGE_FS
    IMAGE_FS = MemoryFS()


def upload_image(token: str):
    img = (np.arange(10000).reshape(100, 100) / 10000 * 255).astype(np.uint8)
    success, encoded_image = cv2.imencode(".png", img)
    img_bytes = encoded_image.tobytes()
    response = client.post(
        "/api/geophoto/upload_image",
        files={"image": ("test_image.png", BytesIO(img_bytes), "image/png")},
        headers={"Authorization": f"Bearer {token}"},
    )
    assert response.status_code == 200
    print(response.json())
    return response.json()


def create_single_photo_geocapture(
    img: np.ndarray = None,
    longitude: float = 0.0,
    latitude: float = 0.0,
    elevation: float = 0.0,
    roll: float = 0.0,
    pitch: float = 0.0,
    yaw: float = 0.0,
    device: str = "test_device",
    description: str = "test photo",
    tags=None,
    trace_identifier: str = "trace_1",
    chunk_index: int = 0,
    is_last_chunk: bool = True,
    version: int = 1,
):
    if tags is None:
        tags = []
    if img is None:
        img = np.zeros((100, 100, 3), dtype=np.uint8)
    success, encoded_image = cv2.imencode(".jpg", img)
    img_bytes = encoded_image.tobytes() if success else b""
    now_us = int(time.time() * 1e6)
    gps_reading = geo_capture_pb2.GpsReading(
        epoch_micro_seconds=now_us,
        position=geo_capture_pb2.GpsPosition(
            longitude=longitude,
            latitude=latitude,
            elevation=elevation,
        ),
    )
    orientation_reading = geo_capture_pb2.OrientationReading(
        epoch_micro_seconds=now_us,
        orientation=geo_capture_pb2.Orientation(
            roll=roll,
            pitch=pitch,
            yaw=yaw,
        ),
    )
    photo = geo_capture_pb2.PhotoCapture(
        epoch_micro_seconds=now_us,
        format="jpg",
        data=img_bytes,
        gps=gps_reading,
        orientation=orientation_reading,
    )
    chunk = geo_capture_pb2.GeoCaptureChunk(
        device=device,
        photos=[photo],
        description=description,
        tags=tags,
        trace_identifier=trace_identifier,
        timestamp_epoch_micro_seconds=now_us,
        chunk_index=chunk_index,
        is_last_chunk=is_last_chunk,
        version=version,
    )
    return chunk


def upload_single_photo_geocapture(
    capture_id: str, token: str, longitude: float = 0.0, latitude: float = 0.0
):
    geocapture_chunk = create_single_photo_geocapture(longitude=longitude, latitude=latitude)
    response = client.post(
        f"/api/geocaptures/upload/{capture_id}",
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


def get_token(email: str, password: str):
    response = client.post(
        "/api/token", data=FormData({"username": email, "password": password})
    )
    assert response.status_code == 200
    return response.json()["access_token"]


def create_user(email: str, password: str):
    client.post("/api/account", json={"email": email, "password": password})


def test_single_photo_end_to_end():
    create_user("tester@example.com", "password")
    token = get_token("tester@example.com", "password")
    #img_id = upload_image(token=token)
    upload_single_photo_geocapture("capture_1", longitude=0.5, latitude=0.5, token=token)
    #img_id = upload_image(token=token)
    upload_single_photo_geocapture("capture_2", longitude=1.0, latitude=2.0, token=token)
    #img_id = upload_image(token=token)
    upload_single_photo_geocapture("capture_3", longitude=3.0, latitude=3.0, token=token)
    region_res = client.get(
        "/api/geocaptures/get_for_region/0.0,0.0,2.5,2.5",
        headers={"Authorization": f"Bearer {token}"},
    )
    assert len(region_res.json()) == 2
