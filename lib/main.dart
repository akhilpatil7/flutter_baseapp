import 'package:flutter/material.dart';
import 'package:flutkart/pages/home_screen.dart';
import 'package:flutkart/pages/intro_screen.dart';
import 'package:flutkart/pages/splash_screen.dart';
import 'package:flutkart/pages/login.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/intro": (BuildContext context) => IntroScreen(),
  "/login":(BuildContext context)  => LoginPage()
};

void main() => runApp(new MaterialApp(
    theme:
        ThemeData(primaryColor: const Color.fromRGBO(227, 170, 9, 1.0),
                  accentColor: const Color.fromRGBO(147, 109, 2, 1.0)

        ),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: routes));
