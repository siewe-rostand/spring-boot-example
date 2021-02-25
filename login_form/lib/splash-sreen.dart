import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_form/login-data.dart';
import 'file:///C:/Users/ROSTAND/IdeaProjects/login_form/lib/store/store.dart';
import 'home-page.dart';


class SplashScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: 'jwt');
    if (jwt == null) return "";
    return jwt;
  }

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => FutureBuilder(
            future: jwtOrEmpty,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: Container(child: CircularProgressIndicator()));
              if (snapshot.data != "") {
                var str = snapshot.data;
                var jwt = str.split(".");

                if (jwt.length != 3) {
                  return LoginForm();
                } else {
                  var payload = json.decode(
                      utf8.decode(base64.decode(base64.normalize(jwt[1]))));
                  if (DateTime.fromMillisecondsSinceEpoch(
                      payload["exp"] * 1000)
                      .isAfter(DateTime.now())) {
                    return HomePage(str, payload);
                  } else {
                    return LoginForm();
                  }
                }
              } else {
                return LoginForm();
              }
            })),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              child: Image.asset('images/Afrologic_logo.png'),
            ),
          ),
          Center(child: Container(child: CircularProgressIndicator())),
          Container(
            alignment: Alignment.bottomCenter,
            child: Image.asset('images/logo.png'),
            height: 75.0,
          ),
        ],
      ),
    );
  }
}
