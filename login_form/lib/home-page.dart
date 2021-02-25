import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:login_form/accueil.dart';
import 'package:login_form/home-drawer.dart';
import 'package:http/http.dart' as http;
import 'package:login_form/model/store-model.dart';
import 'package:login_form/product/product.dart';
import 'package:login_form/store/store.dart';
import 'package:login_form/vente/journal-de-vente.dart';
import 'package:login_form/vente/vente.dart';
import 'dart:convert';
import './login-data.dart';

class HomePage extends StatefulWidget {
  final Store store;
  HomePage(this.jwt, this.payload,{this.store});

  factory HomePage.fromBase64(String jwt) => HomePage(
        jwt,
        json.decode(
          utf8.decode(base64.decode(base64.normalize(jwt.split(".")[1]))),
        ),
      );
  final String jwt;
  final Map<String, dynamic> payload;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocalStorage localStorage = LocalStorage('users');

  @override
  void initState() {
    Timer(Duration(milliseconds: 250), (){
      localStorage.setItem('userFirstName', widget.payload['firstName']);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>StoreList()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.payload['name']}'),
        ),
        drawer: BuilderDrawer(),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future:
                          http.read('$server_ip/data', headers: {"Authorization": widget.jwt}),
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
                                      text: '${widget.payload['firstName']}',
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
                                  onPressed: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SaleNews()));
                                  },
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
                                : Center(child: Container(child: CircularProgressIndicator())),
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
/*
Scrollbar(
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
                                        onPressed: () {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SaleNews()));
                                        },
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
 */