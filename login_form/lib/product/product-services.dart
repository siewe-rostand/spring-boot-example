import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:login_form/model/product-model.dart';
import 'package:login_form/product/save-product.dart';

import '../login-data.dart';

class ProductAPI{

  static Future<String> postProducts(String url, Map jsonMap) async {
    var requestBody = jsonEncode(
        {'product':jsonMap}
    );
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
   // request.headers.set('content-type', 'application/json');
    request.headers.set('content-type', 'multipart/form-data; boundary=dart-http-boundary-Ce9PBgi7GcBRgxgF06aY6lVx0LSOfnVH2tQufqTia_h0ds21l6r');
    request.headers.set('Accept', 'application/json');
    //request.headers.set("Content-Disposition", "form-data; name=product; filename=blob");
    request.headers.set ('Authorization', "Bearer " + token);
    request.add(utf8.encode(json.encode(requestBody)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(request.headers);
    print(reply);
    return reply;
  }

  static Future<List<Product>> fetchProducts(int storeId,int page,int size) async {
    final String url = "$server_ip/api/products-by-store/$storeId?page=0&size=$size&sortBy=name&direction=asc";

    Response res = await get(url,
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization':'Bearer $token'
      },
    );
    if(res.statusCode ==200){
      // print(res.body);
      // print(res.statusCode);
      var body = jsonDecode(res.body);
      var rest = body['content'] as List;
      List<Product> stores;
      // print(rest);

      stores = rest.map<Product>((json) => Product.fromJson(json)).toList();
      //print(stores);
      return stores;
    }else{
      print(res.body);
      //print(res.statusCode);
      throw Exception('fail to load data');
    }
  }


  /*static Future<String> postData(String url,Map body)async{
    var dio = Dio();
    print('*************');
    dio.options.headers ={
      'Authorization': "Bearer " + token
    };
    var requestBody ={'product':utf8.encode(json.encode(body))};

      FormData formData = new FormData.fromMap(requestBody);
      Response response = await dio.post(url, data: formData);
      print(dio.options.headers);
      return response.data;

  }*/

  static Future<Product> updateProduct(Map jsonMap) async {
    final Response response = await put(
      '$server_ip/api/products',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization':'Bearer $token'

      },
      body:jsonEncode(jsonMap),
    );

    if (response.statusCode == 201) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return Product.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('+++++++++++');
      print(response.statusCode);
      throw Exception('Failed to update data.');
    }
  }

  static Future<Product> deleteProduct(int productId) async {
    String url = "$server_ip/api/products/$productId";
    Response response = await delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer " + token,
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON. After deleting,
      // you'll get an empty JSON `{}` response.
      // Don't return `null`, otherwise `snapshot.hasData`
      // will always return false on `FutureBuilder`.
      return Product.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      print(response.body);
      print(response.statusCode);
      throw Exception('Failed to delete data.');
    }
  }

  static Future<String> networkImageToBase64(int productId) async {
    String imageUrl = "$server_ip/api/product-image-thumb/$productId";
    Response response = await get(imageUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'image/jpeg',
        "accept" : 'image/jpeg'
      },
    );
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }


  static postProduct(String url,Map jsonMap)async{
  var uri = Uri.parse(url);
  var requestBody = jsonEncode(
      {'product':jsonMap}
  );
  Map<String, String> headers = {
    "Accept": "application/json",
    "Authorization": "Bearer " + token,
  };
  var request = MultipartRequest('POST', uri)
  ..headers.addAll(headers) //if u have headers, basic auth, token bearer... Else remove line
  ..fields['product']= jsonEncode(jsonMap);
//  ..files.add(await MultipartFile.fromPath(
//      'package', 'build/package.tar.gz',
//      contentType: MediaType('application', 'x-tar')));
  var response = await request.send();
  print(request.headers);
  final respStr = await response.stream.bytesToString();
  print(respStr);
  return jsonDecode(respStr);
    //Response response = await Response.fromStream(await request.send());
//    print("Result: ${response.statusCode}");
//    print("Result: ${response.body}");
//    return response.body;
  }

}