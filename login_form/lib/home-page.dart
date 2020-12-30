import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_form/home-drawer.dart';
import 'package:login_form/product.dart';
import 'package:login_form/translation.dart';
import 'package:http/http.dart' as http;
import 'package:login_form/vente.dart';
import 'dart:convert';
import './login-data.dart';

class HomePage extends StatelessWidget {
  HomePage(this.jwt, this.payload);

  factory HomePage.fromBase64(String jwt) => HomePage(
        jwt,
        json.decode(
          utf8.decode(base64.decode(base64.normalize(jwt.split(".")[1]))),
        ),
      );
  final String jwt;
  final Map<String, dynamic> payload;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(allTranslations.text('home_title')),

        ),
        drawer: BuilderDrawer(),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future:
                          http.read('$server_ip/data', headers: {"Authorization": jwt}),
                      builder: (context, snapshot) => Container(
                        child: snapshot.hasData
                            ? Scrollbar(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 25),
                                      child: Text.rich(
                                        TextSpan(children: [
                                          TextSpan(
                                              text: "Bonjour: ",
                                              style: TextStyle(fontSize: 23)),
                                          TextSpan(
                                            text: '${payload['firstName']}',
                                            style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ]),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Sales()));
                                        },
                                        child: Text('Enregistrer une nouvelle vente',
                                            style: TextStyle(
                                                fontSize: 23, fontFamily: 'Slabo')),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: FlatButton(
                                        onPressed: () {},
                                        child: Text('Consulter le journal des vente',
                                            style: TextStyle(
                                                fontSize: 23, fontFamily: 'Slabo')),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ProductPage()));
                                        },
                                        child: Text('Consulter la liste des produits',
                                            style: TextStyle(
                                                fontSize: 23, fontFamily: 'Slabo')),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : snapshot.hasError
                                ? Text('an error occurred')
                                : CircularProgressIndicator(),
                      )
                  ),
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }
}
