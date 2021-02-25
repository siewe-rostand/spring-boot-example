import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_form/model/vente-model.dart';

import '../login-data.dart';
/*
class AddVente extends StatefulWidget {
  @override
  _AddVenteState createState() => _AddVenteState();
}

class _AddVenteState extends State<AddVente> {

  Future<Vente> createAlbum(String name, String price, String qty, String id) async{
    final String token =
        "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI3MmJhN2Q0Zi1jYTVhLTQ1Y2UtYWQ0My1kZTM3NzRhNGJkMjMiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjEwMzU0NTM1LCJleHAiOjE2MTEyMTg1MzUsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.eYUflIj8uJsRuABqExQjmYtnh6F_Lv_FqDFLd-TuMjc_l1f08uUMMeRB30-boE5LKE3jSH1eWSC7xDRK2wiakw";
    final String url = "$server_ip/api/ventes/";
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        "Content-Type": "application/json",'authorization':'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'quantity': qty,
        'prixVente': price,
        'productId': id,
      }),
    );

    if (response.statusCode == 201) {
      return Vente.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create data.');
    }
  }

  Future _futureVente;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/
