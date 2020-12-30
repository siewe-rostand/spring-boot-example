import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_form/model/product-model.dart';

import 'login-data.dart';

class ProductView{
  List<Product> productList ;
  //method to get information on the server
  Future<List<Product>> viewProduct(int storeId) async {
   // print(storeId);
    final String token = "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMGU0MWFlZS0wNjBlLTQxYzctODE0MS03ZWQxYWY0Y2I4MzEiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjA4NTUwODg1LCJleHAiOjE2MDk0MTQ4ODUsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.dLEEKO5NiE3HmRNi65ejXeG_3s-D5gJQDa9ykVA5WFXCFpO3HB07GlJrdp04snrN3NtK2sQ4NksrD-HPaOq1bA";
    final String url = "$server_ip/api/products-enabled-by-store/$storeId";
    final res = await http.get(url,
      headers: {"Content-Type": "application/json",'authorization':'Bearer $token'},
      // body: body,
    );
   // print(res);
    if(res.statusCode ==200){
     // print(res.body);
      //print(res.statusCode);
      /*var body = jsonDecode(res.body);
      var rest = body['content'] as List;
      List products;
      print(rest);

      products = rest.map((json) => Product.fromJson(json)).toList();
      print(products);

      return products;*/
      List<dynamic> values=new List<dynamic>();
      values = json.decode(res.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            productList .add(Product.fromJson(map));
            print('Id-------${map['id']}');
          }
        }
      }
      return productList;
    }else{
      print(res.body);
      print(res.statusCode);
      throw Exception('fail to load data');
    }
  }

}