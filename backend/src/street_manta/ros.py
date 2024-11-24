from tempfile import TemporaryDirectory
from pathlib import Path
import zipfile
from typing import List

import numpy as np
import cv2
from scipy.spatial.transform import Rotation
from scipy.interpolate import interp1d
from rosbags.rosbag1 import Writer as Writer1
from rosbags.rosbag2 import Writer as Writer2
from rosbags.typesys import Stores, get_typestore
from rosbags.typesys.stores.ros1_noetic import (
    geometry_msgs__msg__Vector3 as Vector3_1,
    geometry_msgs__msg__Quaternion as Quaternion_1,
    sensor_msgs__msg__Imu as Imu1,
    builtin_interfaces__msg__Time as Time1,
    sensor_msgs__msg__CompressedImage as CompressedImage1,
    std_msgs__msg__Header as Header1,
)
from rosbags.typesys.stores.ros2_humble import (
    geometry_msgs__msg__Vector3 as Vector3_2,
    geometry_msgs__msg__Quaternion as Quaternion_2,
    sensor_msgs__msg__Imu as Imu2,
    builtin_interfaces__msg__Time as Time2,
    sensor_msgs__msg__CompressedImage as CompressedImage2,
    std_msgs__msg__Header as Header2,
)

from .protobufs.geo_capture_pb2 import GeoCapture


