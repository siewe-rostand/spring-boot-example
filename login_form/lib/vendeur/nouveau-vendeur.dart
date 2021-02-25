import 'package:flutter/material.dart';

class NouveauVendeur extends StatefulWidget {
  @override
  _NouveauVendeurState createState() => _NouveauVendeurState();
}

class _NouveauVendeurState extends State<NouveauVendeur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouveau Vendeur'),
      ),
      body: ListView(
        children:[
          Container(
            padding: EdgeInsets.only(top: 15),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Login',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 25)),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Name',
                    hintStyle: TextStyle(color: Colors.teal.shade900),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
              )
          ),
          Container(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Surname',
                    hintStyle: TextStyle(color: Colors.teal.shade900),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
              )
          ),
          Container(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Phone',
                    hintStyle: TextStyle(color: Colors.teal.shade900),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
                keyboardType: TextInputType.phone,
              )
          ),
          Container(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Password',
                    hintStyle: TextStyle(color: Colors.greenAccent.shade200),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              )
          ),
          Container(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Confirm password',
                    hintStyle: TextStyle(color: Colors.greenAccent),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              )
          ),
          Container(
              width: double.maxFinite,
              child: RaisedButton(
                onPressed: (){},
                child: Text('ENREGISTRER',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                color: Colors.blue,
              )
          ),
        ],
        shrinkWrap: true,
      ),
    );
  }
}

List<Widget> buildInput() {
  return [
    Container(
      padding: EdgeInsets.only(top: 0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Login',
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
            contentPadding:
            EdgeInsets.symmetric(vertical: 12, horizontal: 25)),
      ),
    ),
    Container(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Name',
            hintStyle: TextStyle(color: Colors.teal.shade900),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            contentPadding:
            EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
      )
    ),
    Container(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Surname',
            hintStyle: TextStyle(color: Colors.teal.shade900),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            contentPadding:
            EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
      )
    ),
    Container(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Phone',
            hintStyle: TextStyle(color: Colors.teal.shade900),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            contentPadding:
            EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
        keyboardType: TextInputType.phone,
      )
    ),
    Container(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Password',
            hintStyle: TextStyle(color: Colors.teal.shade900),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            contentPadding:
            EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
      )
    ),
    Container(
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
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
      )
    ),
    Container(
      width: double.maxFinite,
      child: RaisedButton(
        onPressed: (){},
        child: Text('ENREGEISTRER'),
        color: Colors.blue,
      )
    ),
  ];
}
