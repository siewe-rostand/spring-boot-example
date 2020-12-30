import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_form/home-page.dart';
import 'package:login_form/splash-sreen.dart';
import 'package:login_form/vente-nouveau.dart';

class Sales extends StatelessWidget {
  String jwt;
  Map payload;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouvelle Vente'),
        leading: IconButton(icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
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
                  child: FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NouvelleVente()));
                    },
                    child: Text('Ajouter une nouvelle ligne de commande'),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(2, 450, 2, 0),
                    alignment: Alignment.bottomCenter,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(hintText: '0',
                          suffixText: 'FCFA'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      onPressed: () {  },
                      child: Text('ENREGISTRER LA VENTE'),

                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => NouvelleVente()),);
          }),
    );
  }
}
