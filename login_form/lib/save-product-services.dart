import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:login_form/login-data.dart';
import 'package:login_form/model/product-model.dart';
import 'package:login_form/product/product-add.dart';
import 'package:login_form/product/product-edit.dart';
import 'package:login_form/product/product-services.dart';
import 'package:login_form/product/save-product.dart';

import 'accueil.dart';

class ProductList2 extends StatefulWidget {
  @override
  _ProductList2State createState() => _ProductList2State();
}

class _ProductList2State extends State<ProductList2> {
  LocalStorage localStorage = LocalStorage('store');
  TextEditingController controller = TextEditingController();
  int present = 0;
  int perPage = 25;
  int _totalMessages;
  ScrollController scrollController = ScrollController();
  bool _loading = false;
  var nec;
  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    scrollController.addListener(() {
      setState(() {
        if (scrollController.position.maxScrollExtent == perPage)
          _loading = true;
      });
    });
    nec = List.generate(1000, (index) => _productDetail);
    _totalMessages = _productDetail.length;
    super.initState();
  }

  void _setListener() {
    scrollController.addListener(() async {
      var max = scrollController.position.maxScrollExtent;
      var offset = scrollController.offset;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => StoreHomePage()));
          },
        ),
      ),
      body: Column(
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
                            onPressed: () {
                              setState(() {
                                controller.clear();
                              });
                            })
                        : null,
                  ),
                  onChanged: onSearchTextChanged,
                ),
              ),
            ),
          ),
          FutureBuilder<List<Product>>(
            future: ProductAPI.fetchProducts(2, present, perPage),
            builder:
                (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.hasData) {
                _productDetail = snapshot.data;
                // _searchResult = snapshot.data;
                print(_productDetail);
                return Expanded(
                  child: Container(
                    child: controller.text.isNotEmpty
                        ? ListView.builder(
                            controller: scrollController,
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
                                                title: new Text(
                                                    _searchResult[i].name),
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
                        : ListView.builder(
                            controller: scrollController,
                            itemCount: _productDetail.length + 1,
                            itemBuilder: (context, index) {
                              if (index == perPage) {
                                Future.delayed(Duration(seconds: 2));
                                return Align(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return GestureDetector(
                                onTap: () async {
                                  var image =
                                      await ProductAPI.networkImageToBase64(
                                          _productDetail[index].id);
                                  var products = Product(
                                      id: _productDetail[index].id,
                                      name: _productDetail[index].name,
                                      price: _productDetail[index].price,
                                      storeId: 2,
                                      image: image);
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
                                                leading: new CircleAvatar(
                                                  child: Image.network(
                                                    "$server_ip/api/product-image-thumb/${_productDetail[index].id}",
                                                    headers: {
                                                      'Authorization':
                                                          'Bearer $token',
                                                      'Content-Type':
                                                          'image/jpeg',
                                                      "accept": 'image/jpeg'
                                                    },
                                                  ),
                                                ),
                                                title: new Text(
                                                    _productDetail[index].name),
                                                subtitle: Text(
                                                    _productDetail[index]
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
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                  margin: const EdgeInsets.all(0.0),
                                ),
                              );
                            },
                          ),
                  ),
                );
              } else {
                List<Product> stores = snapshot.data;
                // print(stores);
                return Center(
                    child: Container(child: CircularProgressIndicator()));
              }
            },
          ),
        ],
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
