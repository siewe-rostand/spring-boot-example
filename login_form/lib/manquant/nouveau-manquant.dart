import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:login_form/manquant/choose-product.dart';
import 'package:login_form/manquant/manquant-service.dart';
import 'package:login_form/manquant/manquant.dart';
import 'package:login_form/model/manquant-model.dart';

import '../login-data.dart';

class NouveauManquant extends StatefulWidget {
  final Manquants manquants;
  NouveauManquant({this.manquants});
  @override
  _NouveauManquantState createState() => _NouveauManquantState();
}

class _NouveauManquantState extends State<NouveauManquant> {
  var name;
  TextEditingController pController;
  TextEditingController qController = TextEditingController();
  LocalStorage localStorage = LocalStorage('manquant');
  LocalStorage userStorage = LocalStorage('user_info');
  @override
  void initState() {
    name = localStorage.getItem('name');
    pController = TextEditingController(text: name);

    super.initState();
  }
  @override
  void dispose() {
    pController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd').add_Hm();
    final String formatted = formatter.format(now);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            localStorage.clear();
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ManquantsClass()));
          },
        ),
        title: Text('Nouveau Manquant'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: null,
                  controller: pController,
                  decoration: InputDecoration(
                    labelText: 'Produit',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                  ),
                  keyboardType: TextInputType.number,
                  readOnly: true,
                  enabled: false,
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
                            builder: (context) => SelectProduct2(
                                  check: 'manquants',
                                )));
                  })
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: qController,
                decoration: InputDecoration(
                    labelText: 'Quantité',
                    hintStyle: TextStyle(color: Colors.teal.shade900),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
                keyboardType: TextInputType.number,
              )),
          Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  String url = "$server_ip/api/manquants/";
                  var manquant = Manquants(
                    productId: widget.manquants.productId,
                    productName: pController.value.text,
                    quantity: double.parse(qController.value.text),
                    /*  userName: userStorage.getItem('userName'),
                    createdDate: formatted*/
                  );

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content: Text('Are you sure to save this sale ?'),
                      actions: [
                        FlatButton(
                          child: Text('CANCEL'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () {
                            //Future<Manquants> futureMAn;
                            var jsonMap = Manquants.toMap(manquant);
                            print(jsonMap);

                            var re = ManquantAPI.manquantRequest(url, jsonMap);
                            if (re != null) {
                              Navigator.of(context).pop();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ManquantsClass()));
                              Fluttertoast.showToast(
                                  msg: 'votre manquant a ete bien enregistrer',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.lightGreen,
                                  textColor: Colors.white);
                            } else {
                              Navigator.of(context).pop();
                              Fluttertoast.showToast(
                                  msg: 'Erreur interne',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white);
                              print('error');
                            }

                            print('/////////');
                          },
                        )
                      ],
                    );
                  }));
                },
                child: Text('VALIDER'),
                color: Colors.blue,
              )),
        ],
      ),
    );
  }
}

List<Widget> buildInput() {
  return [
    Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: null,
            //controller: pController,
            decoration: InputDecoration(
              labelText: 'Produit',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 25),
            ),
            keyboardType: TextInputType.number,
            readOnly: true,
            enabled: false,
          ),
        ),
      ],
    ),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Quantité',
              hintStyle: TextStyle(color: Colors.teal.shade900),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
          keyboardType: TextInputType.number,
        )),
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
          child: Text('VALIDER'),
          color: Colors.blue,
        )),
  ];
}
