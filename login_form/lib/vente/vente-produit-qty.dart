
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:login_form/auth.dart';
import 'package:login_form/model/product-model.dart';
import 'package:login_form/model/vente-model.dart';
import 'package:login_form/vente/vente-services.dart';

import '../login-data.dart';

final storage = FlutterSecureStorage();

class SaveSale extends StatefulWidget {
  final int price;
  final String name;
  final double qty;
  final String id;
  final List products;
  SaveSale({Key key,this.price,this.name,this.qty,this.id,this.products,}):super(key: key);
  @override
  _SaveSaleState createState() => _SaveSaleState();
}

class _SaveSaleState extends State<SaveSale> {

  LocalStorage storage = LocalStorage('orderedProducts');
  LocalStorage localStorage = LocalStorage('todo_app');
  TodoList list = TodoList();
  bool initialized = false;

  var name = ' ';
  var price = ' ';
  var qty = ' ';

  List addedItems;
  List<OrderedProducts> orders;
  var total =0;
  Future<PickUp> futurePickUp;
  TextEditingController totalPriceController;
  Map map;
  @override
  void initState() {
//      _list=storage.getItem('productLists1');
//
//    if( storage.getItem('productLists1')==null )
//      {
//        _list=[];
//      }
//      _list = storage.getItem(
//          'productLists1');


    addedItems=localStorage.getItem('products1');

    if( addedItems==null )
    {
      addedItems=[];
    }else {
      addedItems = localStorage.getItem(
          'products1');
        list.items = List<OrderedProducts>.from(
          (addedItems).map(
                (item) => OrderedProducts(
              productId: item['productId'],
              name: item['name'],
              quantity: item['quantity'],
              prixVente: item['prixVente'],
            ),
          ),
        );

    }
   /* var _list=storage.getItem('productLists12');
    if( storage.getItem('productLists12')==null )
      {
        _list=[];
      }
      _list = storage.getItem(
          'productLists12');*/
    print("***********************");
    print(list.items);
    print('++++++');
    print(addedItems);

    totalPriceController =TextEditingController(text: getTotal().toString());

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouvelle Vente'),
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: (){
            localStorage.clear();
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: [
              Center(
                child: FutureBuilder(
                  future: storage.ready,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
//                    if (snapshot.data == null) {
//                      return Center(
//                        child: CircularProgressIndicator(),
//                      );
//                    }
                    if(snapshot.hasData){
                      return Column(
                        children: <Widget>[
                          ListView(
                            children: list.items.map((item) {
                              print(item.name);
                              return Card(
                                child: ListTile(
                                  title: Text(item.name),
                                  subtitle: Text('${item.quantity.ceil()} x ${item.prixVente.ceil()} '),
                                  trailing: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                            // itemExtent: 50.0,
                            shrinkWrap: true,
                          ),
                        ],
                      );

                    }

//                    if (!initialized) {
//                      var items = storage.getItem('products1');
//
//                      if (items != null) {
//                        list.items = List<OrderedProducts>.from(
//                          (items as List).map(
//                                (item) => OrderedProducts(
//                              productId: item['productId'],
//                              name: item['name'],
//                              quantity: item['quantity'],
//                              prixVente: item['prixVente'],
//                            ),
//                          ),
//                        );
//                      }
//
//                      initialized = true;
//                    }
                  /*  List<Widget> widgets = list.items.map((item) {
                      print(item.name);
                      return ListTile(
                        title: Text(item.name),
                      );
                    }).toList();*/

                    else {
                      List<OrderedProducts> stores = snapshot.data;
                      print(stores);
                      return Center(child: Container(child: CircularProgressIndicator()));
                    }

                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewView()));
                  },
                  child: Text('Ajouter une nouvelle ligne de commande'),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: TextFormField(
                    controller: totalPriceController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: '',
                        suffixText: 'FCFA'),
                    enabled: false,
                    readOnly: true,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return AlertDialog(
                        title: Text('Confirmation'),
                        content: Text('Are you sure to save this sale ?'),
                        actions: [
                          FlatButton(
                            child: Text('CANCEL'),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text('OK'),
                            onPressed: ()async{
                              var vente = Ventes(
                                storeId: 2,
                                orderedProducts: addedItems,
                                prixTotal: getTotal().toDouble(),
                                totalVentes: getTotalVente()
                              );
                              print('************');
                              print(getTotalVente());
                              String url ="$server_ip/api/ventes";
                              var jsonMap = Ventes.toMap(vente);
                                print(addedItems);
                                var re=await VenteAPI.apiRequest(url, jsonMap);
                                if (re != null){
                                  Navigator.of(context).pop();
                                  Fluttertoast.showToast(msg: 'la vente a ete bien enregistrer',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.lightGreen,
                                      textColor: Colors.white
                                  );
                                }else {
                                  Navigator.of(context).pop();
                                  Fluttertoast.showToast(msg: 'Erreur interne',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white

                                  );
                                  print('error');
                                }
                                print(re);

                            },
                          )
                        ],
                      );
                    }));

                  },
                  child: Text('ENREGISTRER LA VENTE'),
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getTotal(){
    var total =0;
    var orderProductsTotalPrice = list.items;
    int index = 0;
    while(index < orderProductsTotalPrice.length) {
      print(orderProductsTotalPrice[index]);
      var i =orderProductsTotalPrice[index];
      total += (i.prixVente * i.quantity).toInt();
      index++;
    }
    return total;
  }
  getTotalVente(){
    var total =0;
    var totalVente =0;
    var orderProductsTotalPrice = list.items;
    int index = 0;
    while(index < orderProductsTotalPrice.length) {
      print(orderProductsTotalPrice[index]);
      var i =orderProductsTotalPrice[index];
      total += (i.prixVente * i.quantity).toInt();
      totalVente += total;
      index++;
    }
    return totalVente;
  }
}
List<Product> addedProducts = [];

/*
FutureBuilder(
                        future: storage.ready,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!initialized) {
                            var items = storage.getItem('todos');

                            if (items != null) {
                              list.items = List<OrderedProducts>.from(
                                (items as List).map(
                                      (item) => OrderedProducts(
                                    productId: item['productId'],
                                    name: item['name'],
                                    quantity: item['quantity'],
                                    prixVente: item['prixVente'],
                                  ),
                                ),
                              );
                            }

                            initialized = true;
                          }
                          List<Widget> widgets = list.items.map((item) {
                            print(item.name);
                            return ListTile(
                              title: Text(item.name),
                            );
                          }).toList();


                          return Column(
                            children: <Widget>[
                              Expanded(
                                child: ListView(
                                  children: widgets,
                                  itemExtent: 50.0,
                                ),
                              ),
                            ],
                          );
                        },
                      ), */
/*
Wrap(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: _list.length,
                        itemBuilder: (context, index){
                          var prods = _list[index];
                          return ListTile(
                            //leading: Text(productName(snapshot.data[index]))
                            /*CircleAvatar(
                                radius: 30,
                 h                 backgroundImage: NetworkImage(
                                    snapshot.data[index]['strTeamBadge']))*/
                            title: Text('$prods'),
                            subtitle: Text('$price  X  $qty'),
                            trailing: IconButton(icon: Icon(Icons.clear,),onPressed: (){
                              Navigator.of(context).pop();
                            },),
                          );
                        }),
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewView()));
                        },
                        child: Text('Ajouter une nouvelle ligne de commande'),
                      ),
                    ),
                  ],
                )
 */