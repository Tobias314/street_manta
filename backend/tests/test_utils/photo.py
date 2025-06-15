import time

import numpy as np
import cv2

from street_manta.protobufs import geo_capture_pb2

def create_single_photo_geocapture(
    img: np.ndarray = None,
    longitude: float = 0.0,
    latitude: float = 0.0,
    elevation: float = 0.0,
    roll: float = 0.0,
    pitch: float = 0.0,
    yaw: float = 0.0,
    device: str = "test_device",
    description: str = "test photo",
    tags=None,
    trace_identifier: str = "trace_1",
    chunk_index: int = 0,
    is_last_chunk: bool = True,
    version: int = 1,
):
    if tags is None:
        tags = []
    if img is None:
        img = np.zeros((100, 100, 3), dtype=np.uint8)
    success, encoded_image = cv2.imencode(".jpg", img)
    img_bytes = encoded_image.tobytes() if success else b""
    now_us = int(time.time() * 1e6)
    gps_reading = geo_capture_pb2.GpsReading(
        epoch_micro_seconds=now_us,
        position=geo_capture_pb2.GpsPosition(
            longitude=longitude,
            latitude=latitude,
            elevation=elevation,
        ),
    )
    orientation_reading = geo_capture_pb2.OrientationReading(
        epoch_micro_seconds=now_us,
        orientation=geo_capture_pb2.Orientation(
            roll=roll,
            pitch=pitch,
            yaw=yaw,
        ),
    )
    photo = geo_capture_pb2.PhotoCapture(
        epoch_micro_seconds=now_us,
        format="jpg",
        data=img_bytes,
        gps=gps_reading,
        orientation=orientation_reading,
    )
    chunk = geo_capture_pb2.GeoCaptureChunk(
        device=device,
        photos=[photo],
        description=description,
        tags=tags,
        trace_identifier=trace_identifier,
        timestamp_epoch_micro_seconds=now_us,
        chunk_index=chunk_index,
        is_last_chunk=is_last_chunk,
        version=version,
        video=None,
    )
    return chunk