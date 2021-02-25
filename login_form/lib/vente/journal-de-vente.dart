
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_form/home-drawer.dart';
import 'package:login_form/model/vente-model.dart';
import 'package:login_form/vente/bar-chart.dart';
import 'package:login_form/vente/journal-vente-detail.dart';
import 'package:login_form/vente/vente-produit-qty.dart';
import 'package:login_form/vente/vente-services.dart';


class SaleNews extends StatefulWidget {
  final String date;
  SaleNews({this.date});
  @override
  _SaleNewsState createState() => _SaleNewsState();
}

class _SaleNewsState extends State<SaleNews> {
  Future<PickUp> futurePickUp;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     DateTime now = DateTime.now();
     var lastMidnight = new DateTime.utc(now.year, now.month, 1);
     DateFormat formatter = DateFormat('dd/MM/yyyy - HH:mm');
     DateFormat formatter1 = DateFormat('yyyy-MM-dd').add_Hm();
    
    //today's time
    var todayMidnight = DateTime.utc(now.year, now.month, now.day, 23,59);
    var todayMorning = DateTime.utc(now.year, now.month, now.day);
     String formattedTodayMid = formatter.format(todayMidnight);
     String formattedTodayMor = formatter.format(todayMorning);
     String formattedTodayMid1 = formatter1.format(todayMidnight);
     String formattedTodayMor1 = formatter1.format(todayMorning);


     String formatted = formattedTodayMor;
     String formatted1 = formattedTodayMor1;

    //tomorrow time
    var tomorrowMidnight = DateTime.utc(now.year, now.month, now.day + 1, 23,59);
    var tomorrowMorning = DateTime.utc(now.year, now.month, now.day + 1);
     String formattedTMid = formatter.format(tomorrowMidnight);
     String formattedTMo = formatter.format(tomorrowMorning);
    
    //yesterday time
    var yesterdayMidnight = DateTime.utc(now.year, now.month, now.day - 1, 23,59);
    var yesterdayMorning = DateTime.utc(now.year, now.month, now.day - 1);
     String formattedYMid = formatter.format(yesterdayMidnight);
     String formattedYMid1 = formatter1.format(yesterdayMidnight);
     String formattedYMo = formatter.format(yesterdayMorning);
     String formattedYMo1 = formatter1.format(yesterdayMorning);

    //this week time
    var thisWeekMidnight = DateTime.utc(now.year, now.month, now.day , 23,59).add(Duration(days:DateTime.daysPerWeek -now.weekday));
    var thisWeekMorning = DateTime.utc(now.year, now.month, now.day).subtract(Duration(days:now.weekday- 1));
     String formattedLWMid = formatter.format(thisWeekMidnight);
     String formattedLWMo = formatter.format(thisWeekMorning);

    //this week time
    var lastWeekMidnight = DateTime.utc(now.year, now.month, now.day , 23,59).add(Duration(days:DateTime.daysPerWeek -now.weekday));
    var lastWeekMorning = DateTime.utc(now.year, now.month, now.day).subtract(Duration(days:now.weekday- 1));
     String formattedTWMid = formatter.format(lastWeekMidnight);
     String formattedTWMid1 = formatter1.format(lastWeekMidnight);
     String formattedTWMo = formatter.format(lastWeekMorning);
     String formattedTWMo1 = formatter1.format(lastWeekMorning);
     print(formattedTWMo1);

    //this month time
    var lastMonthMidnight = DateTime.utc(now.year, now.month+1,).subtract(Duration(days: 1));
    var lastMonthMorning = DateTime.utc(now.year, now.month, 1);
     String formattedLMMid = formatter.format(lastMonthMidnight);
     String formattedLMMid1 = formatter1.format(lastMonthMidnight);
     String formattedLMMo = formatter.format(lastMonthMorning);
     String formattedLMMo1 = formatter1.format(lastMonthMorning);

    var yesterdaySixThirty = DateTime(now.year, now.month, now.day - 1, 6, 30);

    var newDate = new DateTime.utc(now.year, now.month+1,).subtract(Duration(days: 1));
     String newFormatted =formattedTodayMid;
     String newFormatted1 = formattedTodayMid1;

