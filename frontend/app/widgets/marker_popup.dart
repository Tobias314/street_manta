import 'package:flutter/material.dart';

import '../api/geo_photo.dart';
import '../models/geo_photo.dart';
import '../pages/photo_view.dart';

class GeoPhotoMarker extends StatelessWidget {
  final GeoPhoto geoPhoto;

  const GeoPhotoMarker(this.geoPhoto, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.location_pin);
  }
}

class GeoPhotoMarkerPopup extends StatefulWidget {
  final GeoPhoto geoPhoto;

  const GeoPhotoMarkerPopup(this.geoPhoto, {super.key});

  @override
  State<StatefulWidget> createState() => _GeoPhotoMarkerPopupState();
}

class _GeoPhotoMarkerPopupState extends State<GeoPhotoMarkerPopup> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: FutureBuilder(
                      future: fetchImage(widget.geoPhoto.imageId,
                          fetchThumbnail: true),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data!;
                        } else {
                          return const SizedBox(
                            width: 100,
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      })),
              _cardDescription(context),
            ],
          ),
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PhotoViewPage(geoPhoto: widget.geoPhoto))));
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'GeoPhoto',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              'Location: ${widget.geoPhoto.latitude}, ${widget.geoPhoto.longitude}',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
