import 'package:flutter/material.dart';
import 'package:login_form/model/vendeur-model.dart';

class SellerPageDetail extends StatefulWidget {
  final Seller seller;
  SellerPageDetail({this.seller});
  @override
  _SellerPageDetailState createState() => _SellerPageDetailState();
}
TextEditingController loginController;
TextEditingController nameController;
TextEditingController surnameController;
TextEditingController phoneController;
class _SellerPageDetailState extends State<SellerPageDetail> {


  @override
  void initState() {
    super.initState();
    var name = widget.seller.lastName;
    var login = widget.seller.login;
    var phone = widget.seller.phone;
    var lName = widget.seller.firstName;
    loginController = TextEditingController(text: login);
    nameController = TextEditingController(text: name);
    surnameController = TextEditingController(text: lName);
    phoneController = TextEditingController(text: phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editer un Vendeur'),
        actions: [
          IconButton(icon: Icon(Icons.clear),
              onPressed: (){}),
          IconButton(icon: Icon(Icons.delete),
              onPressed: (){}),
        ],
      ),
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
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: loginController,
        decoration: InputDecoration(
            labelText: 'login',
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
            contentPadding:
            EdgeInsets.symmetric(vertical: 12, horizontal: 25)),

      ),
    ),
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: nameController,
        decoration: InputDecoration(
            labelText: 'nom',
            hintStyle: TextStyle(color: Colors.teal.shade900),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            contentPadding:
            EdgeInsets.symmetric(vertical: 10, horizontal: 15)),

      ),
    ),
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: surnameController,
        decoration: InputDecoration(
            labelText: 'Prenom',
            hintStyle: TextStyle(color: Colors.teal.shade900),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            contentPadding:
            EdgeInsets.symmetric(vertical: 10, horizontal: 15)),

      ),
    ),
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: phoneController,
        decoration: InputDecoration(
            labelText: 'telephone',
            hintStyle: TextStyle(color: Colors.teal.shade900),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            contentPadding:
            EdgeInsets.symmetric(vertical: 10, horizontal: 15)),

      ),
    ),
    Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.maxFinite,
      child: RaisedButton(
        child: Text('SAUVEGARDER'),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.blue,
      ),
    )
  ];
}
