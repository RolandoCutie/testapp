import 'package:flutter/material.dart';
import 'package:testapp/src/pages/home_page.dart';
import 'package:testapp/src/pages/home_page1.dart';
import 'package:testapp/src/pages/login_page.dart';
import 'package:testapp/src/pages/member_creation.dart';
import 'package:testapp/src/pages/splash_screen.dart';
import 'package:testapp/src/pages/task_create_page.dart';
import 'package:testapp/src/pages/task_detail.dart';
import 'package:testapp/src/pages/task_ended.dart';
import 'package:testapp/src/pages/task_pending.dart';
import 'package:testapp/src/pages/tasks_news_page.dart';

Map<String, WidgetBuilder> GetAplicationRoutes() {

  
  return {
    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage1(),
    'splash': (BuildContext context) => SplashScreenPage(),
    'task_pending': (BuildContext context) => TaskPendingPage(),
    'task_ended': (BuildContext context) => TaskEndedPage(),
    'home_page1': (BuildContext context) => HomePage(),
    'task_create_page': (BuildContext context) => TaskCreatePage(),
    'task_detail': (BuildContext context) => TaskDetailPage(),
    'tasks_news_page': (BuildContext context) => TaskNewsPage(),
    'member_creation': (BuildContext context) => MemberCreatePage(),
  };
}
