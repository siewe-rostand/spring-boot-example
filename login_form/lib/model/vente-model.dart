import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;

/*class Vente {
  double prixTotal;
  int storeId;
  List<OrderedProducts> orderedProducts;

  Vente({this.prixTotal, this.storeId,this.orderedProducts});

  factory Vente.fromJson(Map<String, dynamic> json) {
    return Vente(
        prixTotal: json['prixTotal'],
        storeId: json['storeId'],
      orderedProducts: parseOrderedProducts(json['orderedProducts'])
    );
  }

  /*Map<String, dynamic> toJson() => {
        'prixTotal': prixTotal,
        'orderedProducts': orderedProducts,
        'storeId': storeId
      };*/
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prixTotal'] = this.prixTotal;
    if (this.orderedProducts != null) {
      data['orderedProducts'] =
          this.orderedProducts.map((v) => v.toJson()).toList();
    }
    data['storeId'] = this.storeId;
    return data;
  }

  static List<OrderedProducts> parseOrderedProducts(imagesJson) {
    var list = imagesJson['orderedProducts'] as List;
    List<OrderedProducts> orderedProductsList =
    list.map((data) => OrderedProducts.fromJson(data)).toList();
    return orderedProductsList;
  }

}*/

class PickUp {
  Ventes ventes;

  PickUp({
    this.ventes,
  });

  factory PickUp.fromJson(Map<String, dynamic> json) => new PickUp(
        ventes: Ventes.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "results": ventes.toJson(),
      };
}

class Ventes {
  int id;
  String createdDate;
  int storeId;
  double prixTotal;
  int userId;
  String userName;
  List orderedProducts;
  double totalVentes;

  Ventes(
      {this.prixTotal,
      this.orderedProducts,
      this.storeId,
      this.id,
      this.createdDate,
      this.userId,
      this.userName,
        this.totalVentes
      });

  factory Ventes.fromJson(Map<String, dynamic> json) {
    /*id= json['id'];
    createdDate= json['createdDate'];
    storeId= json["storeId"];
    prixTotal= json["prixTotal"];
    userId= json['userId'];
    userName= json['userName'];
    if (json['orderedProducts'] != null) {
      List<OrderedProducts> orderedProducts;
      json['orderedProducts'].forEach((v) {
        orderedProducts.add( OrderedProducts.fromJson(v));
      });
    }*/
    if (json['orderedProducts'] != null) {
      var tagObjsJson = json['orderedProducts'] as List;
      List<OrderedProducts> _tags = List<OrderedProducts>.from(
              json["orderedProducts"].map((x) => OrderedProducts.fromJson(x)))
          .toList();

      return Ventes(
          id: json['id'],
          createdDate: json['createdDate'],
          storeId: json["storeId"],
          prixTotal: json["prixTotal"],
          userId: json['userId'],
          totalVentes: json['totalVentes'],
          userName: json['userName'],
          orderedProducts: _tags);
    } else {
      return Ventes(
        id: json['id'],
        createdDate: json['createdDate'],
        storeId: json["storeId"],
        prixTotal: json["prixTotal"],
        totalVentes: json["totalVentes"],
        userId: json['userId'],
        userName: json['userName'],
      );
    }
    return Ventes(
        id: json['id'],
        createdDate: json['createdDate'],
        storeId: json["storeId"],
        prixTotal: json["prixTotal"],
        userId: json['userId'],
        userName: json['userName'],
        orderedProducts: List<OrderedProducts>.from(
                json["orderedProducts"].map((x) => OrderedProducts.fromJson(x)))
            .toList());
  }
  static Map<String, dynamic> toMap(Ventes music) => {
    'id': music.id,
    'createdDate': music.createdDate,
    'userName': music.userName,
    'storeId': music.storeId,
    'userId': music.userId,
    'prixTotal': music.prixTotal,
    'totalVentes': music.totalVentes,
    'orderedProducts': music.orderedProducts,
  };

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "userId": userId,
        "userName": userName,
        "prixTotal": prixTotal,
        "totalVentes": totalVentes,
        "orderedProducts": orderedProducts,
        "storeId": storeId,
      };
}

class OrderedProducts {
  int productId;
  String name;
  String productName;
  String date;
  double quantity;
  double prixVente;
  double totalVentes;
  double benefice;
  charts.Color color;

  OrderedProducts({this.productId, this.name,this.productName, this.quantity, this.prixVente,this.totalVentes,this.benefice,this.date,this.color});

  factory OrderedProducts.fromJson(Map<String, dynamic> json) {
    return OrderedProducts(
        productId: json['productId'],
        name: json['name'],
      productName: json['productName'],
      date: json['date'],
        quantity: json['quantity'],
        prixVente: json['prixVente'],
      totalVentes: json['totalVentes'],
      benefice: json['benefice'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['productName'] = this.productName;
    data['date'] = this.date;
    data['quantity'] = this.quantity;
    data['prixVente'] = this.prixVente;
    data['totalVentes'] = this.totalVentes;
    data['benefice'] = this.benefice;
    return data;
  }
  /*Map<String, dynamic> toJson() => {
    "productId": productId,
    "name": name,
    "quantity": quantity,
    "prixVente": prixVente,
  };*/

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['productId'] = productId;
    m['name'] = name;
    m['productName'] = productName;
    m['date'] = date;
    m['quantity'] = quantity;
    m['prixVente'] = prixVente;
    m['totalVentes'] = totalVentes;
    m['benefice'] = benefice;

    return m;
  }
  static Map<String, dynamic> toMap(OrderedProducts music) => {
    'productId': music.productId,
    'name': music.name,
    'productName': music.productName,
    'date': music.date,
    'quantity': music.quantity,
    'prixVente': music.prixVente,
    'totalVentes': music.totalVentes,
    'benefice': music.benefice,
  };
  static String encode(List<OrderedProducts> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => OrderedProducts.toMap(music))
        .toList(),
  );

  static List<OrderedProducts> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<OrderedProducts>((item) => OrderedProducts.fromJson(item))
          .toList();
}
class TodoList {
  List<OrderedProducts> items;

  TodoList() {
    items = new List();
  }

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
/*
List<OrderedProducts> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<OrderedProducts>.from(
      jsonData.map((x) => OrderedProducts.fromJson(x)));
}

String allPostsToJson(List<Vente> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

String postToJson(Vente data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}*/
