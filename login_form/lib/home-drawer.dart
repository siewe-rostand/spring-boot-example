import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_form/accueil.dart';
import 'package:login_form/approvisionnement/approvisionnement.dart';
import 'package:login_form/home-page.dart';
import 'package:login_form/manquant/manquant.dart';
import 'package:login_form/product/product.dart';
import 'package:login_form/save-product-services.dart';
import 'package:login_form/sliding_cards.dart';
import 'package:login_form/vendeur/vendeur.dart';
import 'package:login_form/vente/journal-de-vente.dart';

import 'account/compte.dart';
import 'login-data.dart';

class BuilderDrawer extends StatefulWidget {
  @override
  _BuilderDrawerState createState() => _BuilderDrawerState();
}

class _BuilderDrawerState extends State<BuilderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
              height: 75,
              child: DrawerHeader(
                child: Text('MENU'),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.black26, Colors.blue],
                )),
              )),
          ListTile(
              title: Text('Accueil'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StoreHomePage()));
              }),
          ListTile(
            title: Text('Product'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SlidingProducts()));
            },
            leading: Icon(Icons.filter),
          ),
          ListTile(
            title: Text('Ventes'),
            leading: Icon(Icons.now_wallpaper),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SaleNews()));
            },
          ),
          ListTile(
            title: Text('Approvisionnements'),
            leading: Icon(Icons.print),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ApprovisionnementsPage()));
            },
          ),
          ListTile(
            title: Text('Manquants'),
            leading: Icon(Icons.flash_on),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ManquantsClass()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.supervisor_account,
              textDirection: TextDirection.ltr,
            ),
            title: Text('Vendeurs'),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SellerPage()));
              await storage.deleteAll();
            },
          ),
          ListTile(
            title: Text('Mon compte'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Se déconnecter'),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginForm()));
              await storage.deleteAll();
            },
          ),
        ],
      ),
    );
  }
}