def capture_to_rosbag(
    capture_paths: List[Path], output_path, rosbag_version: int = 1, image_format="jpeg"
) -> None:
    # zf = zipfile.ZipFile(capture_path)
    # protobuf = [
    #     zip_info.filename
    #     for zip_info in zf.infolist()
    #     if zip_info.filename.endswith(".pb")
    # ]
    # assert len(protobuf) == 1
    # geo_capture = GeoCapture()
    # geo_capture.ParseFromString(zf.read(protobuf[0]))

    COORDINATE_FRAME_ID_VIDEO = "map"
    COORDINATE_FRAME_ID_IMU = "imu_coordinate_frame"
    """Iterate over IMAGES and save to output bag."""
    # timestamps = list(range(images.shape[0]))
    if rosbag_version == 1:
        typestore = get_typestore(Stores.ROS1_NOETIC)
        image_msg_type = CompressedImage1.__msgtype__
        Vector3 = Vector3_1
        Quaternion = Quaternion_1
        imu_msg_type = Imu1.__msgtype__
        Writer = Writer1
    elif rosbag_version == 2:
        typestore = get_typestore(Stores.ROS2_HUMBLE)
        image_msg_type = CompressedImage2.__msgtype__
        Vector3 = Vector3_2
        Quaternion = Quaternion_2
        imu_msg_type = Imu2.__msgtype__
        Writer = Writer2
    else:
        raise ValueError(f"Unknown rosbag version {rosbag_version}")
    # timestamp = geo_capture.videos[0].start_epoch_micro_seconds * 10**3
    # with TemporaryDirectory() as tmp_dir:
    with Writer(output_path) as writer:
        img_conn = writer.add_connection(
            "/cam0/compressed_image", image_msg_type, typestore=typestore
        )
        imu_conn = writer.add_connection("/imu", imu_msg_type, typestore=typestore)
        global_video_frame_index = 0
        video_timestamp = 0
        global_imu_message_index = 0
        imu_timestamp = 0
        for capture_path in capture_paths:
            geo_capture = GeoCapture()
            with open(capture_path, "rb") as f:
                geo_capture.ParseFromString(f.read())
            video = geo_capture.video
            with TemporaryDirectory() as tmp_dir:
                video_file_path = Path(tmp_dir) / "video.mp4"
                with open(video_file_path, "wb") as f:
                    f.write(video.data)
                # fps = video_capture.fps
                # if fps is None or fps <= 0:
                #     fps = 30
                # frame_step_time = 1 / fps * 10**9
                # name = Path(video_capture.file).name
                # zf.extract(name, videos_dir)
                # video_path = videos_dir / f"{i}.mp4"
                # (videos_dir / name).rename(video_path)
                cap = cv2.VideoCapture(video_file_path)
                chunk_frame_index = 0
                while cap.isOpened():
                    ret, frame = cap.read()
                    # if frame is read correctly ret is True
                    if not ret:
                        break

                    # print(frame.shape)
                    # print(frame_index, timestamp)
                    new_timestamp = (
                        video.frame_epochs_micro_seconds[chunk_frame_index] * 10**3
                    )  # + chunk_frame_index * 33 * 10**6
                    print(f"frame {chunk_frame_index} timestamp {new_timestamp}")
                    assert new_timestamp >= video_timestamp
                    video_timestamp = new_timestamp
                    img_bytes = np.ascontiguousarray(
                        cv2.imencode(f".{image_format}", frame)[1]
                    )
                    # print(img_bytes.shape)
                    if rosbag_version == 1:
                        header = Header1(
                            seq=global_video_frame_index,
                            stamp=Time1(
                                sec=int(video_timestamp // 10**9),
                                nanosec=int(video_timestamp % 10**9),
                            ),
                            frame_id=COORDINATE_FRAME_ID_VIDEO,
                        )
                        msg = CompressedImage1(
                            header,
                            format=image_format,  # could also be 'png'
                            data=img_bytes,
                        )
                        serialized_data = typestore.serialize_ros1(msg, image_msg_type)
                    elif rosbag_version == 2:
                        header = Header2(
                            stamp=Time2(
                                sec=int(video_timestamp // 10**9),
                                nanosec=int(video_timestamp % 10**9),
                            ),
                            frame_id=COORDINATE_FRAME_ID_VIDEO,
                        )
                        msg = CompressedImage2(
                            header,
                            format="jpeg",  # could also be 'png'
                            data=img_bytes,
                        )
                        serialized_data = typestore.serialize_cdr(msg, image_msg_type)
                    else:
                        raise AttributeError(f"Unknown rosbag version {rosbag_version}")

                    writer.write(
                        img_conn,
                        int(video_timestamp),
                        serialized_data,
                    )
                    global_video_frame_index += 1
                    chunk_frame_index += 1
            lin_acc = geo_capture.acceleration
            linear_acceleration_epochs = np.array(
                [a.epoch_micro_seconds for a in lin_acc.readings]
            )
            print(linear_acceleration_epochs)
            linear_accelerations = np.array(
                [
                    (a.acceleration.x, a.acceleration.y, a.acceleration.z)
                    for a in lin_acc.readings
                ]
            )
            ang_vel = geo_capture.angular_velocity
            angular_velocity_epochs = np.array(
                [a.epoch_micro_seconds for a in ang_vel.readings]
            )
            print(angular_velocity_epochs)
            angular_velocities = np.array(
                [
                    (a.angular_velocity.x, a.angular_velocity.y, a.angular_velocity.z)
                    for a in ang_vel.readings
                ]
            )
            orientation = geo_capture.orientation
            orientation_epochs = np.array(
                [o.epoch_micro_seconds for o in orientation.readings]
            )
            orientations_euler = np.array(
                [
                    (o.orientation.pitch, o.orientation.roll, o.orientation.yaw)
                    for o in orientation.readings
                ]
            )
            orientations_quat = Rotation.from_euler("xyz", orientations_euler).as_quat()

            min_epoch = max(
                linear_acceleration_epochs.min(),
                angular_velocity_epochs.min(),
                orientation_epochs.min(),
            )
            max_epoch = min(
                linear_acceleration_epochs.max(),
                angular_velocity_epochs.max(),
                orientation_epochs.max(),
            )

            all_epochs = np.concatenate(
                [
                    linear_acceleration_epochs,
                    angular_velocity_epochs,
                    orientation_epochs,
                ]
            )
            all_epochs = all_epochs[(all_epochs > min_epoch) & (all_epochs < max_epoch)]
            all_epochs = np.sort(all_epochs)

            linear_accelerations_interpolated = interp1d(
                linear_acceleration_epochs, linear_accelerations, axis=0
            )(all_epochs)
            angular_velocities_interpolated = interp1d(
                angular_velocity_epochs, angular_velocities, axis=0
            )(all_epochs)
            orientations_quat_interpolated = interp1d(
                orientation_epochs, orientations_quat, axis=0
            )(all_epochs)
            for epoch, acc, ang, ori in zip(
                all_epochs,
                linear_accelerations_interpolated,
                angular_velocities_interpolated,
                orientations_quat_interpolated,
            ):
                epoch *= 10**3
                assert epoch >= imu_timestamp
                imu_timestamp = epoch
                if rosbag_version == 1:
                    header = Header1(
                        seq=global_imu_message_index,
                        stamp=Time1(
                            sec=int(epoch // 10**9), nanosec=int(epoch % 10**9)
                        ),
                        frame_id=COORDINATE_FRAME_ID_IMU,
                    )
                    msg = Imu1(
                        header,
                        linear_acceleration=Vector3(*acc),
                        linear_acceleration_covariance=np.zeros(9, dtype=np.float64),
                        angular_velocity=Vector3(*ang),
                        angular_velocity_covariance=np.zeros(9, dtype=np.float64),
                        orientation=Quaternion(*ori),
                        orientation_covariance=np.zeros(9, dtype=np.float64),
                    )
                    serialized_data = typestore.serialize_ros1(msg, imu_msg_type)
                elif rosbag_version == 2:
                    header = Header2(
                        stamp=Time2(
                            sec=int(epoch // 10**9), nanosec=int(epoch % 10**9)
                        ),
                        frame_id=COORDINATE_FRAME_ID_IMU,
                    )
                    msg = Imu2(
                        header,
                        linear_acceleration=Vector3(*acc),
                        linear_acceleration_covariance=np.zeros(9),
                        angular_velocity=Vector3(*ang),
                        angular_velocity_covariance=np.zeros(9),
                        orientation=Quaternion(*ori),
                        orientation_covariance=np.zeros(9),
                    )
                    serialized_data = typestore.serialize_cdr(msg, imu_msg_type)
                else:
                    raise AttributeError(f"Unknown rosbag version {rosbag_version}")

                writer.write(
                    imu_conn,
                    int(epoch),
                    serialized_data
                )
                global_imu_message_index += 1
    return geo_capture
