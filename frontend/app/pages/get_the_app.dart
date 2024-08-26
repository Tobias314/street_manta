import 'package:flutter/material.dart';
import '../widgets/get_the_app.dart';
import '../widgets/menu_drawer.dart';

class GetTheAppPage extends StatefulWidget {
  const GetTheAppPage({super.key});

  @override
  State<GetTheAppPage> createState() => _GetTheAppPageState();
}

class _GetTheAppPageState extends State<GetTheAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Herunterladen'),
      ),
      drawer: MenuDrawer(
        hide: const {"Aufnahme"},
      ),
      body: const GetTheAppText(),
    );
  }
}
