import logging
from tempfile import TemporaryDirectory
import time

import cv2
from fastapi import FastAPI, Request, status
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
import numpy as np
from street_manta.protobufs import geo_capture_pb2

logger = logging.getLogger(__name__)


def register_exception(app: FastAPI):
    @app.exception_handler(RequestValidationError)
    async def validation_exception_handler(
        request: Request, exc: RequestValidationError
    ):
        exc_str = f"{exc}".replace("\n", " ").replace("   ", " ")
        # or logger.error(f'{exc}')
        logger.error(request, exc_str)
        content = {"status_code": 10422, "message": exc_str, "data": None}
        return JSONResponse(
            content=content, status_code=status.HTTP_422_UNPROCESSABLE_ENTITY
        )


def create_single_photo_geocapture_proto(
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


def encode_video(
    frames: list[np.ndarray], fps: int = 30, size: tuple[int, int] = (640, 480)
) -> bytes:
    with TemporaryDirectory() as temp_dir:
        video_path = f"{temp_dir}/output.mp4"
        out = cv2.VideoWriter(
            video_path, cv2.VideoWriter_fourcc(*"mp4v"), fps, size, False
        )
        for frame in frames:
            out.write(frame)
        out.release()
        video_bytes = open(video_path, "rb").read()
    return video_bytes


def create_video_geocapture_proto(
    positions: list[tuple[float, float, float]],
    frames: list[np.ndarray] | None = None,
    start_epoch_us: int | None = None,
    device: str = "test_device",
    description: str = "test photo",
    tags=None,
    trace_identifier: str = "trace_1",
    chunk_index: int = 0,
    is_last_chunk: bool = True,
    version: int = 1,
    fps: int = 30,
) -> geo_capture_pb2.GeoCaptureChunk:
    if tags is None:
        tags = []
    if frames is None:
        video_res = (1920, 1080)
        frames = []
        for i, pos in enumerate(positions):
            frame = np.zeros((video_res[1], video_res[0], 3), dtype=np.uint8)
            intensity = i * 255 // len(positions)
            frame[:] = (intensity, intensity, intensity)
            cv2.putText(
                frame,
                f"Position: {positions[i]}",
                (10, 30),
                cv2.FONT_HERSHEY_SIMPLEX,
                1,
                (255, 255, 255),
                2,
            )
            frames.append(frame)
    video_bytes = encode_video(
        frames, fps=fps, size=(frames[0].shape[1], frames[0].shape[0])
    )
    if start_epoch_us is None:
        start_epoch_us = int((time.time() - len(positions) / fps) * 1e6)
    timestamps = [int(start_epoch_us + i * 1e6 / fps) for i in range(len(frames))]
    video_capture = geo_capture_pb2.VideoCapture(
        start_epoch_micro_seconds=timestamps[0],
        frame_epochs_micro_seconds=timestamps,
        format="mp4",
        data=video_bytes,
    )

    gps_readings = []
    for pos, ts in zip(positions, timestamps):
        gps_reading = geo_capture_pb2.GpsReading(
            epoch_micro_seconds=int(ts),
            position=geo_capture_pb2.GpsPosition(
                longitude=float(pos[0]),
                latitude=float(pos[1]),
                elevation=float(pos[2]),
            ),
        )
        gps_readings.append(gps_reading)
    chunk = geo_capture_pb2.GeoCaptureChunk(
        device=device,
        video=video_capture,
        gps=geo_capture_pb2.GpsCapture(readings=gps_readings),
        description=description,
        tags=tags,
        trace_identifier=trace_identifier,
        chunk_index=chunk_index,
        is_last_chunk=is_last_chunk,
        version=version,
    )
    return chunk
