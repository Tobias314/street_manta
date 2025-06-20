import 'package:flutter/material.dart';

import '../api/geocapture.dart';
import '../models/geocapture.dart';
import '../pages/photo_view.dart';

class GeoCaptureMarker extends StatelessWidget {
  final GeoCaptureDescriptor geoCapture;

  const GeoCaptureMarker(this.geoCapture, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.location_pin);
  }
}

class GeoPhotoMarkerPopup extends StatefulWidget {
  final GeoCaptureDescriptor geoCapture;

  const GeoPhotoMarkerPopup(this.geoCapture, {super.key});

  @override
  State<StatefulWidget> createState() => _GeoPhotoMarkerPopupState();
}

class _GeoPhotoMarkerPopupState extends State<GeoPhotoMarkerPopup> {
  Widget? _thumbnail;

  @override
  void initState() {
    super.initState();
    _initThumbnail();
  }

  Future<void> _initThumbnail() async {
    Widget thumbnail = SizedBox(
        width: 100,
        height: 100,
        child: Center(
          child: Icon(Icons.image),
        ));
    if (widget.geoCapture.thumbnailUrl != null) {
      try {
        thumbnail = await fetchImage(widget.geoCapture.thumbnailUrl!);
      } catch (e) {}
    }
    setState(() {
      _thumbnail = thumbnail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: _thumbnail ??
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )),
              _cardDescription(context),
            ],
          ),
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PhotoViewPage(geoCapture: widget.geoCapture))));
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
            // Text(
            //   'Location: ${widget.geoCapture.latitude}, ${widget.geoCapture.longitude}',
            //   style: const TextStyle(fontSize: 12.0),
            // ),
          ],
        ),
      ),
    );
  }
}
