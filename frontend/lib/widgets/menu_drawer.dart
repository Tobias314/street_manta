import 'package:flutter/material.dart';

import '../constants.dart';
import '../pages/capture.dart';
import '../pages/get_the_app.dart';
import '../pages/map.dart';
import '../pages/settings.dart';

class MenuDrawer extends StatelessWidget {
  final Map<String, Widget> pages = {
    "Karte": const MapPage(),
    "Aufnahme": const CapturePage(),
    "Einstellungen": const SettingsPage()
  };
  final Set<String> hide;

  MenuDrawer({super.key, required this.hide});

  @override
  Widget build(BuildContext context) {
    var tilesMap = {
      "Einstellungen": ListTile(
        title: const Text("Einstellungen"),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ));
        },
      ),
      "Karte": ListTile(
        title: const Text("Karte"),
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MapPage(),
              ));
        },
      ),
      "Aufnahme": ListTile(
        title: const Text("Aufnahme"),
        onTap: () {
          if (Constants.isMobileApp) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CapturePage(),
                ));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const GetTheAppPage()));
          }
        },
      )
    };
    var tiles = tilesMap.entries
        .toList()
        .where((element) => !hide.contains(element.key))
        .map((e) => e.value)
        .toList();
    return Drawer(
        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                    child: Text(''),
                  )
                ] +
                tiles));
  }
}
