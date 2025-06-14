from sqlalchemy import ForeignKey, create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy import Integer, String, Float, Double
from sqlalchemy.orm import mapped_column, relationship

from ..globals import DATASTORE_PATH


SQLALCHEMY_DATABASE_URL = f"sqlite:///{DATASTORE_PATH}/database.db"
# SQLALCHEMY_DATABASE_URL = "postgresql://user:password@postgresserver/db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False}
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()


# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


class User(Base):
    __tablename__ = "users"
    email = mapped_column(String, primary_key=True)
    password_hash = mapped_column(
        String,
        unique=True,
        index=True,
    )
    salt = mapped_column(String)
    current_token = mapped_column(String)
    token_expiry = mapped_column(Double)


# class GeoPhoto(Base):
#     __tablename__ = "geo_photos"
#     id = mapped_column(Integer, primary_key=True, autoincrement=True)
#     image_id = mapped_column(String)
#     user_id = mapped_column(ForeignKey("users.email"))
#     user = relationship("User")
#     latitude = mapped_column(Float)
#     longitude = mapped_column(Float)
#     elevation = mapped_column(Integer)
#     pitch = mapped_column(Float)
#     roll = mapped_column(Float)
#     yaw = mapped_column(Float)
#     description = mapped_column(String)


class GeoCapture(Base):
    __tablename__ = "geocaptures"
    capture_id: str = mapped_column(String, primary_key=True)
    user_id: str = mapped_column(ForeignKey("users.email"))
    user: User = relationship("User")
    latitude_min: float = mapped_column(Float)
    longitude_min: float = mapped_column(Float)
    elevation_min: float = mapped_column(Float)
    latitude_max: float = mapped_column(Float)
    longitude_max: float = mapped_column(Float)
    elevation_max: float = mapped_column(Float)
    description: str = mapped_column(String)


class GeoPhoto(Base):
    __tablename__ = "geophotos"
    photo_id: str = mapped_column(String, primary_key=True)
    capture_id: str = mapped_column(
        ForeignKey("geocaptures.capture_id"), primary_key=True
    )
    capture: GeoCapture = relationship("GeoCapture")
    latitude: float = mapped_column(Float)
    longitude: float = mapped_column(Float)
    elevation: float = mapped_column(Float)
    data_format: str = mapped_column(String)  # e.g., "jpg", "png"


class GeoVideo(Base):
    __tablename__ = "geovideos"
    video_id = mapped_column(String, primary_key=True)
    capture_id = mapped_column(ForeignKey("geocaptures.capture_id"), primary_key=True)
    capture = relationship("GeoCapture")
    waypoints = mapped_column(String)  # JSON string for list of GeoPosition
    data_format = mapped_column(String)  # e.g., "mp4", "avi"


class RTreeLocation(Base):
    __tablename__ = "geo_photos_rtree"
    id = mapped_column(String, primary_key=True)
    latitude_min = mapped_column(Float)
    latitude_max = mapped_column(Float)
    longitude_min = mapped_column(Float)
    longitude_max = mapped_column(Float)
