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


class GeoPhoto(Base):
    __tablename__ = "geo_photos"
    id = mapped_column(Integer, primary_key=True, autoincrement=True)
    image_id = mapped_column(String)
    user_id = mapped_column(ForeignKey("users.email"))
    user = relationship("User")
    latitude = mapped_column(Float)
    longitude = mapped_column(Float)
    elevation = mapped_column(Integer)
    pitch = mapped_column(Float)
    roll = mapped_column(Float)
    yaw = mapped_column(Float)
    description = mapped_column(String)


class RTreeLocation(Base):
    __tablename__ = "geo_photos_rtree"
    id = mapped_column(Integer, primary_key=True)
    latitude_min = mapped_column(Float)
    latitude_max = mapped_column(Float)
    longitude_min = mapped_column(Float)
    longitude_max = mapped_column(Float)
