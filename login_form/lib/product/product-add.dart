import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_form/model/product-model.dart';
import 'package:login_form/product/product-services.dart';

import '../login-data.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

File _image;


class _AddProductState extends State<AddProduct> {
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
                ],
              ),
            ),
          );
        });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
      Column(
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
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(
                      labelText: 'Product Name',
                      hintStyle: TextStyle(color: Colors.teal.shade900),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: TextFormField(
                  controller: productPriceController,
                  decoration: InputDecoration(
                      labelText: 'Product Price',
                      hintStyle: TextStyle(color: Colors.teal.shade900),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: (){
                  final String url = "$server_ip/api/products-with-image";
                  var productName = productNameController.text;
                  var productPrice = productPriceController.text;
                  Product products = Product(
                    name: productName,
                    price: double.parse(productPrice)
                  );

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
                            var productMap = Product.toMap(products);
                            print(productMap);
                            //await SaveProduct.createProduct1(products);
                            var res =await ProductAPI.postProducts(url, productMap);
                            print('//////');
                            print(res);
                          },
                        )
                      ],
                    );
                  }));

                },
                child: Text(
                  'Save Product',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                color: Colors.blue,
              ),
            ),
          ),
        ],
      )
    );
  }
}
