import 'package:flutter/material.dart';
import 'package:login_form/account/compte.dart';
import 'package:login_form/model/account-model.dart';
import 'package:login_form/subscription/new-subscription.dart';

class MySubscription extends StatefulWidget {
  final Account account;
  MySubscription({this.account});

  @override
  _MySubscriptionState createState() => _MySubscriptionState();
}

class _MySubscriptionState extends State<MySubscription> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AccountPage()));
          },
        ),
        title: Text('My Subscription'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(12),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Actual subscription period',style: TextStyle(fontSize: 23)),
                    Text('${widget.account.lastName}',style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Divider(thickness: 2,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Number of stores',style: TextStyle(fontSize: 23)),
                    Text('${widget.account.nbStores}',style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Divider(thickness: 2,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Subscription price',style: TextStyle(fontSize: 23)),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: "${widget.account.pricePerStore.ceil()} Fcfa / ",
                              style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: ' Store /',
                            style: TextStyle(
                                fontSize: 23,),
                          ),
                          TextSpan(
                            text: ' month ',
                            style: TextStyle(
                                fontSize: 23,),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 2,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Expired on',style: TextStyle(fontSize: 23)),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: widget.account.expiryDate != null ? Text('${widget.account.expiryDate}',style: TextStyle(
                          fontSize: 23,backgroundColor: Colors.green,
                          fontWeight: FontWeight.bold),) : Text('Expired',style: TextStyle(
                          fontSize: 23,backgroundColor: Colors.red.shade900,
                          fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 25),
                width: double.maxFinite,
                child: RaisedButton(onPressed: (){
                  var account = Account(
                    nbStores: widget.account.nbStores,
                    pricePerStore: widget.account.pricePerStore,
                  );
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RenewSubscription(account: account,)));
                },
                  child: Text('Renew', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),),
                  color: Colors.blue,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
