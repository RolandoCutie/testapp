// ignore_for_file: prefer_const_constructors

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
    final usuariologeado = UserLoged();

    return Scaffold(
      body: _callPage(currentIndex),
      bottomNavigationBar: _botton(),
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return HomePage1();
      case 1:
        return TaskNewsPage();
      case 2:
        return TaskPendingPage();
      case 3:
        return TaskEndedPage();
      default:
        return HomePage1();
    }
  }

  Widget _botton() {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,

      backgroundColor: Theme.of(context).primaryColor,
      elevation: 12,
      iconSize: 30,
      selectedItemColor: Colors.white,
      

      currentIndex: currentIndex,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Nuevas '),
        BottomNavigationBarItem(
            icon: Icon(Icons.pending_actions_outlined), label: 'En proceso'),
        BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_outlined), label: 'Finalizadas'),
      ],
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }
}
