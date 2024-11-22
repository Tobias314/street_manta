import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:street_manta_client/protobufs/geo_capture.pb.dart';
import '../api/capture.dart';

// A screen that allows users to take a picture using a given camera.
class UploadGeoPhotoScreen extends StatefulWidget {
  UploadGeoPhotoScreen({
    super.key,
    required this.singlePhotoCapture,
  });

  GeoCapture singlePhotoCapture;

  @override
  UploadGeoPhotoScreenState createState() => UploadGeoPhotoScreenState();
}

// A widget that displays the picture taken by the user.
class UploadGeoPhotoScreenState extends State<UploadGeoPhotoScreen> {
  late GeoCapture singlePhotoCapture;
  bool waitingForApiCall = false;

  @override
  void initState() {
    super.initState();
    singlePhotoCapture = widget.singlePhotoCapture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(children: <Widget>[
        //TODO: Fix this
        Flexible(
          child: Image.memory(Uint8List.fromList(singlePhotoCapture.photos[0].data)),
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
    var response = await uploadGeoCapture(singlePhotoCapture);
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
