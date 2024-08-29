import 'package:flutter/material.dart';

import '../pages/data_privacy.dart';
import '../pages/imprint.dart';

class StandardPageFooter extends StatelessWidget {
  const StandardPageFooter({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      height: 30,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: TextButton(
                child: const Text('Impressum',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Imprint(),
                    ),
                  );
                })),
        Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: TextButton(
                child: const Text(
                  'Datenschutz',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DataPrivacy(),
                    ),
                  );
                }))
      ]),
    );
  }
}
