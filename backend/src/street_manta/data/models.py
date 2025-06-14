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


class GeoPosition(BaseModel):
    latitude: float
    longitude: float
    elevation: float
    
    def __iter__(self):
        return iter((self.latitude, self.longitude, self.elevation))
    
class GeoCapturePhoto(BaseModel):
    photo_id: str
    position: GeoPosition
    url: str
    
class GeoCaptureVideo(BaseModel):
    video_id: str
    waypoints: list[GeoPosition]
    url: str

class GeoCaptureDescriptor(BaseModel):
    capture_id: str
    bbox_min: GeoPosition  # (latitude_min, longitude_min, elevation_min)
    bbox_max: GeoPosition  # (latitude_max, longitude_max, elevation_max)
    photos: list[GeoCapturePhoto] = []
    video: GeoCaptureVideo | None = (
        None  # Identifier for the video associated with the capture, if any
    )
    thumbnail_url: str | None = None  # URL for the thumbnail image of the capture
    description: str = ""


# class GeoPhotoCreate(BaseGeoPhoto):
#     pass


# class GeoPhoto(BaseGeoPhoto):
#     id: int
