import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:login_form/model/account-model.dart';
import 'package:login_form/model/vendeur-model.dart';
import 'package:login_form/product/save-product.dart';

import '../login-data.dart';

class SellerAPI{
  static Future<List<Seller>> fetchSellers(int storeId) async {
    final String url = "$server_ip/api/sellers-by-store/$storeId";
    Response res = await get(url,
      headers: {"Content-Type": "application/json",'authorization':'Bearer $token'},
      // body: body,
    );
    Future.delayed(Duration(seconds: 2));
    //print(res);
    if(res.statusCode ==200){
      // print(res.body);
      // print(res.statusCode);
      var body = jsonDecode(res.body);
      var rest = body['content'] as List;
      List<Seller> stores;
      // print(rest);

      stores = rest.map<Seller>((json) => Seller.fromJson(json)).toList();
      //print(stores);
      return stores;
    }else{
      print(res.body);
      //print(res.statusCode);
      throw Exception('fail to load data');
    }
  }

  static Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.set ('Authorization', "Bearer " + token);
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(reply);
    return reply;
  }

}