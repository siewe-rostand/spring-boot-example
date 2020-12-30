import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_form/model/product-model.dart';
import 'package:login_form/product-add.dart';
import 'package:login_form/product-detail.dart';
import 'package:login_form/save-product.dart';

import 'login-data.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/passArguments';
 final String productName;
 final String productPrice;
  ProductPage({Key key, @required this.productName,@required this.productPrice}): super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductView httpService = ProductView();
  TextEditingController controller = TextEditingController();

  List<Product> _searchResult = [];
  List<Product> _userDetails = [];
  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.name.contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
  @override
  void initState() {
    super.initState();
  }


  //Map<String, String> heads = ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
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
                    prefixIcon: Icon(Icons.search)
                  ),
                  onChanged: onSearchTextChanged,
                ),
              ),
            ),
            Expanded(
              child:
              FutureBuilder<List<Product>>(
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
                                  Text(post.price.toString(),
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
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddProduct()),);
          }),
    );
  }
}