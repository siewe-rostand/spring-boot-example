
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:login_form/model/store-model.dart';
import 'package:login_form/product/product.dart';
import 'package:login_form/save-product-services.dart';
import 'package:login_form/store/store-detail.dart';
import 'package:login_form/vente/journal-de-vente.dart';
import 'package:login_form/vente/vente.dart';

import 'home-drawer.dart';
import 'login-data.dart';

class StoreHomePage extends StatefulWidget {
  final Store store;
  StoreHomePage({this.store});

  @override
  _StoreHomePageState createState() => _StoreHomePageState();
}

class _StoreHomePageState extends State<StoreHomePage> {
  LocalStorage localStorage = LocalStorage('users');
  LocalStorage storeLocalStorage = LocalStorage('store');
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: 'jwt');
    if (jwt == null) return "";
    return jwt;
  }
  @override
  void initState() {
    super.initState();
    if(widget.store == null){
      return null;
    }
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuilderDrawer(),
      appBar: AppBar(
        title: Text("${storeLocalStorage.getItem('storeName')}"),
      ),
      body: Container(
        child: Scrollbar(
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
                      text: '${localStorage.getItem('userFirstName')}',
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
                        fontSize: 23,)),
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
                        fontSize: 23, )),
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
                            builder: (context) => ProductList2()));
                  },
                  child: Text('Consulter la liste des produits',
                      style: TextStyle(
                        fontSize: 23,)),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Stock  ',
                        style: TextStyle(fontSize: 23,),),
                      Text('${storeLocalStorage.getItem('storeTotalStock').ceil()}',
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              Divider(),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Benefice  ',
                      style: TextStyle(fontSize: 23, ),textAlign: TextAlign.justify,),
                    Text('${storeLocalStorage.getItem('storeBenefice').ceil()}',
                      style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*
FutureBuilder(
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
                                })
 */