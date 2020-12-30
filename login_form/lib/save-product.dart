import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:login_form/model/product-model.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart' as dio;

import 'login-data.dart';

String token = "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJmYTU4Y2FiMS1kOTdjLTQ1NjktOTI2Zi02MDY0NzMyYzBiZGEiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjA4ODA5NDUzLCJleHAiOjE2MDk2NzM0NTMsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.SfbWOnl8974zDogzWkH2a_XLcFkoG_X8khZmLqqVva2wOQU_08RgV-cP6g5yA_2yrrLRaotjUmehEi99TiCMQg";

class SaveProduct {
  /*static uploadFileFromDio(Product userProfile, File photoFile) async {
    var dio = new Dio();
    dio.options.baseUrl = url;
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 5000;
    dio.options.headers = <Header Json>;
    FormData formData = new FormData();
    formData.fields.add(MapEntry('product', userProfile.name));
    formData.add("name", userProfile.name);
    formData.add("email", userProfile.email);

    if (photoFile != null &&
        photoFile.path != null &&
        photoFile.path.isNotEmpty) {
      // Create a FormData
      String fileName = basename(photoFile.path);
      print("File Name : $fileName");
      print("File Size : ${photoFile.lengthSync()}");
      formData.add("user_picture", new UploadFileInfo(photoFile, fileName));
    }
    var response = await dio.post("user/manage_profile",
        data: formData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.PLAIN // or ResponseType.JSON
            ));
    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
  }*/

  /*static Future<Product> createProduct(File imageFile,Product product) async {
    final String token = "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI0NTc0OTI1OC1iODAzLTQzMmMtODIzMS1jZDEzYTc2MGQ0OWQiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjA3NTE4NzI3LCJleHAiOjE2MDgzODI3MjcsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.Gphgim6U5yrILWmRZUXPGv2d3rmrsnmIOzV6oenOexkJVRGUfmeGoufgD3iJT58yx08y3U5-d0Tky3tXN2czjw";

    final String url = "$server_ip/api/products-with-image";

        var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length(); //imageFile is your image file
    Map<String, String> headers = {
    "Accept": "application/json",
    "Authorization": "Bearer " + token
    }; // ignore this headers if there is no authentication

    // string to uri
    var uri = Uri.parse(url);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFileSign = new http.MultipartFile('file', stream, length,
    filename: basename(imageFile.path));
    print(multipartFileSign);

    // add file to multipart
    request.files.add(multipartFileSign);
    request.fields['product'] = json.encode(product.toJson());
    request.files.add(
      http.MultipartFile.fromBytes(
        'name',
        utf8.encode(json.encode(product.toJson())),
        contentType: MediaType(
          'application',
          'json',
          {'charset': 'utf-8'},
        ),
      ),
    );

    //add headers
    request.headers.addAll(headers);

    //adding params
    request.fields['loginId'] = '12';
    request.fields['firstName'] = 'abc';
    // request.fields['lastName'] = 'efg';

    // send
    var response = await request.send();

    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
    print(value);

    });
  }*/

   /*static Future<Response> createProduct( Product product) async {
    final String token = "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMGU0MWFlZS0wNjBlLTQxYzctODE0MS03ZWQxYWY0Y2I4MzEiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjA4NTUwODg1LCJleHAiOjE2MDk0MTQ4ODUsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.dLEEKO5NiE3HmRNi65ejXeG_3s-D5gJQDa9ykVA5WFXCFpO3HB07GlJrdp04snrN3NtK2sQ4NksrD-HPaOq1bA";

    final String url = "$server_ip/api/products-with-image/";

      ///[1] CREATING INSTANCE

        var dioRequest = dio.Dio();

        dioRequest.options.baseUrl = url;

//        dioRequest.options.headers = {
//          'Authorization': 'Bearer $token',
//        };
        dioRequest.options = BaseOptions(
            connectTimeout: 5000,
            receiveTimeout: 3000,
            );
        Map<String, String> heads = {
          'Authorization': "Bearer " + token,
     };
     dioRequest.interceptors.add(InterceptorsWrapper(
         onRequest: (RequestOptions options) async {
           options.headers
             ..addAll(
             {
               'Content-Type': 'application/json',
               'Authorization': "Bearer " + token,
             });

           print(options.headers);
           print(options.data);
           print(options.contentType);
           print(options.responseType);
           return options;
         },
       onResponse: (Response response) {
         print("Dio Success Response");
         print(response.data);
         print(response.extra);
         return response;
       },
       onError: (DioError e) async {
         print("Dio Error Response");
         print(e.response);
         print(e.message);
         print(e.type);
         if (e.response?.statusCode == 403 ||
             e.response?.statusCode == 401) {
           return e;
         }

       },
     ));

        var bodyValue = product.toJson();

        var bodydata = json.encode(bodyValue);
        Map<String, dynamic> requestBody = {
          'product':bodydata
        };
        //[3] ADDING EXTRA INFO
        var formData =
        new dio.FormData.fromMap(
          requestBody
        );
//        print(requestBody);
//        print(formData);

       /* //[4] ADD IMAGE TO UPLOAD
        var file = await dio.MultipartFile.fromFile(imageFile.path,
            filename: basename(imageFile.path),
            contentType: MediaType("file", basename(imageFile.path)));

        formData.files.add(MapEntry('file', file));*/
        //print(formData);

