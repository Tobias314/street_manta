import 'package:flutter/material.dart';

import '../api/authentication.dart';
import '../widgets/footer.dart';
import 'login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();
  bool waitingForApiCall = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          Flexible(
              child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(minWidth: 500, maxWidth: 1000),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Text('Street Manta Konto Erstellen',
                        style: TextStyle(fontSize: 40))),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/logo.png',
                            width: 500, height: 500, fit: BoxFit.contain))),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-Mail',
                    hintText: 'Bitt E-Mail eintragen',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Passwort',
                    hintText: 'Bitte Passwort wählen',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility_off),
                      onPressed: () {},
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordRepeatController,
                  decoration: InputDecoration(
                    labelText: 'Passwort Wiederholen',
                    hintText: 'Bitte Passwort wiederholen',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility_off),
                      onPressed: () {},
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_passwordController.text ==
                        _passwordRepeatController.text) {
                      createNewAccount(
                          _emailController.text, _passwordController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Passwörter stimmen nicht überein."),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text('Registrieren'),
                ),
              ],
            ),
          )),
          const StandardPageFooter()
        ]));
  }
}
