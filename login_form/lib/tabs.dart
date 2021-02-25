import 'package:flutter/material.dart';
import 'package:login_form/save-product-services.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 24),
        MyTab(
          isSelected: false,
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ProductList2()));
          },
        ),
        MyTab(
          isSelected: true,
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ProductList2()));
          },
        ),
        MyTab(
          isSelected: false,
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ProductList2()));
          },
        ),
      ],
    );
  }
}

class MyTab extends StatelessWidget {
  //final String text;
  final Icon icon;
  final bool isSelected;
  final Function onPressed;

  const MyTab({
    Key key,
    @required this.isSelected,
    //this.text,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: icon,
            onPressed: onPressed,
            focusColor: isSelected ? Colors.black : Colors.grey,
            color: isSelected ? Colors.black : Colors.grey,
            iconSize: isSelected ? 28 : 14,
          ),
//          Text(
//            text,
//            style: TextStyle(
//              fontSize: isSelected ? 16 : 14,
//              color: isSelected ? Colors.black : Colors.grey,
//              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//            ),
//          ),
          Container(
            height: 6,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? Color(0xFFFF5A1D) : Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
