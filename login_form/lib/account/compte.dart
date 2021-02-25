import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:login_form/account/editer-profil.dart';
import 'package:login_form/home-drawer.dart';
import 'package:login_form/model/account-model.dart';
import 'package:login_form/product/product-detail.dart';
import 'package:login_form/subscription/subscription.dart';

class AccountPage extends StatefulWidget {


  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  LocalStorage localStorage = LocalStorage('user_info');

  String lastName(dynamic product) {
    return product['lastName'];
  }

  String firstName(dynamic product) {
    return product['firstName'];
  }
  String createdDate(dynamic product) {
    return product['createdDate'];
  }
  String phone(dynamic product) {
    return product['phone'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Account'),

        ),
        drawer: BuilderDrawer(),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future:ProductView.accountDetail(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
//                          print(snapshot.data.name);
                          localStorage.setItem('userName', snapshot.data.name);
                          localStorage.setItem('userId', snapshot.data.id);
//                          var name =localStorage.getItem('userName');
//                          print('/////');
//                          print(name);
                          return Container(
                            padding: EdgeInsets.all(15),
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('name',style: TextStyle(fontSize: 18),),
                                      ),
                                      Text(snapshot.data.lastName,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, ),),
                                    ],
                                  ),
                                ),
                                Divider(thickness: 2,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Surname',style: TextStyle(fontSize: 18),),
                                      ),
                                      Text(snapshot.data.firstName,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, ),),
                                    ],
                                  ),
                                ),
                                Divider(thickness: 2,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Telephone',style: TextStyle(fontSize: 18),),
                                      ),
                                      Text(snapshot.data.phone,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, ),),
                                    ],
                                  ),
                                ),
                                Divider(thickness: 2,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Creation date',style: TextStyle(fontSize: 18),),
                                      ),
                                      Text(snapshot.data.createdDate,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, ),),
                                    ],
                                  ),
                                ),
                                Divider(thickness: 2,),
                                Column(
                                  children: [
                                    Container(
                                      child: FlatButton(onPressed: (){
                                        var account = Account(
                                          nbStores: snapshot.data.id,
                                          pricePerStore: snapshot.data.pricePerStore,
                                          expiryDate: snapshot.data.expiryDate
                                        );
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MySubscription(account: account,)));
                                      },
                                          child: Text('My Subscription',style: TextStyle(color: Colors.blue,fontSize: 18),)),
                                      width: double.infinity,
                                    ),
                                    Divider(thickness: 2,),
                                    Container(
                                      child: FlatButton(onPressed: (){
                                        var account = Account(
                                          firstName: snapshot.data.firstName,
                                          lastName: snapshot.data.lastName,
                                          phone: snapshot.data.phone
                                        );
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditProfile(account: account,)));
                                      },
                                          child: Text('Edit profile',style: TextStyle(color: Colors.blue,fontSize: 18),)),
                                      width: double.infinity,
                                    ),
                                    Divider(thickness: 2,),
                                    Container(
                                      child: FlatButton(onPressed: (){},
                                          child: Text('Change Password',style: TextStyle(color: Colors.blue,fontSize: 18),)),
                                      width: double.infinity,
                                    ),
                                    Divider(thickness: 2,),
                                    Container(
                                      child: FlatButton(onPressed: (){},
                                          child: Text('Change language',style: TextStyle(color: Colors.blue,fontSize: 18),)),
                                      width: double.infinity,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        // By default, show a loading spinner.
                        return Center(child: Container(child: CircularProgressIndicator()));
                      },
                  ),
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }
}
