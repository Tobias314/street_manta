import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../globals.dart';

Future<String> login(String email, String password) async {
  final globals = await Globals.getInstance();
  final Uri uri = Uri.parse('${globals.backendUrl}/api/token');
  final inputMap = <String, dynamic>{};
  // According to the Oauth2 spec, form data with username and password has to be sent
  inputMap['username'] = email;
  inputMap['password'] = password;
  http.Response response = await http.post(
    uri,
    body: inputMap,
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to get token');
  }
  print(response.body);
  Map<String, dynamic> responseMap = jsonDecode(response.body);
  String token = responseMap['access_token'];
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userToken', token);
  return token;
}

Future<void> createNewAccount(String email, String password) async {
  final globals = await Globals.getInstance();
  final Uri uri = Uri.parse('${globals.backendUrl}/api/account');
  Map data = {
    'email': email,
    'password': password,
  };
  //encode Map to JSON
  var body = json.encode(data);
  http.Response response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to get token');
  }
  print(response.body);
}
