import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_form/auth.dart';

class Sales extends StatelessWidget {
  String jwt;
  Map payload;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nouvelle Vente'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 35,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NewView()));
                      },
                      child: Text('Ajouter une nouvelle ligne de commande'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration:
                          InputDecoration(hintText: '', suffixText: 'FCFA'),
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text('ENREGISTRER LA VENTE'),
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
