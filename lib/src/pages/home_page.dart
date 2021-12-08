// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:testapp/src/blocs/provider.dart';
import 'package:testapp/src/pages/home_page1.dart';
import 'package:testapp/src/pages/task_ended.dart';
import 'package:testapp/src/pages/task_pending.dart';
import 'package:testapp/src/pages/tasks_news_page.dart';
import 'package:testapp/src/preferences/userloged.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      body: _callPage(currentIndex),
      bottomNavigationBar: _botton1(),
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return TaskNewsPage();
      case 1:
        return TaskPendingPage();
      case 2:
        return TaskEndedPage();
      default:
        return TaskNewsPage();
    }
  }

 
  Widget buildnavBar(String iconoactivo, String icononoactivo, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: index == currentIndex
              ? Colors.white
              : Theme.of(context).primaryColor,
        ),
        width: MediaQuery.of(context).size.width / 3,
        child: Center(
            child: index == currentIndex
                ? Image.asset(
                    iconoactivo,
                    height: 45,
                    width: 35,
                  )
                : Image.asset(
                    icononoactivo,
                    height: 45,
                    width: 35,
                  )),
      ),
    );
  }

  _botton1() {
    return Row(children: <Widget>[
      buildnavBar("assets/PNG/Opcion 2 AZUL_NEW.png",
          "assets/PNG/Opcion 2 BLANCO_NEW.png", 0),
      buildnavBar("assets/PNG/Opcion 2 AZUL_PENDING.png",
          "assets/PNG/Opcion 2 BLANCO_PENDING.png", 1),
      buildnavBar("assets/PNG/Opcion 2 AZUL_ENDED.png",
          "assets/PNG/Opcion 2 BLANCO_ENDED.png", 2),
    ]);
  }
}
