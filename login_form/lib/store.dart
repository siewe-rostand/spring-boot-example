import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_form/model/store-model.dart';
import 'package:login_form/store-detail.dart';

import 'home-page.dart';
import 'login-data.dart';

class StoreList extends StatelessWidget {
  final API httpService = API();

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: 'jwt');
    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stores"),
      ),
      body: FutureBuilder<List<Store>>(
        future: httpService.fetchStore(),
        builder: (BuildContext context, AsyncSnapshot<List<Store>> snapshot) {
          if (snapshot.hasData) {
            List<Store> stores = snapshot.data;
            print(stores);
            return Container(
              child: SimpleDialog(
                title: Text('Choose store',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
                children: stores
                    .map(
                      (Store post) => ListTile(
                    title: Text(post.name, style: TextStyle(fontSize: 20),),
                    onTap: ()  {
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return FutureBuilder(
                              future: jwtOrEmpty,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
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
                              });
                        },
                      ),
                    );
                    },
                  ),
                )
                    .toList(),
              ),
            );
          } else {
            List<Store> stores = snapshot.data;
           // print(stores);
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}