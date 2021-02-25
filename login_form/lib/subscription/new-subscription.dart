import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_form/account/compte.dart';
import 'package:login_form/model/account-model.dart';

class RenewSubscription extends StatefulWidget {
  final Account account;
  RenewSubscription({this.account});
  @override
  _RenewSubscriptionState createState() => _RenewSubscriptionState();
}

class _RenewSubscriptionState extends State<RenewSubscription> {
  List<String> dropdownList = ['Monthly', 'Quarterly -5%', 'Half yearly -10%', 'Yearly -20%'];
  var  selectedItem;
  var discount;
  var total;
  var nTotal;
  var percent;
  @override
  void initState() {
    selectedItem = dropdownList[0];

    super.initState();
  }
  var gender;


  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final lastMidnight = new DateTime(now.year, now.month+1, now.day);
    final DateFormat formatter = DateFormat('dd MMMM yyyy  ');
    final String formatted = formatter.format(lastMidnight);
    total = widget.account.nbStores.ceil() * widget.account.pricePerStore.ceil();
    if(selectedItem == dropdownList[1]){
      setState(() {
        nTotal = total * 3;
        percent = nTotal *0.05;
        discount =nTotal-percent;
        total=discount;
      });
    }
    if(selectedItem == dropdownList[2]){
      setState(() {
        nTotal = total * 6;
        percent = nTotal *0.1;
        discount =nTotal-percent;
        total=discount;
      });
    }
    if(selectedItem == dropdownList[3]){
      setState(() {
        nTotal = total * 12;
        percent = nTotal *0.2;
        discount =nTotal-percent;
        total=discount;
      });
    }

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
        title: Text('Renew your Subscription'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 20,left: 10,right: 10),
          child: ListView(
            children: [

              Container(
                padding: EdgeInsets.only(top: 15,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Number of stores', style: TextStyle(fontSize: 22)),
                    Text('${widget.account.nbStores}',style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Divider(thickness: 2,),

              Container(
                padding: EdgeInsets.only(top: 15,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text('Subscription price: ',style: TextStyle(fontSize: 20))),
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text: " ${widget.account.pricePerStore.ceil()} Fcfa / ",
                            style: TextStyle(fontSize: 16)),
                        TextSpan(
                          text: ' Store /',
                          style: TextStyle(
                            fontSize: 16,),
                        ),
                        TextSpan(
                          text: ' month ',
                          style: TextStyle(
                            fontSize: 16,),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 2,),

              Container(
                padding: EdgeInsets.only(top: 15,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Text('Actual subscription period',style: TextStyle(fontSize: 23))),
                    DropdownButton<String>(
                      value: selectedItem,
                      selectedItemBuilder: (BuildContext context) {
                        return dropdownList.map<Widget>((String item) {
                          return Text(item);
                        }).toList();
                      },
                      items: dropdownList.map((String item) {
                        return DropdownMenuItem<String>(
                          child: Text('$item'),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (String string) => setState(() => selectedItem = string),

                    ),
                  ],
                ),
              ),
              Divider(thickness: 2,),

              Container(
                padding: EdgeInsets.only(top: 15,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('New Subscription\'s price', style: TextStyle(fontSize: 23),),
                    Text(total.ceil().toString(),style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Divider(thickness: 2,),
              Container(
                padding: EdgeInsets.only(top: 15,bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(' New expiring date ',style: TextStyle(fontSize: 22)),
                    Text('$formatted',style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15,bottom: 15),
                child: RaisedButton(onPressed: (){},
                    child: Text('BOOK NOW',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  color: Colors.blue,
                ),
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

}



