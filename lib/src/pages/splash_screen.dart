// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testapp/src/pages/login_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Hero(
      tag: 'home',
      child: Container(
        height: size.height + 20,
        width: size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Image.asset(
          'assets/PNG/HOME BLUE 1.png',
          fit: BoxFit.fill,
          height: 150,
          width: 144,
        ),
      ),
    );
  }
}
