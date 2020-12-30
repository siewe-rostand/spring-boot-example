import 'package:flutter/material.dart';

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
          ),
          ListTile(
            title: Text('Produits'),
            onTap: (){
              Navigator.of(context).pop();
//              Navigator.pushReplacement(context,
//                  MaterialPageRoute(builder: (context) => Product()));
            },
            leading: Icon(Icons.filter),
          ),
          ListTile(
            title: Text('Ventes'),
            leading: Icon(Icons.now_wallpaper),
          ),
          ListTile(
            title: Text('Approvisionnements'),
            leading: Icon(Icons.print),
          ),
          ListTile(
            title: Text('Manquants'),
            leading: Icon(Icons.flash_on),
          ),
          ListTile(
            leading: Icon(
              Icons.supervisor_account,
              textDirection: TextDirection.ltr,
            ),
            title: Text('Vendeurs'),
          ),
          ListTile(
            title: Text('Mon compte'),
            leading: Icon(Icons.person),
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Se déconnecter'),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginForm()));
              await storage.deleteAll();
            },
          ),
        ],
      ),
    );
  }
}