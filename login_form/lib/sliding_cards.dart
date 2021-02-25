import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login_form/login-data.dart';
import 'package:login_form/model/product-model.dart';
import 'package:login_form/product/product-edit.dart';
import 'package:login_form/product/product-services.dart';
import 'dart:math' as math;

import 'package:login_form/product/save-product.dart';
import 'package:login_form/tabs.dart';
class SlidingProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 8),
//                Header(),
                SizedBox(height: 40),
                Tabs(),
                SizedBox(height: 8),
                SlidingCardsView(),
              ],
            ),
          ),//use this or ScrollableExhibitionSheet
        ],
      ),
    );
  }
}


class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;
  int present = 0;
  int perPage = 25;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: FutureBuilder<List<Product>>(
        future: ProductAPI.fetchProducts(2, present, perPage),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){
          if(snapshot.hasData){
            productList =snapshot.data;
            return PageView.builder(
                itemCount: productList.length,
              itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: () async {
                      var products = Product(
                          id: productList[index].id,
                          name: productList[index].name,
                          price: productList[index].price,
                          storeId: 2,
                      );
                      //push the values of product's name and price to another page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProduct(
                                product: products,
                              )));
                    },
                    child: SlidingCard(
                      name: productList[index].name,
                      date: productList[index].createdDate,
                      offset: pageOffset,
                      price: productList[index].price.ceil(),
                      image: Image.network(
                        "$server_ip/api/product-image-thumb/${productList[index].id}",
                        headers: {
                          'Authorization': 'Bearer $token',
                          'Content-Type': 'image/jpeg',
                          "accept" : 'image/jpeg'
                        },
                        height: MediaQuery.of(context).size.height * 0.3,
                        alignment: Alignment(-pageOffset.abs(), 0),
                        fit: BoxFit.none,
                      ),
                    ),
                  );
              },
            );
          }else{
            List<Product> stores = snapshot.data;
            print(stores);
            return Center(child: Container(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
List<Product> productList;

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final int price;
  final double offset;
  final Widget image;

  const SlidingCard({
    Key key,
    @required this.name,
    @required this.date,
    @required this.offset,
    @required this.price,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: image,
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
                price: price,
                offset: gauss,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final int price;
  final double offset;

  const CardContent(
      {Key key,
      @required this.name,
      @required this.date,
      @required this.price,
      @required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(
              date,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: RaisedButton(
                  color: Color(0xFF162A49),
                  child: Transform.translate(
                    offset: Offset(24 * offset, 0),
                    child: Text('Reserve'),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onPressed: () {},
                ),
              ),
              Spacer(),
              Transform.translate(
                offset: Offset(32 * offset, 0),
                child: Text(
                  '$price \F',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
