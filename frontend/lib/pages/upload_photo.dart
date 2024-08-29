import 'package:flutter/material.dart';
import 'dart:io';
import '../api/geo_photo.dart';
import '../models/geo_photo.dart';

// A screen that allows users to take a picture using a given camera.
class UploadGeoPhotoScreen extends StatefulWidget {
  const UploadGeoPhotoScreen({
    super.key,
    required this.geoPhoto,
  });

  final GeoPhotoUpload geoPhoto;

  @override
  UploadGeoPhotoScreenState createState() => UploadGeoPhotoScreenState();
}

// A widget that displays the picture taken by the user.
class UploadGeoPhotoScreenState extends State<UploadGeoPhotoScreen> {
  late GeoPhotoUpload geoPhoto;
  bool waitingForApiCall = false;

  @override
  void initState() {
    super.initState();
    geoPhoto = widget.geoPhoto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(children: <Widget>[
        Flexible(
          child: Image.file(File(geoPhoto.path)),
        ),
        const TextField(
          decoration: InputDecoration(hintText: 'Description'),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                waitingForApiCall = true;
              });
              _uploadGeoPhoto();
            },
            child: const Text('Upload')),
      ]),
    );
  }

  void _uploadGeoPhoto() async {
    var response = await uploadGeoPhoto(geoPhoto);
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
