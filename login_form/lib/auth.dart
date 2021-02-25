import 'dart:async';

/*abstract class BaseAuth{
  Stream<User> get onAuthStateChange;
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signedOut();
}

class Auth implements BaseAuth{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<User> get onAuthStateChange{
    return firebaseAuth.authStateChanges();
  }

  Future<String> signInWithEmailAndPassword(String email, String password)async{
    User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)) .user;
    user.email;
    return user?.uid;
  }
  Future<String> createUserWithEmailAndPassword(String email, String password) async{
    User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return user?.uid;
  }
  Future<String> currentUser() async{
    User user = firebaseAuth.currentUser;
    return user?.uid;
  }
  Future<void> signedOut() async {
    return firebaseAuth.signOut();
  }

}*/
import 'package:flutter/material.dart';
import 'package:login_form/model/product-model.dart';
import 'file:///C:/Users/ROSTAND/IdeaProjects/login_form/lib/product/choose-selected-product.dart';
import 'package:login_form/vente/vente-produit-qty.dart';

class NewView extends StatefulWidget {
  @override
  _NewViewState createState() => _NewViewState();
}

class _NewViewState extends State<NewView> {
  Key submit;
  TextEditingController productController;

  TextEditingController priceController;

  TextEditingController quantityController;
  bool _isButtonDisabled = true;
  bool isEmpty() {
    setState(() {
      if ((productController.text != " " &&
              priceController.text != " " &&
              quantityController.text != " ") ||
          (productController == null &&
              priceController == null &&
              quantityController == null)) {
        _isButtonDisabled = true;
      }
    });
    return _isButtonDisabled;
  }

  @override
  void initState() {
    productController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    if ((productController.text.trim() != "") &&
        (priceController.text.trim() != "") &&
        (quantityController.text.trim() != "")) {
      _isButtonDisabled = true;
    } else {
      _isButtonDisabled = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
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
                        isEmpty();
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
                      initialValue: null,
                      onChanged: (value) {
                        isEmpty();
                      },
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
                              key: submit,
                              onPressed: _isButtonDisabled
                                  ? () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SaveSale(
                                                    price: int.parse(
                                                        priceController.text),
                                                    name:
                                                        productController.text,
                                                    qty:
                                                        double.parse(quantityController.text),
                                                  )));
                                    }
                                  : null,
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
}
