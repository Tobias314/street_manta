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


class BaseGeoPhoto(BaseModel):
    image_id: str
    latitude: float
    longitude: float
    elevation: float
    pitch: float
    roll: float
    yaw: float
    description: str = ""


class GeoPhotoCreate(BaseGeoPhoto):
    pass


class GeoPhoto(BaseGeoPhoto):
    id: int
