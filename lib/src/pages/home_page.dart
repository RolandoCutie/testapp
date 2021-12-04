// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:testapp/src/pages/home_page1.dart';
import 'package:testapp/src/pages/task_ended.dart';
import 'package:testapp/src/pages/task_pending.dart';
import 'package:testapp/src/pages/tasks_news_page.dart';

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
      bottomNavigationBar: _crear(),
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

  Widget _crear() {
    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,

      backgroundColor: Theme.of(context).primaryColor,
      elevation: 12,
      iconSize: 30,
      selectedItemColor: Colors.white,

      currentIndex: currentIndex,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit_rounded), label: 'HomePage'),
        BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline_outlined), label: 'TaskNews'),
        BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline_outlined), label: 'TaskPending'),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_outlined),
            label: 'TaskEnded'),
      ],
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }
}
