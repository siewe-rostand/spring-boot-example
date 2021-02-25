
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:login_form/accueil.dart';
import 'package:login_form/login-data.dart';
import 'package:login_form/model/store-model.dart';
import 'package:login_form/store/store-detail.dart';


class StoreList extends StatelessWidget {
  LocalStorage storeLocalStorage = LocalStorage('store');

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
        future: API.fetchStore(),
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
                      var store = Store(
                          name: post.name,
                          id: post.id,
                          benefice: post.benefice,
                          totalStock: post.totalStock,
                          createdDate: post.createdDate
                      );
                      storeLocalStorage.setItem('storeId', post.id);
                      storeLocalStorage.setItem('storeName', post.name);
                      storeLocalStorage.setItem('storeBenefice', post.benefice);
                      storeLocalStorage.setItem('storeTotalStock', post.totalStock);
                      storeLocalStorage.setItem('storeCreatedDate', post.createdDate);
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return StoreHomePage(store: store,);
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
            return Center(child: Container(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}