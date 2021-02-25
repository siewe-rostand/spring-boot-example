import 'package:flutter/material.dart';
import 'package:login_form/home-drawer.dart';
import 'package:login_form/model/vendeur-model.dart';
import 'package:login_form/vendeur/nouveau-vendeur.dart';
import 'package:login_form/vendeur/vendeur-detail.dart';
import 'package:login_form/vendeur/vendeur-services.dart';

class SellerPage extends StatefulWidget {
  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuilderDrawer(),
      appBar: AppBar(
        title: Text('Vendeurs'),
      ),
      body: Center(
        child: FutureBuilder<List<Seller>>(
          future: SellerAPI.fetchSellers(2),
          builder:
              (BuildContext context, AsyncSnapshot<List<Seller>> snapshot) {
            if (snapshot.hasData) {
              List<Seller> stores = snapshot.data;
              print(stores);
              return Column(
                children: stores
                    .map(
                      (Seller post) => GestureDetector(
                        child: ListTile(
                          leading: Container(
                            child: post.activated == true
                                ? Icon(
                              Icons.done,
                              color: Colors.green,
                            )
                                : Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                          ),
                          title: Text(post.name),
                          subtitle: Text(post.phone.toString()),
                        ),
                        onTap: () {
                          var seller = Seller(
                              login: post.login,
                              lastName: post.lastName,
                              phone: post.phone,
                              firstName: post.firstName);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SellerPageDetail(
                                        seller: seller,
                                      )));
                        },
                      ),
                    )
                    .toList(),
              );
            } else {
              List<Seller> stores = snapshot.data;
              // print(stores);
              return Center(
                  child: Container(child: CircularProgressIndicator()));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NouveauVendeur()));
        },
      ),
    );
  }
}
