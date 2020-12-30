import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_form/auth-provider.dart';
import './translation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'home-page.dart';

//jwt constants
final storage = FlutterSecureStorage();
const server_ip = 'https://stock.jovendo.com';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? allTranslations.text('email_label_text') : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? allTranslations.text('password_label_text') : null;
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

enum FormType { login, register }

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  final formKey = new GlobalKey<FormState>();
  String password;
  String email;
  FormType _formType = FormType.login;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  /*void validateAndSubmit() async {
    if (validateAndSave()) {
      var auth = AuthProvider.of(context).auth;
      try {
        if (_formType == FormType.login) {
          String userId =
              await auth.signInWithEmailAndPassword(email, password);
          print("sign in id : $userId");
        } else {
          String userId =
              await auth.createUserWithEmailAndPassword(email, password);
          print('RegistrationId : $userId');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }*/


  //jwt authentication classes
  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );


  Future<int> attemptSignUp(String username, String password) async {
    var body = json.encode({"username": username, "password": password});
    var res = await http.post('$server_ip/register',
        headers: {"Content-Type": "application/json"},
        body: body);
    print(res);
    print(username);
    print(res.body);
    return res.statusCode;
  }

  //method to switch to sign up page
  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String language = allTranslations.currentLanguage;
    final String buttonText = language == 'fr' ? 'Français' : 'English';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          allTranslations.text('login_title'),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          RaisedButton(
            onPressed: () {
              setState(() {
                allTranslations.setNewLanguage(language == 'fr' ? 'en' : 'fr');
              });
            },
            child: Text(buttonText),
            color: Colors.teal,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 25),
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView(
                children: header() + buildInput() + buildSubmitButton(),
              ))
            ],
          ),
        ),
      ),
    );
  }

  //widget of the header information
  List<Widget> header() {
    return [
      Row(
        children: [
          Container(
            child: Image.asset('images/logo.png'),
            height: 70,
          ),
          TypewriterAnimatedTextKit(
            speed: Duration(milliseconds: 2000),
            text: ['Chat IN'],
            textStyle: TextStyle(
                fontSize: 45, fontWeight: FontWeight.w900, color: Colors.black),
          )
        ],
      ),
    ];
  }

  List<Widget> buildInput() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          key: Key('email'),
          decoration: InputDecoration(
              labelText: 'Phone number',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 25)),
          validator: EmailFieldValidator.validate,
          onSaved: (value) => email = value,
          controller: emailController,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          key: Key('password'),
          decoration: InputDecoration(
              labelText: allTranslations.text('password'),
              hintStyle: TextStyle(color: Colors.teal.shade900),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
          obscureText: true,
          validator: PasswordFieldValidator.validate,
          onSaved: (value) => password = value,
          controller: passwordController,
        ),
      ),
    ];
  }

  List<Widget> buildSubmitButton() {
    if (_formType == FormType.login) {
      return [
        //log in buttons
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: RaisedButton(
              key: Key('signIn'),
              child: Text(
                allTranslations.text("login"),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: Colors.blue,
              onPressed: () async {
                print('login');
                var username = emailController.text;
                var password = passwordController.text;
                var jwt = await AuthProvider.attemptLogIn(username, password);
                if (jwt != null) {
                  storage.write(key: "jwt", value: jwt);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage.fromBase64(jwt)));
                } else {
                  displayDialog(context, "An Error Occurred",
                      "No account was found matching that Email and password");
                }
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.blue,
            child: Text(
              allTranslations.text("sign_up"),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            onPressed: moveToRegister,
          ),
        ),
      ];
    } else {
      return [
        //sign up buttons
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: RaisedButton(
            child: Text(
              allTranslations.text("sign_up"),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            onPressed: () async {
              var username = emailController.text;
              var password = passwordController.text;

              if (username.length < 4)
                displayDialog(context, "Invalid Username",
                    "The username should be at least 4 characters long");
              else if (password.length < 4)
                displayDialog(context, "Invalid Password",
                    "The password should be at least 4 characters long");
              else {
                var res = await attemptSignUp(username, password);
                if (res == 201)
                  displayDialog(
                      context, "Success", "The user was created. Log in now.");
                else if (res == 409)
                  displayDialog(context, "That email is already registered",
                      "Please try to sign up using another username or log in if you already have an account.");
                else {
                  displayDialog(context, "Error", "An unknown error occurred.");
                }
              }
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.green,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: FlatButton(
            child: Text(
              allTranslations.text("sign_up_2"),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            onPressed: moveToLogin,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.lightBlueAccent,
          ),
        )
      ];
    }
  }
}
