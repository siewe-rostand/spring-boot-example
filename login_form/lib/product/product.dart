import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:login_form/model/product-model.dart';
import 'package:login_form/product/product-add.dart';
import 'package:login_form/product/product-edit.dart';
import 'package:login_form/product/save-product.dart';

import '../login-data.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> sortProduct = [];
  TextEditingController controller = TextEditingController();
  List addProducts;
  int present = 0;
  int perPage = 15;
  ScrollController _controller = ScrollController();
  bool _loading = false;
  int _totalMessages = _productDetail.length, _loadInterval = 10;

  Future<Null> getUserDetails(int storeId) async {
    String url = "$server_ip/api/products-enabled-by-store/$storeId/";
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
        _productDetail.getRange(present, present + perPage);
        present += perPage;
      }
    });
  }
  void _setListener() {
    _controller.addListener(() async {
      var max = _controller.position.maxScrollExtent;
      var offset = _controller.offset;

      // we have reached at the top of the list, we should make _loading = true
      if (max - offset < perPage && !_loading) {
        _loading = true;

        // load 20 more items (_loadInterval = 20) after a delay of 2 seconds
        await Future.delayed(Duration(seconds: 2));

        // items are loaded successfully, make _loading = false
        _loading = false;
        setState(() {});
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                            var products = Product(
                                name: _productDetail[index].name,
                                price: _productDetail[index].price);
                            //push the values of product's name and price to another page
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProduct(
                                          product: products,
                                        )));
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
              /*FutureBuilder(
                future: ProductView.fetchTeams(2),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List products =snapshot.data;
                  if (products == null) {
                    return Center(
                      child: Text("No Product found"),
                    );
                  }
                  if (snapshot.hasData) {

                    return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(8),
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              var products = Product(
                                  name: productName(snapshot.data[index]),
                                  price: snapshot.data[index]['price']
                              );
                              //push the values of product's name and price to another page
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProduct(product: products,)));
                            },
                            child: Card(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: Text(productName(snapshot.data[index]))
                                            /*CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          snapshot.data[index]['strTeamBadge']))*/,
                                            title: Text(productName(snapshot.data[index])),
                                            subtitle: Text(_location(snapshot.data[index])),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Text(_stock(products[index])),
                                        ],
                                      ),
                                    ),
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
              ),*/
              /*FutureBuilder<List<Product>>(
                future: httpService.viewProduct(2),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasData) {
                    List<Product> products = snapshot.data;
                    //print(products);
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text(
                              'image',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                              label: Text(
                            'Price',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                                '',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ))
                        ],
                        rows: products
                            .map(
                              (Product post) => DataRow(cells: [
                                DataCell(
                                  Image.network("$server_ip/api/product-image/${post.id}",
                                  headers: {
                                    'Authorization': 'Bearer $token',
                                    'Content-Type': 'application/json',
                                    "accept" : 'application/json, text/plain'
                                  },
                                  )
                                ),
                                DataCell(Text(
                                  post.name,
                                  style: TextStyle(
                                  ),
                                )),
                                DataCell(
                                  Text(post.price.ceilToDouble().toString(),
                                      style: TextStyle(
                                      )),
                                ),
                                DataCell(
                                  Text(post.stock.toString(),
                                      style: TextStyle(
                                      )),
                                ),
                              ]),
                            )
                            .toList(),
                      ),
                    );
                  } else {
                    List<Product> products = snapshot.data;
                    print(products);
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),*/
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AddProduct()),
            );
          }),
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
