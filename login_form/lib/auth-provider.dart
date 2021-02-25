import 'dart:convert';
import 'login-data.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  static Future<String> attemptLogIn(String username, String password) async {
    var body = json.encode({"username": username, "password": password});

    var res = await http.post("$server_ip/login",
        headers: {"Content-Type": "application/json"},
        body: body);
    print(username);
    print(res.body);
    if (res.statusCode == 200) return res.body;
    return null;
  }

  static Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: 'jwt');
    if (jwt == null) return "";
    return jwt;
  }

}