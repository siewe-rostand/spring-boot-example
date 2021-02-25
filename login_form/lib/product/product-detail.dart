import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:login_form/model/account-model.dart';
import 'package:login_form/product/save-product.dart';

import '../login-data.dart';
import '../model/product-model.dart';

class ProductView{
  //method to get information on the server
  static Future<Product> viewProduct(int storeId,context) async {
   // print(storeId);
    final String token =
    "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI3MmJhN2Q0Zi1jYTVhLTQ1Y2UtYWQ0My1kZTM3NzRhNGJkMjMiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjEwMzU0NTM1LCJleHAiOjE2MTEyMTg1MzUsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.eYUflIj8uJsRuABqExQjmYtnh6F_Lv_FqDFLd-TuMjc_l1f08uUMMeRB30-boE5LKE3jSH1eWSC7xDRK2wiakw";
    final String url = "$server_ip/api/products-enabled-by-store/$storeId";
    final res = await http.get(url,
      headers: {HttpHeaders.contentTypeHeader: "application/json",'authorization':'Bearer $token'},
      // body: body,
    );
   // print(res);
    if(res.statusCode ==200){
     // print(res.body);
      //print(res.statusCode);
      var body = jsonDecode(res.body);
      var rest = body['content'] ;
      Product result = Product.fromJson(rest);

      return result;
    }else{
      print(res.body);
      print(res.statusCode);
      throw Exception('fail to load data');
    }
  }

  static Future<Account> fetchTeams(context,int storeId) async {
    String token =
        "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI1NzhmMTVmZi0xN2MzLTQ3MTctOGE2Mi0zOWUxZjFkOTM2NzQiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjExMjIwNjc4LCJleHAiOjE2MTIwODQ2NzgsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.Hfhm2vCfPGGyzp2P_tJNk8Gozlss2fT7sJyXEGyT5zf9T8hupIG2SYRbYnfdotk_3ikwJdEL41XUGMoK_9sdhw";
    String url = "$server_ip/api/products-enabled-by-store/$storeId";

    try {
      Response result = await get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'authorization': 'Bearer $token'
        },
      );
      if(result.statusCode == 200){var body = json.decode(result.body);
      var rest = Account.fromJson(body);
      //print(rest);
      //print(json.decode(result.body)['content']);
      return rest;}
    } catch (e) {
      print(e);
    }
  }

  static Future<Account> accountDetail() async {
    String url = "$server_ip/api/account";


      Response result = await get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'authorization': 'Bearer $token'
        },
      );
      var body = json.decode(result.body);
      //print(rest);
      //print(json.decode(result.body)['content']);

      if(result.statusCode == 200){
        //print(body);
        return Account.fromJson(body);
      }else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }

  }


}