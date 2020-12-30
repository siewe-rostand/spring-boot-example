import 'dart:convert';

import 'login-data.dart';


Map<String, dynamic> parseJwtPayLoad(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

Map<String, dynamic> parseJwtHeader(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[0]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

//String

void main() {
  String token = "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI0NTc0OTI1OC1iODAzLTQzMmMtODIzMS1jZDEzYTc2MGQ0OWQiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjA3NTE4NzI3LCJleHAiOjE2MDgzODI3MjcsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.Gphgim6U5yrILWmRZUXPGv2d3rmrsnmIOzV6oenOexkJVRGUfmeGoufgD3iJT58yx08y3U5-d0Tky3tXN2czjw";
  String view ="$server_ip/$token/stores/";
  print(parseJwtHeader(token));
  print(parseJwtPayLoad(token));
}