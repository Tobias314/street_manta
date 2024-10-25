from io import BytesIO
import sys
from pathlib import Path


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


def create_geophoto(
    img_id: str, token: str, longitude: float = 0.0, latitude: float = 0.0
):
    response = client.post(
        "/api/geophoto/create",
        json={
            "latitude": longitude,
            "longitude": latitude,
            "elevation": 0,
            "pitch": 0.0,
            "roll": 0.0,
            "yaw": 0.0,
            "description": "test",
            "image_id": img_id,
        },
        headers={"Authorization": f"Bearer {token}"},
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


def test_end_to_end():
    create_user("tester@example.com", "password")
    token = get_token("tester@example.com", "password")
    img_id = upload_image(token=token)
    create_geophoto(img_id, longitude=0.5, latitude=0.5, token=token)
    img_id = upload_image(token=token)
    create_geophoto(img_id, longitude=1.0, latitude=2.0, token=token)
    img_id = upload_image(token=token)
    create_geophoto(img_id, longitude=3.0, latitude=3.0, token=token)
    region_res = client.get(
        "/api/geophoto/get_for_region/0.0,0.0,2.5,2.5",
        headers={"Authorization": f"Bearer {token}"},
    )
    assert len(region_res.json()) == 2
