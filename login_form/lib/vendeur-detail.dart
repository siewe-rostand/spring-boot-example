import 'package:flutter/material.dart';

class SellerPage extends StatefulWidget {
  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vendeurs'),),
      body:Center(
        child: Column(
          children: buildInput(),
        ),
      ) ,
    );
  }
}

List<Widget> buildInput() {
  return [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Phone number',
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
            contentPadding:
            EdgeInsets.symmetric(vertical: 12, horizontal: 25)),

      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'password',
            hintStyle: TextStyle(color: Colors.teal.shade900),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            contentPadding:
            EdgeInsets.symmetric(vertical: 10, horizontal: 15)),

      ),
    ),
  ];
}
