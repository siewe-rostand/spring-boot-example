import 'dart:convert';
import 'package:http/http.dart';
import 'login-data.dart';
import 'model/store-model.dart';

class API{
  //method to get information on the server
  Future<List<Store>> fetchStore() async {
    final String token = "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJkOTNjZGUzMS02NmM4LTRmYzUtYWRhOS03YmE2NTI3ZDBhNjUiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjA4NjMyNzQ5LCJleHAiOjE2MDk0OTY3NDksImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.ozUNSlQ9NRpFdE0egbQbO6DJPN11dCftAokkkg5cI73LAZS2UI9Ry_guyZxlh2y6JNqsLNUTu_f2g1O-oDdk7A";
    final String url = "$server_ip/api/stores/";
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
      List<Store> stores;
     // print(rest);

      stores = rest.map<Store>((json) => Store.fromJson(json)).toList();
      //print(stores);
      return stores;
    }else{
      print(res.body);
      //print(res.statusCode);
      throw Exception('fail to load data');
    }
  }
 /* Future getStoreId(int storeId) async{
    final String token = "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI0NTc0OTI1OC1iODAzLTQzMmMtODIzMS1jZDEzYTc2MGQ0OWQiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjA3NTE4NzI3LCJleHAiOjE2MDgzODI3MjcsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.Gphgim6U5yrILWmRZUXPGv2d3rmrsnmIOzV6oenOexkJVRGUfmeGoufgD3iJT58yx08y3U5-d0Tky3tXN2czjw";
    final String url = "$server_ip/api/stores/$storeId";
    Response res = await get(url,
      headers: {"Content-Type": "application/json",'authorization':'Bearer $token'},
      // body: body,
    );
    return res;
  }*/

}



