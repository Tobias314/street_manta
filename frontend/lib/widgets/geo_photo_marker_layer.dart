import 'package:street_manta_client/api/capture.dart';

import 'marker_popup.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../api/geo_photo.dart';
import '../models/geo_photo.dart';
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

  PopupMarkerLayer _createMarkerLayer(List<GeoPhoto> geophotos) {
    return PopupMarkerLayer(
        options: PopupMarkerLayerOptions(
      markers: geophotos
          .map((geophoto) => Marker(
              point: LatLng(geophoto.latitude, geophoto.longitude),
              child: GeoPhotoMarker(geophoto)))
          .toList(),
      popupDisplayOptions: PopupDisplayOptions(
        builder: (BuildContext context, Marker marker) =>
            GeoPhotoMarkerPopup(((marker.child) as GeoPhotoMarker).geoPhoto),
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
      fetchGeoPhotosForRegion(_visibleBounds)
          .then((geophotos) => {
                setState(() {
                  markers = _createMarkerLayer(geophotos);
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
