
import 'package:flutter/material.dart';
import 'package:testapp/src/pages/home_page.dart';
import 'package:testapp/src/pages/login_page.dart';

Map<String, WidgetBuilder> GetAplicationRoutes() {
  return {
    'login': (BuildContext context) => LoginPage(),
     'home': (BuildContext context) => HomePage(),
  };
}
