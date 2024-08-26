import os


def get_datastore_path() -> str:
    path = os.getenv("DATASTORE_PATH")
    if path is None:
        path = "../../street_manta_datastore"
    print(f"Using datastore path: {path}")
    return path


DATASTORE_PATH = get_datastore_path()