    if(widget.date == 'yesterday'){
      setState(() {
        formatted= formattedYMo;
        newFormatted = formattedYMid;
        formatted1 =formattedYMo1;
        newFormatted1=formattedYMid1;
      });
    } if(widget.date == 'this_week'){
      setState(() {
        formatted= formattedTWMo;
        newFormatted = formattedTWMid;
        formatted1 =formattedTWMo1;
        newFormatted1 = formattedTWMid1;
      });
    } if(widget.date == 'this_month'){
      setState(() {
        formatted= formattedLMMo;
        newFormatted = formattedLMMid;
        formatted1 =formattedLMMo1;
        newFormatted1 = formattedLMMid1;
      });
    } if(widget.date == 'today'){
      setState(() {
        formatted= formattedTodayMor;
        newFormatted = formattedTodayMid;
        formatted1 =formattedTodayMor1;
        newFormatted1 = formattedTodayMid1;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Sale\'s news'),
        actions: [
          IconButton(
              icon: Icon(Icons.map),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BarChartPage()));
              }
          )
        ],
      ),
      drawer: BuilderDrawer(),
      body: Center(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20,left: 10,right: 10),
              child: FlatButton(
                onPressed: ()=>_onAlertButtonsPressed(context),
                child:Text(
                  '$formatted   $newFormatted',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                padding: EdgeInsets.all(20),
              )
              /*Text(
                '$formatted   $newFormatted',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),*/
            ),
            FutureBuilder(
                future: VenteAPI.getVenteByProduct(2,formatted1,newFormatted1),
                builder: (context, AsyncSnapshot snapshot){
                  List<OrderedProducts> stores = snapshot.data;
                  getTotal(){
                    var total =0;
                    int index = 0;
                    while(index < stores.length) {
                      print(stores[index]);
                      var i =stores[index];
                      total += i.totalVentes.toInt();
                      index++;
                    }
                    return total;
                  }
                  getTotalBenefice(){
                    var total =0;
                    int index = 0;
                    while(index < stores.length) {
                      print(stores[index]);
                      var i =stores[index];
                      total += i.benefice.toInt();
                      index++;
                    }
                    return total;
                  }
                  return Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text.rich(
                            TextSpan(children: [
                              TextSpan(text: "Total Vente: ", style: TextStyle(fontSize: 23)),
                              TextSpan(
                                text: ' ${getTotal()} ',
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' FCFA ',
                                style: TextStyle(
                                  fontSize: 23,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Text.rich(
                            TextSpan(children: [
                              TextSpan(text: "Benefice: ", style: TextStyle(fontSize: 23)),
                              TextSpan(
                                text: ' ${getTotalBenefice()} ',
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' FCFA ',
                                style: TextStyle(
                                  fontSize: 23,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  );
                }
            ),

            FutureBuilder(
              future: VenteAPI.getPickupData(2,formatted1,newFormatted1),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<PickUp> stores = snapshot.data;
                  return Column(
                    children: stores.map((PickUp post) {
                      List orderProducts = post.ventes.orderedProducts;
                      // title: Text(orderProducts.length>0 ? post.ventes.orderedProducts[0].name : '')
                      return GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DeleteJournal(
                            qty: orderProducts.length > 0 ? orderProducts[0].quantity:'',
                            prixVente: orderProducts.length > 0 ? orderProducts[0].prixVente:'',
                            prixTotal:orderProducts.length > 0 ? post.ventes.prixTotal:'' ,
                            userName:orderProducts.length > 0 ? post.ventes.userName:'' ,
                            createdDate: orderProducts.length > 0 ? post.ventes.createdDate:'',
                            productName: orderProducts.length > 0? post.ventes.orderedProducts[0].name:'',
                            id:orderProducts.length > 0 ? post.ventes.id:'' ,
                          )));
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 25,left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                orderProducts.length > 0
                                    ? post.ventes.prixTotal.ceil().toString() +
                                        ' Fcfa'
                                    : '',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: orderProducts.length > 0
                                          ? orderProducts[0]
                                                  .quantity
                                                  .ceil()
                                                  .toString() +
                                              ' x '
                                          : '',
                                      style: TextStyle(fontSize: 16)),
                                  TextSpan(
                                    text: orderProducts.length > 0
                                        ? post.ventes.orderedProducts[0].name
                                        : '',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: orderProducts.length > 0
                                          ? post.ventes.createdDate + ' par '
                                          : '',
                                      style: TextStyle(fontSize: 13)),
                                  TextSpan(
                                    text: orderProducts.length > 0
                                        ? post.ventes.userName
                                        : '',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Center(
                    child: Container(child: CircularProgressIndicator()));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SaveSale()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _onAlertButtonsPressed(context) {
    showDialog(
        context: context,
      builder: (BuildContext context){
          return SimpleDialog(
            title: Text('Select the time please'),
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Theme.of(context).primaryColor)) ,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child:Text(
                            'Today',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Theme.of(context).primaryColor)),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SaleNews(date: 'this_week',)));
                            },
                          child:Text(
                            'This Week',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Theme.of(context).primaryColor)),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SaleNews(date: 'this_month',)));
                          },
                          child:Text(
                            'This Month',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Theme.of(context).primaryColor)),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                    ],
                  ),Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SaleNews(date: 'yesterday',)));
                          },
                          child:Text(
                            'Yesterday',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Theme.of(context).primaryColor)),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          onPressed: () {},
                          child:Text(
                            'last week',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Theme.of(context).primaryColor)),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          onPressed: () {},
                          child:Text(
                            'last month',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Theme.of(context).primaryColor)),
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
      }
    );
  }
}

List<PickUp> pickUpdetail;
