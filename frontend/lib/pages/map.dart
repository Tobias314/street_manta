import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:street_manta_client/api/geocapture.dart';
import 'package:street_manta_client/models/geocapture.dart';
import 'package:street_manta_client/widgets/marker_popup.dart';
import '../widgets/footer.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/geocapture_map_layer.dart';

var logger = Logger();

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MapPageState();
  }
}

class MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  LatLngBounds _visibleBounds = LatLngBounds(
    const LatLng(0, 0),
    const LatLng(0, 0),
  );
  bool isFetching = false;

  List<GeoCaptureDescriptor> geoCaptures = [];
  PolylineLayer polylines = PolylineLayer(polylines: []);

  List<Marker> _createMarkers(List<GeoCaptureDescriptor> geoCaptures) {
    return geoCaptures
        .where((geoCapture) => (geoCapture.video?.waypoints.length ?? 0) == 0)
        .map((geoCapture) => Marker(
            point: LatLng(geoCapture.bboxCenter.latitude,
                geoCapture.bboxCenter.longitude),
            child: GeoCaptureMarker(geoCapture)))
        .toList();
  }

  List<Polyline> _createPolylines(List<GeoCaptureDescriptor> geoCaptures) {
    return geoCaptures
        .where((geoCapture) => (geoCapture.video?.waypoints.length ?? 0) > 0)
        .map((geoCapture) => Polyline(
              points: geoCapture.video!.waypoints
                  .map((waypoint) =>
                      LatLng(waypoint.latitude, waypoint.longitude))
                  .toList(),
              color: Colors.blue,
              strokeWidth: 2.0,
            ))
        .toList();
  }

  void _updateGeocapturesForCurrentMapRegion(LatLngBounds cameraBounds) {
    if (!isFetching && !_visibleBounds.containsBounds(cameraBounds)) {
      isFetching = true;
      var width = cameraBounds.east - cameraBounds.west;
      var height = cameraBounds.north - cameraBounds.south;
      setState(() {
        _visibleBounds = LatLngBounds(
            LatLng(
                cameraBounds.south - height / 2, cameraBounds.west - width / 2),
            LatLng(cameraBounds.north + height / 2,
                cameraBounds.east + width / 2));
      });
      fetchGeoCapturesForRegion(_visibleBounds)
          .then((geocaptures) => {
                setState(() {
                  geoCaptures = geocaptures;
                  isFetching = false;
                })
              })
          .catchError((error) => {
                setState(() {
                  logger.w('Could not fetch geophoto positions: $error');
                  isFetching = false;
                })
              });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      //update_markers_and_polygons(LatLngBounds(LatLng(30, 0), LatLng(60, 40)));
    });
  }

  void _onMapEvent(MapEvent mapEvent) {
    _updateGeocapturesForCurrentMapRegion(_mapController.camera.visibleBounds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Street Manta'),
        ),
        drawer: MenuDrawer(hide: const {"Karte"}),
        body: Column(children: [
          Expanded(
              child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              keepAlive: true,
              initialCenter: const LatLng(51.8268, 12.2371),
              onMapEvent: _onMapEvent,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              PopupMarkerLayer(
                  options: PopupMarkerLayerOptions(
                markers: _createMarkers(geoCaptures),
                popupDisplayOptions: PopupDisplayOptions(
                  builder: (BuildContext context, Marker marker) =>
                      GeoPhotoMarkerPopup(
                          ((marker.child) as GeoCaptureMarker).geoCapture),
                ),
              )),
              PolylineLayer(polylines: _createPolylines(geoCaptures)),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () =>
                        (Uri.parse('https://openstreetmap.org/copyright')),
                  ),
                ],
              )
            ],
          )),
          const StandardPageFooter()
        ]));
  }
}
