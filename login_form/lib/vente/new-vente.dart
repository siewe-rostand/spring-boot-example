import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:login_form/accueil.dart';
import 'package:login_form/model/product-model.dart';
import 'package:login_form/model/vente-model.dart';
import 'file:///C:/Users/ROSTAND/IdeaProjects/login_form/lib/product/choose-selected-product.dart';
import 'package:login_form/vente/vente-produit-qty.dart';



class NewVente extends StatefulWidget {
  final Product product;
  NewVente({this.product});

  @override
  _NewVenteState createState() => _NewVenteState();
}

class _NewVenteState extends State<NewVente> {
  LocalStorage storage = LocalStorage('orderedProducts');
  final LocalStorage localStorage = new LocalStorage('todo_app');
  TextEditingController productController;

  TextEditingController priceController;

  TextEditingController quantityController = TextEditingController();
  List orderProducts;
  List _list;
  final TodoList list = TodoList();
  List<OrderedProducts> orders;

  _addItem(String title, double price, double qty, int id) {
    setState(() {
      final item = new OrderedProducts(name: title, prixVente:price , productId:id , quantity:qty );
      list.items.add(item);
      _saveToStorage();
    });
  }

  _saveToStorage() {
    localStorage.setItem('orders', list.toJSONEncodable());
  }
  @override
  void initState() {
      if(widget.product.name == null || widget.product.price ==null){
        return null;
      }else{
        String newName = widget.product.name;
        double newPrice = widget.product.price;
        productController = TextEditingController(text: '$newName');
        priceController = TextEditingController(text: '${newPrice.ceil().toString()}');
      }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouvelle Ligne de commande'),
        actions: [
          IconButton(icon: Icon(Icons.arrow_back),
              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreHomePage()));
              }
          )
        ],
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
                            initialValue: null,
                            controller: productController,
                            decoration: InputDecoration(
                              labelText: 'Produit',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 25),
                            ),
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            enabled: false,
                            onChanged: (value){
                            },
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () async {
                              // open the product list screen
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectProduct()));
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: null,
                      onChanged: (value) {
                      },
                      controller: priceController,
                      decoration: InputDecoration(
                        labelText: 'Prix de Vente',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {},
                      controller: quantityController,
                      decoration: InputDecoration(
                        labelText: 'Quantité',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 330),
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                var data = OrderedProducts(
                                    productId: widget.product.id,
                                    name: productController.value.text,
                                    prixVente: double.parse(priceController.value.text),
                                    quantity: double.parse(quantityController.value.text),
                                );
                                var value =json.encode(data);

//                              orderProducts =storage.getItem('productLists1');
//                              if(orderProducts ==null){
//                                orderProducts=[];
//                              }
//                                orderProducts.add(value);
//                                storage.setItem('productLists1', orderProducts);
//
//                              var getData = storage.getItem('productLists1');
//                              print(getData);

                             /* _list =localStorage.getItem('productLists12');
                              if(_list ==null){
                                _list=[];
                              }
                                list.items.add(data);
                                localStorage.setItem('productLists12', list.items);
                                print('//////////');
                                print(_list);

                              var getData = storage.getItem('productLists12');
                              print(getData);*/


                                orderProducts = localStorage.getItem("products1");
                              if(orderProducts== null){
                                orderProducts=[];
                                //print(data);
                              }
                                //orders.add(data);
                                orderProducts.add(data);
                                localStorage.setItem("products1", orderProducts);
                              var newd= storage.getItem("products1");
                              print('------------');
                                print(newd);

                                //_addItem(productController.value.text,double.parse(priceController.value.text),double.parse(quantityController.value.text),widget.product.id);

                              Navigator.pop(context);
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SaveSale(
                                        )));
                              },
                              child: Text('Ajouter')))
                    ],
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
//  void _save() {
//    _addItem(productController.text,double.parse(priceController.text),double.parse(quantityController.text),widget.product.id);
//    controller.clear();
//  }
}
