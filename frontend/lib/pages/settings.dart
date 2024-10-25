import 'package:flutter/material.dart';
import 'package:street_manta_client/utils/zip_uploader.dart';

import '../globals.dart';
import '../widgets/footer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //final TextEditingController _serverUrlController = TextEditingController();
  bool waitingForApiCall = false;
  final Future<Globals> _globalsFuture = Globals.getInstance();
  late Globals globals;
  int filesQueuedForUpload = 0;

  @override
  void initState() {
    super.initState();
    ZipUploader().registerCallback(widget, () {
      setState(() {
        filesQueuedForUpload = ZipUploader().filesQueuedForUpload.length;
      });
    });
    ZipUploader().reloadListOfQueuedFiles();
  }

  @override
  void dispose() {
    //_serverUrlController.dispose();
    ZipUploader().unregisterCallback(widget);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Einstellungen'),
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder<Globals>(
            future: _globalsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                globals = snapshot.data!;
                return Column(children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 500, maxWidth: 1000),
                    child: Column(
                      children: [
                        //const Padding(
                        //    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        //    child: Text('Einstellungen',
                        //        style: TextStyle(fontSize: 40))),
                        TextField(
                          controller:
                              TextEditingController(text: globals.backendUrl),
                          decoration: const InputDecoration(
                            labelText: 'Server URL',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.computer),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSubmitted: (text) =>
                              globals.backendUrl = text.trim(),
                        ),
                        const SizedBox(height: 20),
                        ListTile(
                          title: Text(
                              'Anzahl Dateien in Uploadwarteschlange: $filesQueuedForUpload'),
                        ),
                      ],
                    ),
                  )),
                  const StandardPageFooter()
                ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
  }
}
