import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_form/login-data.dart';
import 'package:login_form/store.dart';


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
        MaterialPageRoute(builder: (BuildContext context) => StoreList()),
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
          Center(child: CircularProgressIndicator()),
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
