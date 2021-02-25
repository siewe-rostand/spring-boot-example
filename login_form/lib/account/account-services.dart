import 'dart:convert';

import 'package:http/http.dart';
import 'package:login_form/model/account-model.dart';
import 'package:login_form/product/save-product.dart';

import '../login-data.dart';

class AccountAPI{

  static Future<Account> accountDetail() async {
    String token =
        "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI3MmJhN2Q0Zi1jYTVhLTQ1Y2UtYWQ0My1kZTM3NzRhNGJkMjMiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjEwMzU0NTM1LCJleHAiOjE2MTEyMTg1MzUsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.eYUflIj8uJsRuABqExQjmYtnh6F_Lv_FqDFLd-TuMjc_l1f08uUMMeRB30-boE5LKE3jSH1eWSC7xDRK2wiakw";
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
  static Future<List<Account>> fetchAccountDetail() async {
    final String url = "$server_ip/api/account";

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
      List<Account> stores;
      // print(rest);

      stores = rest.map<Account>((json) => Account.fromJson(json)).toList();
      //print(stores);
      return stores;
    }else{
      print(res.body);
      //print(res.statusCode);
      throw Exception('fail to load data');
    }
  }
}