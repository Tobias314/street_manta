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

  PopupMarkerLayer _createMarkerLayer(List<GeoCaptureDescriptor> geoCaptures) {
    return PopupMarkerLayer(
        options: PopupMarkerLayerOptions(
      markers: geoCaptures
          .map((geopgeoCapture) => Marker(
              point: LatLng(geopgeoCapture.bboxCenter.latitude,
                  geopgeoCapture.bboxCenter.longitude),
              child: GeoCaptureMarker(geopgeoCapture)))
          .toList(),
      popupDisplayOptions: PopupDisplayOptions(
        builder: (BuildContext context, Marker marker) => GeoPhotoMarkerPopup(
            ((marker.child) as GeoCaptureMarker).geoCapture),
      ),
    ));
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
                  isFetching = false;
                })
              })
          .catchError((error) => {
                setState(() {
                  logger.w('Could not fetch geophoto positions: $error');
                  markers = _createMarkerLayer([]);
                  isFetching = false;
                })
              });
    }
    return markers;
  }
}
