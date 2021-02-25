import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:login_form/model/vente-model.dart';
import 'package:login_form/product/save-product.dart';

import '../login-data.dart';


PickUp pickUpFromJson(String str) => PickUp.fromJson(json.decode(str));

String pickUpToJson(PickUp data) => json.encode(data.toJson());
class VenteAPI{
 static Future<List<PickUp>> getPickupData( int storeId,String createdDateFrom,String createdDateTo,) async {
   final String url = "$server_ip/api/ventes-by-store/$storeId/?createdDateFrom=$createdDateFrom&createdDateTo=$createdDateTo";
    try {
      Response response = await get(url,
        headers: <String, String>{
          "Content-Type": "application/json",'authorization':'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        var body=json.decode(response.body);
        var rest = body['content'] as List;
        print(response.body);
        print(response.statusCode);
        List<PickUp> stores;
        // print(rest);

        stores = rest.map<PickUp>((json) => PickUp.fromJson(json)).toList();
        //print(stores);
        return stores;
      } else {
        print(response.body);
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }
 static Future<List<OrderedProducts>> getVenteByProduct( int storeId,String createdDateFrom,String createdDateTo,) async {
   final String url = "$server_ip/api/ventes-by-product/$storeId/?createdDateFrom=$createdDateFrom&createdDateTo=$createdDateTo";
    try {
      Response response = await get(url,
        headers: <String, String>{
          "Content-Type": "application/json",'authorization':'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        var body=json.decode(response.body);
        var rest = body as List;
        print(response.body);
        print(response.statusCode);
        List<OrderedProducts> stores;
        // print(rest);

        stores = rest.map<OrderedProducts>((json) => OrderedProducts.fromJson(json)).toList();
        //print(stores);
        return stores;
      } else {
        print(response.body);
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

 static Future<List<OrderedProducts>> getVenteByDay( int storeId,String createdDateFrom,String createdDateTo,) async {
   final String url = "$server_ip/api/ventes-by-day/$storeId/?createdDateFrom=$createdDateFrom&createdDateTo=$createdDateTo";
    try {
      Response response = await get(url,
        headers: <String, String>{
          "Content-Type": "application/json",'authorization':'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        var body=json.decode(response.body);
        var rest = body as List;
        print(response.body);
        print(response.statusCode);
        List<OrderedProducts> stores;
        // print(rest);

        stores = rest.map<OrderedProducts>((json) => OrderedProducts.fromJson(json)).toList();
        //print(stores);
        return stores;
      } else {
        print(response.body);
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
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
   print(response.statusCode);
   return reply;


 }

 static Future<Ventes> deleteVente(int venteId) async {
   String url = "$server_ip/api/ventes/$venteId";
   Response response = await delete(
     url,
     headers: <String, String>{
       'Content-Type': 'application/json',
       "Authorization": "Bearer " + token
     },
   );

   if (response.statusCode == 200) {
     // If the server did return a 200 OK response,
     // then parse the JSON. After deleting,
     // you'll get an empty JSON `{}` response.
     // Don't return `null`, otherwise `snapshot.hasData`
     // will always return false on `FutureBuilder`.
     return Ventes.fromJson(jsonDecode(response.body));
   } else {
     // If the server did not return a "200 OK response",
     // then throw an exception.
     print(response.body);
     print(response.statusCode);
     throw Exception('Failed to delete data.');
   }
 }



}