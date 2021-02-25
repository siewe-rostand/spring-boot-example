import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_form/home-drawer.dart';
import 'package:login_form/manquant/nouveau-manquant.dart';
import 'package:login_form/model/manquant-model.dart';

import 'manquant-service.dart';

class ManquantsClass extends StatefulWidget {
  @override
  _ManquantsClassState createState() => _ManquantsClassState();
}

class _ManquantsClassState extends State<ManquantsClass> {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final lastMidnight = new DateTime.utc(now.year, now.month, 1);
    final DateFormat formatter = DateFormat('dd/MM/yyyy - HH:mm');
    final DateFormat formatter1 = DateFormat('yyyy-MM-dd').add_Hm();
    final String formatted = formatter.format(lastMidnight);
    final String formatted1 = formatter1.format(lastMidnight);

    final newDate = new DateTime.utc(now.year, now.month+1,).subtract(Duration(days: 1));
    final String newFormatted = formatter.format(newDate);
    final String newFormatted1 = formatter1.format(newDate);
    return Scaffold(
      drawer: BuilderDrawer(),
      appBar: AppBar(
        title: Text('Manquants'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, right: 10,left: 10),
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue, width: 2, style: BorderStyle.solid)),
                child: Text(
                  '$formatted   $newFormatted',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
              FutureBuilder<List<Manquants>>(
                future: ManquantAPI.fetchManquants(2,formatted1,newFormatted1),
                builder: (BuildContext context, AsyncSnapshot<List<Manquants>> snapshot) {
                  if (snapshot.hasData) {
                    List<Manquants> stores = snapshot.data;
                    var cout = stores[0].cout.round()*stores[0].quantity.round();
                    print(cout);
                    print(stores);
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text('Total Manquants : $cout  Fcfa'))),
                          ListView(
                            shrinkWrap: true,
                            children: stores
                                .map(
                            (Manquants post){
                              return Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        title: Text(post.productName),
                                        subtitle: Text('${post.createdDate} par  ${post.userName}' ),
                                      ),
                                    ),
                                    Text(post.quantity.ceil().toString()),
                                    Divider(),
                                  ],
                                ),
                              );
                            }
                            ).toList(),
                          ),
                        ],
                      ),
                    );
                  } else {
                    List<Manquants> stores = snapshot.data;
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
              MaterialPageRoute(builder: (context) => NouveauManquant()));
        },
      ),
    );
  }
}