        //[5] SEND TO SERVER
        var response = await dioRequest.post(
          url,
          data: formData,
          //options: dio.Options(contentType: Headers.formUrlEncodedContentType, headers: heads)
        );
        print(response);
     final result = json.decode(response.toString());
     print(result);
        return response;
        //print(response.statusCode);
        //print(response.statusMessage);
        //

      //print(result);

  }*/

 /*static Future<http.Response> createProduct(Product product) async {
    final String token = "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMGU0MWFlZS0wNjBlLTQxYzctODE0MS03ZWQxYWY0Y2I4MzEiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjA4NTUwODg1LCJleHAiOjE2MDk0MTQ4ODUsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.dLEEKO5NiE3HmRNi65ejXeG_3s-D5gJQDa9ykVA5WFXCFpO3HB07GlJrdp04snrN3NtK2sQ4NksrD-HPaOq1bA";
    final String url = "$server_ip/api/products-with-image/";

    Map data = {
      'apikey': '12345678901234567890'
    };
    //encode Map to JSON
    /*var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json",
          "Authorization": "Bearer " + token,
          "Accept": "application/json, text/plain",
        },
        body: body,
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;*/
    var client = new http.Client();
    var request = new http.Request('POST', Uri.parse(url));
    var body = {'product':product.toJson()};
  request.headers[HttpHeaders.CONTENT_TYPE] = 'application/json; charset=utf-8';
   request.headers[HttpHeaders.AUTHORIZATION] = "Bearer " + token;
   request.body = jsonEncode(body);
   var future = client.send(request).then((response)
   => response.stream.bytesToString().then((value)
   => print(value.toString()))).catchError((error) => print(error.toString()));
   print(future);

  }*/
 /* static Future<void> createUser(String url, Product body) async {
    final String token = "eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJiMGU0MWFlZS0wNjBlLTQxYzctODE0MS03ZWQxYWY0Y2I4MzEiLCJzdWIiOiJ5YXlhIiwiaWF0IjoxNjA4NTUwODg1LCJleHAiOjE2MDk0MTQ4ODUsImlkIjozLCJsb2dpbiI6InlheWEiLCJsYXN0TmFtZSI6IllheWEiLCJmaXJzdE5hbWUiOiJUb3RvIiwidGVsZXBob25lIjoiNjk3Mzg4NDQ3Iiwic3RvcmVJZCI6MiwibmJTdG9yZXMiOjIsIm93bmVyUGxheWVySWQiOiI2NjZlZDEwMi1hZTA4LTQ4NTEtOGViYS04NmI1MmQ5MjExNmYiLCJyb2xlcyI6WyJPV05FUiJdfQ.dLEEKO5NiE3HmRNi65ejXeG_3s-D5gJQDa9ykVA5WFXCFpO3HB07GlJrdp04snrN3NtK2sQ4NksrD-HPaOq1bA";

    Map<String, dynamic> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + token
    };
    Map<String, dynamic> requestBody = <String,dynamic>{
      'product':body.toJson()
    };

    var postUri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", postUri);
    // ignore: unnecessary_statements
    request.fields[requestBody];
    request.files.add(new http.MultipartFile.fromBytes('file', await File.fromUri(postUri).readAsBytes(), contentType: new MediaType('image', 'jpeg')));

    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  }*/
  static Future createProduct(Product products) async {


    String url = "$server_ip/api/products-with-image/";
  Map<String, String> heads = {
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
    request.headers.add("body", requestBody);
   // request.add(utf8.encode(json.encode(requestBody)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(response);
    print(reply);
    return reply;
  /*var bodyValue = products.toJson();

  var bodydata = json.encode(bodyValue);

    /*var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri)
    ..headers.addAll(heads) //if u have headers, basic auth, token bearer... Else remove line
    ..fields['product'] = jsonEncode(products.toJson());
    print(requestBody);
  var response = await request.send();
  final respStr = await response.stream.bytesToString();
  print(respStr);
  return jsonDecode(respStr);*/


// important
  print(bodydata);

  final response = await http.post(url, headers: heads, body: requestBody);

  //print(json.decode(response.body));
  if (response.statusCode == 200) {
    // TODO
  } else {
    //print(json.decode(response.body));
    print(response.body);
    // If that response was not OK, throw an error.
    throw Exception('Failed to load ConversationRepo');
  }*/
  }
}
