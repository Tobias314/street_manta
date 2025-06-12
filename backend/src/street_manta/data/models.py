from pydantic import BaseModel


class CreateAccountRequest(BaseModel):
    email: str
    password: str


class User(BaseModel):
    id: int
    email: str
    salt: str
    password_hash: str
    current_token: str = ""
    token_expiry: float = 0


class GeoCaptureModel(BaseModel):
    capture_id: str
    bbox_min: tuple[float, float, float]  # (latitude_min, longitude_min, elevation_min)
    bbox_max: tuple[float, float, float]  # (latitude_max, longitude_max, elevation_max)
    positions: list[tuple[float, float, float]]  # List of (latitude, longitude, elevation) for individual photos
    waypoints: list[tuple[float, float, float]] | None  # List of (latitude, longitude, elevation) points along a continuous capture (video)
    description: str = ""


# class GeoPhotoCreate(BaseGeoPhoto):
#     pass


# class GeoPhoto(BaseGeoPhoto):
#     id: int
