import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:login_form/approvisionnement/nouveau-approvisionnnement.dart';
import 'package:login_form/manquant/nouveau-manquant.dart';
import 'package:login_form/model/manquant-model.dart';
import 'package:login_form/model/product-model.dart';
import 'package:login_form/product/save-product.dart';
import '../login-data.dart';

class SelectProduct2 extends StatefulWidget {
  final String check;
  SelectProduct2({this.check});
  @override
  _SelectProduct2State createState() => _SelectProduct2State();
}

class _SelectProduct2State extends State<SelectProduct2> {

  List<Product> sortProduct = [];
  TextEditingController controller = TextEditingController();
  LocalStorage localStorage = LocalStorage('manquant');
  List addProducts;
  Future<Null> getUserDetails(int storeId) async {
   String url = "$server_ip/api/products-enabled-by-store/$storeId";
    Response result = await get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'authorization': 'Bearer $token'
      },
    );
    var responseJson = json.decode(result.body)['content'];
    print(responseJson);

    setState(() {
      for (Map user in responseJson) {
        _productDetail.add(Product.fromJson(user));
      }
    });
  }




  @override
  void initState() {
    getUserDetails(2);
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Product'),
        actions: [
          IconButton(icon: Icon(Icons.clear), onPressed: (){
            Navigator.of(context).pop();
          })
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: Card(
                child: ListTile(
                  title: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'search a product',
                      hintStyle: TextStyle(color: Colors.teal.shade900),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          onSearchTextChanged('');
                        },
                      ),
                      suffixIcon: controller.text.isNotEmpty
                          ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () => controller.clear())
                          : null,
                    ),
                    onChanged: onSearchTextChanged,
                  ),
                ),
              ),
            ),
            Expanded(
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? new ListView.builder(
                itemCount: _searchResult.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    child: new Card(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  new ListTile(
                                    leading: new CircleAvatar(),
                                    title:
                                    new Text(_searchResult[i].name),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(0.0),
                    ),
                  );
                },
              )
                  : new ListView.builder(
                itemCount: _productDetail.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      var manquant =Manquants(
                          productName: _productDetail[index].name,
                        productId: _productDetail[index].id
                      );
                      //push the values of product's name and price to another page
                      if(widget.check == 'approvisionnement'){
                        localStorage.setItem('name', _productDetail[index].name);
                        localStorage.setItem('id', _productDetail[index].id);
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NouveauApprovisionnement()
                            ));
                      }
                      if(widget.check == 'manquants'){
                        localStorage.setItem('name', _productDetail[index].name);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NouveauManquant(manquants: manquant,)
                            ));
                      }
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => NouveauManquant(manquants: manquant,)
//                          ));

                    },
                    child: new Card(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  new ListTile(
                                    leading: new CircleAvatar(),
                                    title: new Text(
                                        _productDetail[index].name),
                                    subtitle: Text(_productDetail[index]
                                        .price
                                        .ceil()
                                        .toString()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Text(_productDetail[index]
                                      .stock
                                      .toString()),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.all(0.0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _productDetail.forEach((productDetail) {
      if (productDetail.name.contains(text)) _searchResult.add(productDetail);
    });

    setState(() {});
  }

}

List<Product> _searchResult = [];

List<Product> _productDetail = [];

/*
 Future fetchTeams(int storeId) async {
     String token =
    "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkM2VlYzZjYS0zMzRhLTQ0MmMtOTQ0Yi0zZTMxNWJmZTA4ZGIiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjA5NDE3NDczLCJleHAiOjE2MTAyODE0NzMsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.D7mhQnhqE3xzygaebpvXuMwbOQ2qAPnEuQmIa8i14LJQHiS6tLRO1JBP6Luq7la3RulIq3hFQWyLTT1_TYHcBQ";
     String url = "$server_ip/api/products-enabled-by-store/$storeId";

    try {
      Response result = await get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'authorization': 'Bearer $token'
        },
      );
      var body = json.decode(result.body);
      var rest = body['content'];
      //print(rest);
      print(json.decode(result.body)['content']);
      return rest;
    } catch (e) {
      print(e);
    }
  }

  String productName(dynamic product) {
    return product['name'];
  }

  String _location(dynamic product) {
    return product['price'].toString();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: fetchTeams(2),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Text("No Product found"),
            );
          }
          if (snapshot.hasData) {

            return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      var products = Product(
                        name: productName(snapshot.data[index]),
                        price: snapshot.data[index]['price']
                      );
                      //push the values of product's name and price to another page
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewVente(product: products,)));
                    },
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Text(productName(snapshot.data[index]))
                            /*CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    snapshot.data[index]['strTeamBadge']))*/,
                            title: Text(productName(snapshot.data[index])),
                            subtitle: Text(_location(snapshot.data[index])),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
 */
