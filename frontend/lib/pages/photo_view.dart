import 'package:flutter/material.dart';
import '../api/geocapture.dart';
import '../models/geocapture.dart';

class PhotoViewPage extends StatefulWidget {
  const PhotoViewPage({
    super.key,
    required this.geoCapture,
  });

  final GeoCaptureDescriptor geoCapture;

  @override
  PhotoViewPageState createState() => PhotoViewPageState();
}

class PhotoViewPageState extends State<PhotoViewPage> {
  bool waitingForApiCall = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fotoansicht')),
      body: Column(children: <Widget>[
        FutureBuilder(
            future: fetchImage(widget.geoCapture.captureId,
                widget.geoCapture.photoIds.first),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!;
              } else {
                return const SizedBox(
                  width: 500,
                  height: 500,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
        Text(
          widget.geoCapture.description,
        ),
      ]),
    );
  }
}
