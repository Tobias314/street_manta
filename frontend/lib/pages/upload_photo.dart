import 'package:flutter/material.dart';
import 'package:street_manta_client/protobufs/geo_capture.pb.dart';
import 'dart:io';
import '../api/capture.dart';
import '../api/geo_photo.dart';
import '../models/geo_photo.dart';

// A screen that allows users to take a picture using a given camera.
class UploadGeoPhotoScreen extends StatefulWidget {
  UploadGeoPhotoScreen({
    super.key,
    required this.photoCapture,
  });

  PhotoCapture photoCapture;
  //final GeoPhotoUpload geoPhoto;

  @override
  UploadGeoPhotoScreenState createState() => UploadGeoPhotoScreenState();
}

// A widget that displays the picture taken by the user.
class UploadGeoPhotoScreenState extends State<UploadGeoPhotoScreen> {
  late PhotoCapture photoCapture;
  bool waitingForApiCall = false;

  @override
  void initState() {
    super.initState();
    photoCapture = widget.photoCapture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(children: <Widget>[
        Flexible(
          child: Image.file(File(photoCapture.file)),
        ),
        const TextField(
          decoration: InputDecoration(hintText: 'Description'),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                waitingForApiCall = true;
              });
              _uploadPhotoCapture();
            },
            child: const Text('Upload')),
      ]),
    );
  }

  void _uploadPhotoCapture() async {
    var geoCapture = GeoCapture(photos: [photoCapture]);
    var response = await uploadGeoCapture(geoCapture);
    if (!mounted) return;
    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Upload Failed"),
      ));
    }
  }
}
