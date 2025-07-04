import os
from pathlib import Path

WAYPOINT_MIN_TIME_DELTA_SECONDS = 1

def get_datastore_path() -> str:
    path = os.getenv("DATASTORE_PATH")
    if path is None:
        file_dir = Path(os.path.realpath(__file__)).parent
        path = str(file_dir / "../../../street_manta_datastore")
    print(f"Using datastore path: {path}")
    return path


DATASTORE_PATH = get_datastore_path()

VIDEO_STORAGE_FORMAT = "mp4"

VIDEO_SERVING_CHUNK_SIZE = 1024*1024

BASE_URL = os.getenv("BASE_URL", None)