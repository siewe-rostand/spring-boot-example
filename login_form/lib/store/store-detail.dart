import 'dart:convert';
import 'package:http/http.dart';
import 'package:login_form/product/save-product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login-data.dart';
import '../model/store-model.dart';

class API{
  //method to get information on the server
  static Future<List<Store>> fetchStore() async {
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


  /*static Future createProduct(Product products) async {


    String url = "$server_ip/api/products-with-image/";
    Map<String, String> heads = {
      'content-disposition: form-data; name=product; filename= blob'
          "Authorization": "Bearer " + token,
      "Content-type": 'application/json',
      "accept" : "application/json"
    };
    var requestBody = jsonEncode(
        {'product':products.toJson()}
    );
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.set ('Authorization', "Bearer " + token);
    //request.headers.add("body", requestBody);

    // request.add(utf8.encode(json.encode(requestBody)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(response);
    print(reply);
    return reply;}*/


  static saveValue(String key, value)async{
    final pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static String encode(List<Store> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => Store.toJson(music))
        .toList(),
  );

  static List<Store> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Store>((item) => Store.fromJson(item))
          .toList();
}



