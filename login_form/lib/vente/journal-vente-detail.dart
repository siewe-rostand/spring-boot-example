import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_form/model/vente-model.dart';
import 'package:login_form/vente/journal-de-vente.dart';
import 'package:login_form/vente/vente-services.dart';

class DeleteJournal extends StatefulWidget {
  final String createdDate;
  final String userName;
  final String productName;
  final double prixVente;
  final double prixTotal;
  final double qty;
  final int id;
  DeleteJournal({this.qty,this.userName,this.createdDate,this.prixTotal,this.prixVente,this.productName,this.id});
  @override
  _DeleteJournalState createState() => _DeleteJournalState();
}

class _DeleteJournalState extends State<DeleteJournal> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('${widget.createdDate} par ${widget.userName}',style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SaleNews()));
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
                    child: Card(
                      child: ListTile(
                        title: Text(widget.productName, style: TextStyle(fontSize: 18),),
                        subtitle: Text('${widget.qty.ceil()} x ${widget.prixVente.ceil()} = ${widget.prixTotal.ceil()}', style: TextStyle(fontSize: 16),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration:
                      InputDecoration(hintText: widget.prixTotal.ceil().toString(), suffixText: 'FCFA'),
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  child: FlatButton(
                    onPressed: () {
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
                                print(widget.id);
                                var futureVentes ;
                                setState(() {
                                  futureVentes =VenteAPI.deleteVente(widget.id);
                                });
                                if (futureVentes != null){
                                  Navigator.of(context).pop();
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SaleNews()));
                                  Fluttertoast.showToast(msg: 'the sale has been successfully deleted',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.lightGreen,
                                      textColor: Colors.white
                                  );
                                }else {
                                  Navigator.of(context).pop();
                                  Fluttertoast.showToast(msg: 'Erreur interne',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white

                                  );
                                  print('error');
                                }
                                print(futureVentes);

                              },
                            )
                          ],
                        );
                      }));

                    },
                    child: Text('ANNULER LA VENTE',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    color: Colors.red.shade600,
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
