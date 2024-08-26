import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../globals.dart';

class GetTheAppText extends StatefulWidget {
  const GetTheAppText({super.key});

  @override
  State<GetTheAppText> createState() => _GetTheAppTextState();
}

class _GetTheAppTextState extends State<GetTheAppText> {
  final Future<Globals> _globalsFuture = Globals.getInstance();
  late Globals globals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return FutureBuilder<Globals>(
        future: _globalsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var globals = snapshot.data!;
            var androidAppUrl =
                "${globals.backendUrl}/static/app/android/streetmanta.apk";
            return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "App Herunterladen",
                    style: textTheme.headlineLarge,
                  ),
                  Text(
                    "Da die Bildaufnahme zuverlässigen Zugriff auf Gerätesensoren (Kamera, GPS, Beschleunigungssensoren) benötigt, wird die native (Android-) App benötigt.",
                    style: textTheme.bodyMedium,
                  ),
                  Text(
                    "Zum Herunterladen der App einfach den nachfolgenden QR-Code scannen oder den entsprechenden Link durch Klick auf den QR-Code öffnen.",
                    style: textTheme.bodyMedium,
                  ),
                  MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: QrImageView(
                          data: androidAppUrl,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        onTap: () {
                          launchUrl(Uri.parse(androidAppUrl));
                        },
                      )),
                  const Text(
                      "Nach herunterladen der App müssen evtl. Apps aus alternativen Quellen aktiviert werden, da die App direkt als .apk Datei heruntergeladen und installiert werden muss."
                      " Grund hierfür ist, dass die App privat gehosted wird und nicht im Google Play Store verfügbar ist."),
                ],
              ))
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
