import 'package:street_manta_client/api/capture.dart';

import 'marker_popup.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../api/geocapture.dart';
import '../models/geocapture.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

class GeoPhotoMarkerLayer extends StatefulWidget {
  const GeoPhotoMarkerLayer({super.key});

  @override
  State<StatefulWidget> createState() {
    return GeoPhotoMarkerLayerState();
  }
}

class GeoPhotoMarkerLayerState extends State<GeoPhotoMarkerLayer> {
  LatLngBounds _visibleBounds = LatLngBounds(
    const LatLng(0, 0),
    const LatLng(0, 0),
  );
  bool isFetching = false;
  PopupMarkerLayer markers =
      PopupMarkerLayer(options: PopupMarkerLayerOptions(markers: []));
  PolylineLayer polylines = PolylineLayer(polylines: []);

  PopupMarkerLayer _createMarkerLayer(List<GeoCaptureDescriptor> geoCaptures) {
    return PopupMarkerLayer(
        options: PopupMarkerLayerOptions(
      markers: geoCaptures
          .map((geoCapture) => Marker(
              point: LatLng(geoCapture.bboxCenter.latitude,
                  geoCapture.bboxCenter.longitude),
              child: GeoCaptureMarker(geoCapture)))
          .toList(),
      popupDisplayOptions: PopupDisplayOptions(
        builder: (BuildContext context, Marker marker) => GeoPhotoMarkerPopup(
            ((marker.child) as GeoCaptureMarker).geoCapture),
      ),
    ));
  }

  PolylineLayer _createPolylineLayer(List<GeoCaptureDescriptor> geoCaptures) {
    return PolylineLayer(
      polylines: geoCaptures
          .map((geoCapture) => Polyline(
                points: [
                  LatLng(geoCapture.bboxMin.latitude,
                      geoCapture.bboxMin.longitude),
                  LatLng(
                      geoCapture.bboxMax.latitude, geoCapture.bboxMax.longitude)
                ],
                color: Colors.blue,
                strokeWidth: 2.0,
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var camera = MapCamera.of(context);
    var cameraBounds = camera.visibleBounds;
    if (!isFetching & !_visibleBounds.containsBounds(cameraBounds)) {
      isFetching = true;
      var width = cameraBounds.east - cameraBounds.west;
      var height = cameraBounds.north - cameraBounds.south;
      _visibleBounds = LatLngBounds(
          LatLng(
              cameraBounds.south - height / 2, cameraBounds.west - width / 2),
          LatLng(
              cameraBounds.north + height / 2, cameraBounds.east + width / 2));
      fetchGeoCapturesForRegion(_visibleBounds)
          .then((geocaptures) => {
                setState(() {
                  markers = _createMarkerLayer(geocaptures);
                  polylines = _createPolylineLayer(geocaptures);
                  isFetching = false;
                })
              })
          .catchError((error) => {
                setState(() {
                  logger.w('Could not fetch geophoto positions: $error');
                  markers = _createMarkerLayer([]);
                  polylines = _createPolylineLayer([]);
                  isFetching = false;
                })
              });
    }
    return MobileLayerTransformer(child: polylines);
  }
}
