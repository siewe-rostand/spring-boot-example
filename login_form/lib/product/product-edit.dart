import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_form/product/product-services.dart';
import 'package:login_form/save-product-services.dart';

import '../model/product-model.dart';

class EditProduct extends StatefulWidget {
  final Product product;
  EditProduct({this.product});
  @override
  _EditProductState createState() => _EditProductState();
}

File _image;

class _EditProductState extends State<EditProduct> {
  TextEditingController productNameController = new TextEditingController();
  TextEditingController productPriceController = new TextEditingController();

  _imgFromCamera() async {
    // ignore: deprecated_member_use
    File image = (await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50));

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    File image = (await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50));

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.cancel),
                    title: new Text('Cancel'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    var name = widget.product.name;
    var price = widget.product.price.ceil().toString();
    var imageByte = widget.product.image;
    productNameController = TextEditingController(text: name);
    productPriceController = TextEditingController(text: price);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Editer un produit'),
            actions: [
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AlertDialog(
                        title: Text('Confirmation'),
                        content: Text('Are you sure to delete this product ?'),
                        actions: [
                          FlatButton(
                            child: Text('CANCEL'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () async {
                              var futureVentes;
                              setState(() {
                                futureVentes =
                                    ProductAPI.deleteProduct(widget.product.id);
                              });
                              if (futureVentes != null) {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductList2()));
                                Fluttertoast.showToast(
                                    msg:
                                        'the product has been successfully deleted',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.SNACKBAR,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.lightGreen,
                                    textColor: Colors.white);
                              } else {
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: 'internal error',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.SNACKBAR,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white);
                                print('error');
                              }
                            },
                          )
                        ],
                      );
                    }));
                  })
            ],
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 32,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.grey[200],
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: TextFormField(
                        controller: productNameController,
                        decoration: InputDecoration(
                            labelText: 'Designation',
                            hintStyle: TextStyle(color: Colors.teal.shade900),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: TextFormField(
                        controller: productPriceController,
                        decoration: InputDecoration(
                            labelText: 'Prix de vente',
                            hintStyle: TextStyle(color: Colors.teal.shade900),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15)),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: double.maxFinite,
                  child: RaisedButton(
                    onPressed: () {
                      Future<Product> futureProds;
//                      var imageBytes = _image.readAsBytesSync();
//                      var base64Img = base64Encode(imageBytes);
                      var product = Product(
                        id: widget.product.id,
                        name: productNameController.value.text,
                        price: double.parse(productPriceController.value.text),
                        storeId: 2,
                      );
                      var productMap = Product.toMap(product);
                      print(productMap);
                      var re = ProductAPI.updateProduct(productMap);

                      print(ProductAPI.updateProduct(productMap));
                      if (re != null) {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductList2()));
                        Fluttertoast.showToast(
                            msg: 'Your product has been successfully updated',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.lightGreen,
                            textColor: Colors.white);
                      } else {
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                            msg: 'Internal Error, please try later',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white);
                        print('error');
                      }
                    },
                    child: Text(
                      'Save',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
