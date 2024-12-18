import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:street_manta_client/globals.dart';
import 'geo_photo_marker_layer.dart';

import '../utils/recorder.dart';

class AutoPhotoWidget extends StatefulWidget {
  final Recorder recorder;

  const AutoPhotoWidget({super.key, required this.recorder});

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
                      CameraPreview(widget.recorder.cameraController!)
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
                      if (widget.recorder.isRecording) {
                        await widget.recorder.stopGeoCapture();
                        setState(() {
                          //widget.geoCamera.disableContiniousMode();
                          buttonText = 'Erfassung starten';
                        });
                      } else {
                        //widget.geoCamera.enableContiniousMode();
                        var globals = await Globals.getInstance();
                        await widget.recorder.startGeoCapture(globals.geoCaptureChunkLengthSeconds);
                        setState(() {
                          setState(() => buttonText = 'Erfassung stoppen');
                        });
                      }
                    },
                    label: Text(buttonText))))
      ]);
    });
  }
}
