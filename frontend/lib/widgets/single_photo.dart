import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../utils/geo_camera.dart';
import '../pages/upload_photo.dart';
//import 'package:sensors_plus/sensors_plus.dart';

class SinglePhotoWidget extends StatefulWidget {
  final GeoCamera geoCamera;
  const SinglePhotoWidget({super.key, required this.geoCamera});

  @override
  State<SinglePhotoWidget> createState() => _SinglePhotoWidgetState();
}

class _SinglePhotoWidgetState extends State<SinglePhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [CameraPreview(widget.geoCamera.cameraController)]),
      Positioned.fill(
          bottom: 200,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              heroTag: 'single_photo',
              // Provide an onPressed callback.
              onPressed: () async {
                // Take the Picture in a try / catch block. If anything goes wrong,
                // catch the error.
                try {
                  // Attempt to take a picture and get the file `image`
                  // where it was saved.
                  final image = await widget.geoCamera.takePicture();

                  if (!context.mounted) return;

                  // If the picture was taken, display it on a new screen.
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UploadGeoPhotoScreen(
                        geoPhoto: image,
                      ),
                    ),
                  );
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }
              },
              child: const Icon(Icons.camera_alt),
            ),
          ))
    ]);
  }
}
