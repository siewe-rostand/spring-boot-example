/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_form/auth-provider.dart';
import 'package:login_form/auth.dart';
import 'package:login_form/login-data.dart';
import './home-page.dart';

class RootPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = AuthProvider.of(context).auth;
    return StreamBuilder(
        stream: auth.onAuthStateChange,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            final bool isLoggedIn = snapshot.hasData;
            return isLoggedIn ? HomePage() : LoginForm();
          }
          return _buildWaitingScreen();
        });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}*/
