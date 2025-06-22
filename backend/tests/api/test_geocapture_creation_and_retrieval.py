import asyncio
from io import BytesIO
import shutil
import sys
from pathlib import Path
import time

from upath import UPath

from street_manta.protobufs import geo_capture_pb2


sys.path.append("./")

from fastapi.datastructures import FormData
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from fastapi.testclient import TestClient
from fs.memoryfs import MemoryFS
from fs.osfs import OSFS

from street_manta.server import app, get_db, get_fs, get_storage_path
from street_manta.tools.create_db import create_database
from street_manta.data.schemas import User

from street_manta.utils import create_single_photo_geocapture_proto
from street_manta.utils import create_video_geocapture_proto


TEST_STORAGE_PATH = Path(__file__).parent.parent.parent.parent / "test_datastore"
IMAGE_FS = None


def setup_module(module):
    """setup any state specific to the execution of the given module."""
    TEST_STORAGE_PATH.mkdir(parents=True, exist_ok=True)
    create_database(TEST_STORAGE_PATH / "test_database.db", overwrite=True)
    global IMAGE_FS
    IMAGE_FS = OSFS(str(TEST_STORAGE_PATH))


def teardown_module(module):
    """teardown any state that was previously setup with a setup_module
    method.
    """
    shutil.rmtree(TEST_STORAGE_PATH, ignore_errors=True)


SQLALCHEMY_DATABASE_URL = f"sqlite:///{str(TEST_STORAGE_PATH)}/test_database.db"
engine = create_engine(
    SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False}
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

async def override_get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


async def override_get_fs():
    yield IMAGE_FS


async def override_get_storage_path() -> UPath:
    yield UPath(TEST_STORAGE_PATH)


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
app.dependency_overrides[get_storage_path] = override_get_storage_path
# app.dependency_overrides[get_current_user] = override_get_current_user


def get_token(email: str, password: str):
    response = client.post(
        "/api/token", data=FormData({"username": email, "password": password})
    )
    assert response.status_code == 200
    return response.json()["access_token"]


def create_user(email: str, password: str):
    client.post("/api/account", json={"email": email, "password": password})


def upload_geocapture_chunk(
    token: str, geocapture_chunk: geo_capture_pb2.GeoCaptureChunk
):
    response = client.post(
        f"/api/upload_geocapture_chunk/",
        headers={"Authorization": f"Bearer {token}"},
        files={
            "geocapture": (
                "geocapture_chunk.cap",
                BytesIO(geocapture_chunk.SerializeToString()),
                "application/zip",
            )
        },
    )
    print('Response:', response.text)
    assert response.status_code == 200
    return response.json()


def test_geocapture_end_to_end():
    create_user("tester@example.com", "password")
    token = get_token("tester@example.com", "password")
    upload_geocapture_chunk(
        token=token,
        geocapture_chunk=create_single_photo_geocapture_proto(
            "capture_1", longitude=0.5, latitude=0.5
        ),
    )
    upload_geocapture_chunk(
        token=token,
        geocapture_chunk=create_single_photo_geocapture_proto(
            "capture_2", longitude=1.0, latitude=2.0
        ),
    )
    upload_geocapture_chunk(
        token=token,
        geocapture_chunk=create_single_photo_geocapture_proto(
            "capture_3", longitude=3.0, latitude=3.0
        ),
    )

    video_chunk1_num_positions = 50
    video_chunk1_positions = []
    start, end = 0.0, 1.5
    for i in range(video_chunk1_num_positions):
        coord = start + (end-start) * i / (video_chunk1_num_positions)
        video_chunk1_positions.append((coord, coord, 100.0))
    video_capture_chunk1 = create_video_geocapture_proto(
        capture_id="video_capture_1",
        positions=video_chunk1_positions,
        chunk_index=0,
        is_last_chunk=False,
    )
    upload_geocapture_chunk(token=token, geocapture_chunk=video_capture_chunk1)
    video_chunk2_num_positions = 50
    video_chunk2_positions = []
    start, end = 2.0, 3.5
    for i in range(video_chunk2_num_positions):
        coord = start + (end-start) * i / (video_chunk2_num_positions)
        video_chunk2_positions.append((coord, coord, 100.0))
    video_capture_chunk2 = create_video_geocapture_proto(
        capture_id="video_capture_1",
        positions=video_chunk2_positions,
        chunk_index=1,
        is_last_chunk=True,
    )
    upload_geocapture_chunk(token=token, geocapture_chunk=video_capture_chunk2)

    region_res = client.get(
        "/api/geocaptures_for_region/0.0,0.0,2.5,2.5",
        headers={"Authorization": f"Bearer {token}"},
    )
    print(region_res.json())
    assert len(region_res.json()) == 3
    
    # Test downloading a geocapture
    download_res = client.get(
        "/api/geocaptures/capture_1/download",
        headers={"Authorization": f"Bearer {token}"},
    )
    assert download_res.status_code == 200