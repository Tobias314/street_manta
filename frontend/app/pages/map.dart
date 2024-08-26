import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/footer.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/geo_photo_marker_layer.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

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
            mapController: MapController(),
            options: const MapOptions(
                keepAlive: true, initialCenter: LatLng(51.8268, 12.2371)),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              const GeoPhotoMarkerLayer(),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () =>
                        (Uri.parse('https://openstreetmap.org/copyright')),
                  ),
                ],
              ),
            ],
          )),
          const StandardPageFooter()
        ]));
  }
}
