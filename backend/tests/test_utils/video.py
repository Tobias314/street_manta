from tempfile import TemporaryDirectory
import time

import numpy as np
import cv2

from street_manta.protobufs import geo_capture_pb2


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


def create_video_geocapture(
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
        frames = [np.zeros((100, 100, 3), dtype=np.uint8) for p in positions]
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
