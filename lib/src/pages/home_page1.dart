// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:testapp/src/api/notifications.dart';
import 'package:testapp/src/blocs/provider.dart';
import 'package:testapp/src/models/user_model.dart';
import 'package:testapp/src/preferences/userloged.dart';
import 'package:testapp/src/providers/user_provider.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuariologeado = UserLoged();
    final size = MediaQuery.of(context).size;

    if (usuariologeado.type == 'managergeneral') {
      return Scaffold(
        appBar: AppBar(
          title: Text('TaskAPP'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
                top: size.height * 0.05),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.pushNamed(context, 'task_create_page');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      child: Text(
                        "Crear tarea",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 22.0,
                    textColor: Colors.white,
                  ),
                ]),
          ),
        ),
        //floatingActionButton: _crearBoton(context),
      );
    } else if (usuariologeado.type == 'miembroequipo') {
      return Scaffold(
        appBar: AppBar(
          title: Text('TaskAPP'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
                top: size.height * 0.05),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Bienvenido' +
                      usuariologeado.nombre +
                      ' te esperan nuevas tareas que cumplir')
                ]),
          ),
        ),
        //floatingActionButton: _crearBoton(context),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('TaskAPP'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.only(
              left: size.width * 0.05,
              right: size.width * 0.05,
              top: size.height * 0.05,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Bienvenido ' +
                      usuariologeado.nombre +
                      ' te esperan nuevas tareas que asignar')
                ]),
          ),
        ),
        //floatingActionButton: _crearBoton(context),
      );
    }
  }
}
