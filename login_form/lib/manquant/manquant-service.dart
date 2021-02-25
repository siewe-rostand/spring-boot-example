
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:login_form/model/manquant-model.dart';
import 'package:login_form/product/save-product.dart';

import '../login-data.dart';

class ManquantAPI{

  static Future<List<Manquants>> fetchManquants(int storeId,String createdDateFrom,String createdDateTo) async {
    final String url = "$server_ip/api/manquants-by-store/$storeId/?createdDateFrom=$createdDateFrom&createdDateTo=$createdDateTo";

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
      List<Manquants> stores;
      // print(rest);

      stores = rest.map<Manquants>((json) => Manquants.fromJson(json)).toList();
      //print(stores);
      return stores;
    }else{
      print(res.body);
      //print(res.statusCode);
      throw Exception('fail to load data');
    }
  }

  static Future<String> manquantRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.contentType =ContentType("application", "json", charset: "utf-8");
    request.headers.set ('Authorization', "Bearer " + token);
    request.headers.set('Content-Length', utf8.encode(json.encode(jsonMap)).length.toString());
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(reply);
    //print(request.headers);
   // print(response.headers);
    return reply;
  }

  static Future createUser(String url, Map body) async {
    Map<String, dynamic> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer " + token
    };
    Map requestBody = {
      'product':jsonEncode(body)
    };

    var postUri = Uri.parse(url);
    var request = new MultipartRequest("POST", postUri);
    request.fields['product']= jsonEncode(body);
    //request.files.add(new http.MultipartFile.fromBytes('file', await File.fromUri(postUri).readAsBytes(), contentType: new MediaType('image', 'jpeg')));
    var res =await request.send();
    print(request.fields);
    if (res.statusCode == 200)
      print("Uploaded!");
    else
    {
      print(res.request);
      print("Error occur");}
//    res.then((response) {
//      if (response.statusCode == 200)
//        print("Uploaded!");
//      else
//        {
//          print(response.statusCode);
//          print("Error occur");}
//    });
  }

  static Future<Manquants> createAlbum(String url, Map jsonMap) async {
    final Response response = await post(
      url,
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token
      },
      body: jsonEncode(jsonMap),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Manquants.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.body);
      print(response.headers);
      throw Exception('Failed to load data');
    }
  }

}