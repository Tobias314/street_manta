import 'package:flutter/material.dart';
import '../api/geo_photo.dart';
import '../models/geo_photo.dart';

class PhotoViewPage extends StatefulWidget {
  const PhotoViewPage({
    super.key,
    required this.geoPhoto,
  });

  final GeoPhoto geoPhoto;

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
            future: fetchImage(widget.geoPhoto.imageId),
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
          widget.geoPhoto.description,
        ),
      ]),
    );
  }
}
