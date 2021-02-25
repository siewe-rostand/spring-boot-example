import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_form/approvisionnement/approvisionnement-services.dart';
import 'package:login_form/approvisionnement/nouveau-approvisionnnement.dart';
import 'package:login_form/home-drawer.dart';
import 'package:login_form/manquant/nouveau-manquant.dart';
import 'package:login_form/model/approvisionnement-model.dart';
import 'package:login_form/model/manquant-model.dart';


class ApprovisionnementsPage extends StatefulWidget {
  @override
  _ApprovisionnementsPageState createState() => _ApprovisionnementsPageState();
}

class _ApprovisionnementsPageState extends State<ApprovisionnementsPage> {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final lastMidnight = new DateTime(now.year, now.month, now.day);
    final lastMidnight1 = new DateTime(now.year, now.month, 1);
    final DateFormat formatter = DateFormat('dd/MM/yyyy - HH:mm');
    final DateFormat formatter1 = DateFormat('yyyy-MM-dd').add_Hm();
    final String formatted = formatter.format(lastMidnight);
    final String formatted1 = formatter1.format(lastMidnight1);

    //final newDate = new DateTime(now.year, now.month+1, 0);
    final newDate = new DateTime.utc(now.year, now.month+1,).subtract(Duration(days: 1));
    final String newFormatted = formatter.format(newDate);
    final String newFormatted1 = formatter1.format(newDate);
    print(formatted1);
    print(newFormatted1);
    return Scaffold(
      drawer: BuilderDrawer(),
      appBar: AppBar(
        title: Text('Approvisionnement'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, right: 10,left: 10),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue, width: 2, style: BorderStyle.solid)),
                child: Text(
                  '$formatted   '  '  $newFormatted',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text('Total Manquants : 0  Fcfa'))),
              FutureBuilder<List<Approvisionnement>>(
                future: ApprovisionnementAPI.fetchApprovisionnements(2,formatted1,newFormatted1),
                builder: (BuildContext context, AsyncSnapshot<List<Approvisionnement>> snapshot) {
                  if (snapshot.hasData) {
                    List<Approvisionnement> stores = snapshot.data;
                    print(stores);
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView(
                        shrinkWrap: true,
                        children: stores
                            .map(
                                (Approvisionnement post){
                              return Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(post.productName),
                                              subtitle: Text('${post.createdDate} par  ${post.userName}' ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(post.quantity.ceil().toString())
                                  ],
                                ),
                              );
                            }
                        ).toList(),
                      ),
                    );
                  } else {
                    List<Approvisionnement> stores = snapshot.data;
                    // print(stores);
                    return Center(child: Container(child: CircularProgressIndicator()));
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NouveauApprovisionnement()));
        },
      ),
    );
  }
}
