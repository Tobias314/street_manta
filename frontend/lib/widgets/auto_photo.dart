import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'geo_photo_marker_layer.dart';

import '../utils/geo_camera.dart';

class AutoPhotoWidget extends StatefulWidget {
  final GeoCamera geoCamera;

  const AutoPhotoWidget({super.key, required this.geoCamera});

  @override
  _AutoPhotoWidgetState createState() => _AutoPhotoWidgetState();
}

class _AutoPhotoWidgetState extends State<AutoPhotoWidget> {
  var map = FlutterMap(
      mapController: MapController(),
      options: const MapOptions(keepAlive: true),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        const GeoPhotoMarkerLayer(),
        CurrentLocationLayer(
          alignPositionOnUpdate: AlignOnUpdate.always,
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => (Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        )
      ]);
  String buttonText = 'Erfassung starten';
  //late Future<CameraController> _initializationFuture;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Flex main;
    var elements = [
      Expanded(flex: 1, child: Container(color: Colors.blue, child: map)),
      Expanded(
          flex: 1,
          child: Container(
            child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                    width: 100,
                    child: Column(children: [
                      CameraPreview(widget.geoCamera.cameraController)
                    ]))),
          )),
    ];
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        main = Column(children: elements);
      } else {
        main = Row(children: elements);
      }
      return Stack(children: [
        main,
        Positioned.fill(
            bottom: 50,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton.extended(
                    heroTag: 'auto_photo',
                    // Provide an onPressed callback.
                    onPressed: () async {
                      if (widget.geoCamera.isContiniousUploadEnabled) {
                        setState(() {
                          widget.geoCamera.disableContiniousMode();
                          buttonText = 'Erfassung starten';
                        });
                      } else {
                        setState(() {
                          widget.geoCamera.enableContiniousMode();
                          setState(() => buttonText = 'Erfassung stoppen');
                        });
                      }
                    },
                    label: Text(buttonText))))
      ]);
    });
  }
}
