// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:testapp/src/api/notifications.dart';
import 'package:testapp/src/blocs/provider.dart';
import 'package:testapp/src/models/user_model.dart';
import 'package:testapp/src/preferences/user_preferences.dart';
import 'package:testapp/src/preferences/userloged.dart';
import 'package:testapp/src/providers/user_provider.dart';
import 'package:testapp/src/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = PreferenciasUsuarios();

  await prefs.initPrefs();

  //TODO:inicializar notificaciones de

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    listenNotifications();

  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClikedNotification);

  void onClikedNotification(String? payload) =>
      Navigator.of(context).pop('home');

      

  @override
  Widget build(BuildContext context) {


    return Provider(
        child: MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: GetAplicationRoutes(),
      theme: ThemeData(primaryColor: HexColor('##2094AD')),
    ));
  }
}
