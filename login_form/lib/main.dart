

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login_form/splash-sreen.dart';
import 'package:login_form/translation.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await allTranslations.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();

    // Initializes a callback should something need
    // to be done when the language is changed
    allTranslations.onLocaleChangedCallback = _onLocaleChanged;
    //_fetchStore();
  }

  ///
  /// If there is anything special to do when the user changes the language
  ///
  _onLocaleChanged() async {
    // do anything you need to do if the language changes
    print('Language has been changed to: ${allTranslations.currentLanguage}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // Tells the system which are the supported languages
      supportedLocales: allTranslations.supportedLocales(),
      theme: ThemeData(
        fontFamily: 'Slabo',
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(hintStyle:
        TextStyle(color: Colors.blue)),
        hintColor: Colors.blue,
      ),
      home:SplashScreen(),

    );
  }
}
