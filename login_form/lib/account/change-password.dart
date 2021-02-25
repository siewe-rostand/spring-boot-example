import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:login_form/account/compte.dart';
import 'package:login_form/manquant/choose-product.dart';
import 'package:login_form/manquant/manquant.dart';
import 'package:login_form/model/manquant-model.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var name;
  TextEditingController pController=TextEditingController();
  TextEditingController cpController=TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AccountPage()));
          },
        ),
        title: Text('Nouveau Manquant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: null,
              controller: pController,
              decoration: InputDecoration(
                labelText: 'Password',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 25),
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Confirm password',
                    hintStyle: TextStyle(color: Colors.teal.shade900),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
                keyboardType: TextInputType.visiblePassword,
              )),
          Container(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('Change Password'),
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
