import 'package:flutter/material.dart';
import 'package:login_form/model/product-model.dart';
import 'package:login_form/product.dart';
import 'package:login_form/vente.dart';

class NouvelleVente extends StatefulWidget {
  @override
  _NouvelleVenteState createState() => _NouvelleVenteState();
}

class _NouvelleVenteState extends State<NouvelleVente> {
  bool _btnEnabled = false;
  bool _searchbtn = false;
  TextEditingController productController;
  TextEditingController priceController;
  TextEditingController quantityController;

  @override
  void initState() {
    productController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    _searchbtn;
    super.initState();
  }

  bool isEmpty() {
    setState(() {
      if (productController.text.isEmpty ||
          priceController.text.isEmpty ||
          quantityController.text.isEmpty) {
        _btnEnabled = false;
      } else {
        _btnEnabled = true;
      }
    });
    return _btnEnabled;
  }

  Map<String, dynamic> product;
  List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nouvelle Ligne de commande'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Sales()));
              }),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onFieldSubmitted: null,
                              onChanged: (value) {
                                isEmpty();
                              },
                              controller: productController,
                              decoration: InputDecoration(
                                labelText: 'Produit',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32)),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 25),
                              ),
                              keyboardType: TextInputType.number,
                              readOnly: true,
                              enabled: false,
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () async {
                                var productName = productController.text;
                                var productPrice = priceController.text;
                                setState(() {
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context)=>ProductPage(productName: productName, productPrice: productPrice)));
                                });
                              })
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onFieldSubmitted: null,
                        onChanged: (value) {
                          isEmpty();
                        },
                        controller: priceController,
                        decoration: InputDecoration(
                          labelText: 'Prix de Vente',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 25),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onFieldSubmitted: null,
                        onChanged: (value) {
                          isEmpty();
                        },
                        controller: quantityController,
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: 'Quantité',
                            hintStyle: TextStyle(color: Colors.teal.shade900),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15)),
                        keyboardType: TextInputType.number,
                        validator: (String txt) {
                          if (txt.length == 10) {
                            Future.delayed(Duration.zero).then((_) {
                              setState(() {
                                _btnEnabled = true;
                              });
                            });
                          } else {
                            Future.delayed(Duration.zero).then((_) {
                              setState(() {
                                _btnEnabled = false;
                              });
                            });
                          }
                          return txt;
                        },
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 330),
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {}, child: Text('Ajouter')))
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> buildInput() {
  return [
    Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 20),
      child: TextFormField(
        key: Key('email'),
        decoration: InputDecoration(
          labelText: 'Produit',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
          suffixIcon: Icon(Icons.search),
        ),
        keyboardType: TextInputType.number,
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Prix de Vente',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
        ),
        keyboardType: TextInputType.number,
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
            labelText: 'Quantité',
            hintStyle: TextStyle(color: Colors.teal.shade900),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
        keyboardType: TextInputType.number,
      ),
    ),
    Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 330),
            width: double.infinity,
            child: ElevatedButton(onPressed: () {}, child: Text('Ajouter')))
      ],
    ),
  ];
}

List<Widget> bottomButton() {
  return [
    Container(
      alignment: Alignment.bottomCenter,
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Ajouter'),
      ),
    )
  ];
}
