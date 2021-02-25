
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  String date;
  String productName;
  double totalVente;
  double benefice;
  charts.Color color;

  BarChartModel({this.totalVente, this.benefice,this.date,this.productName});

  factory BarChartModel.fromJson(Map<String, dynamic> json) {
    return BarChartModel(
        totalVente: json['totalVentes'],
        date: json['date'],
        productName: json['productName'],
        benefice: json['benefice']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalVentes'] = this.totalVente;
    data['date'] = this.date;
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

    m['totalVentes'] = totalVente;
    m['benefice'] = benefice;

    return m;
  }
  static Map<String, dynamic> toMap(BarChartModel music) => {
    'totalVentes': music.totalVente,
    'benefice': music.benefice,
    'date': music.date,
  };
  static String encode(List<BarChartModel> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => BarChartModel.toMap(music))
        .toList(),
  );

  static List<BarChartModel> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<BarChartModel>((item) => BarChartModel.fromJson(item))
          .toList();
}