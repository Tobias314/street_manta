import os
from pathlib import Path


def get_datastore_path() -> str:
    path = os.getenv("DATASTORE_PATH")
    if path is None:
        file_dir = Path(os.path.realpath(__file__)).parent
        path = str(file_dir / "../../../street_manta_datastore")
    print(f"Using datastore path: {path}")
    return path


DATASTORE_PATH = get_datastore_path()
