import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:login_form/approvisionnement/approvisionnement-services.dart';
import 'package:login_form/login-data.dart';
import 'package:login_form/manquant/choose-product.dart';
import 'package:login_form/model/approvisionnement-model.dart';

class NouveauApprovisionnement extends StatefulWidget {
  final Approvisionnement approvisionnement;
  NouveauApprovisionnement({this.approvisionnement});
  @override
  _NouveauApprovisionnementState createState() => _NouveauApprovisionnementState();
}


class _NouveauApprovisionnementState extends State<NouveauApprovisionnement> {
  TextEditingController qController = TextEditingController();
  TextEditingController cTController = TextEditingController();
  TextEditingController pController= TextEditingController() ;
  var name;
  LocalStorage localStorage = LocalStorage('manquant');
  @override
  void initState() {
    name = localStorage.getItem('name');
    pController =TextEditingController(text: name);


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouveau Approvisionnement'),
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
                            builder: (context) => SelectProduct2(check: 'approvisionnement',)));
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
              )
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: cTController,
                decoration: InputDecoration(
                    labelText: 'Cout total',
                    hintStyle: TextStyle(color: Colors.teal.shade900),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
                keyboardType: TextInputType.number,
              )
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.maxFinite,
              child: RaisedButton(
                child: Text('VALIDER'),
                color: Colors.blue,
                onPressed: () {
                  var url ='$server_ip/api/approvisionnements/';
                  var Approvision = Approvisionnement(
                    productId: localStorage.getItem('id'),
                    productName: localStorage.getItem('name'),
                    coutTotal: double.parse(cTController.value.text),
                    quantity: double.parse(qController.value.text)
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
                            var Approve = Approvisionnement.toMap(Approvision);
                            await ApprovisionnementAPI.apiRequest(url, Approve);
                            print('/////////');
                            print(await ApprovisionnementAPI.apiRequest(url, Approve));
                          },
                        )
                      ],
                    );
                  }));
                },
              )
          ),
        ],
      ),
    );
  }
}
