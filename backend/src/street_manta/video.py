from pathlib import Path
from tempfile import TemporaryDirectory
from street_manta.data.storage_interface import THUMBVIDEO_FORMAT
from upath import UPath
import ffmpeg

from .protobufs.geo_capture_pb2 import GeoCaptureChunk


def concatenate_video_chunks(
    chunk_paths: list[UPath], output_path: UPath, downsampled_path: UPath | None
) -> bool:
    """
    Concatenate multiple video chunks into a single video file.

    Args:
        chunk_paths (list[UPath]): List of paths to video chunk files.
        video_path (UPath): Path where the concatenated video will be saved.
    """
    with TemporaryDirectory() as temp_dir:
        video_chunk_paths = []
        for i, chunk_path in enumerate(chunk_paths):
            chunk = GeoCaptureChunk()
            with chunk_path.open("rb") as f:
                chunk.ParseFromString(f.read())
            if not chunk.HasField("video"):
                continue
            video_format = chunk.video.format
            video_chunk_path = Path(temp_dir) / f"{i}.{video_format}"
            video_chunk_path.write_bytes(chunk.video.data)
            video_chunk_paths.append(video_chunk_path)
        if len(video_chunk_paths) == 0:
            return False
        inputs = [ffmpeg.input(str(f)) for f in video_chunk_paths]
        concatenated = ffmpeg.concat(*inputs)
        output = ffmpeg.output(concatenated, str(output_path))
        ffmpeg.run(ffmpeg.overwrite_output(output))
        if downsampled_path is not None:
            ffmpeg.input(output_path).output(
                str(downsampled_path), vf="scale=480:-1", format=THUMBVIDEO_FORMAT
            ).overwrite_output().run()
    return True
