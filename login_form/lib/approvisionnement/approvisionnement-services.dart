
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:login_form/model/approvisionnement-model.dart';
import 'package:login_form/model/manquant-model.dart';
import 'package:login_form/product/save-product.dart';

import '../login-data.dart';

class ApprovisionnementAPI{

  static Future<List<Approvisionnement>> fetchApprovisionnements(int storeId,String createdDateFrom,String createdDateTo) async {
    final String url = "$server_ip/api/approvisionnements-by-store/$storeId/?createdDateFrom=$createdDateFrom&createdDateTo=$createdDateTo";

    Response res = await get(url,
      headers: <String, String>{
        "Content-Type": "application/json",'authorization':'Bearer $token'
      },
    );
    if(res.statusCode ==200){
      // print(res.body);
      // print(res.statusCode);
      var body = jsonDecode(res.body);
      var rest = body['content'] as List;
      List<Approvisionnement> stores;
      // print(rest);

      stores = rest.map<Approvisionnement>((json) => Approvisionnement.fromJson(json)).toList();
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