// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:testapp/src/api/notifications.dart';
import 'package:testapp/src/blocs/login_bloc.dart';
import 'package:testapp/src/blocs/provider.dart';
import 'package:testapp/src/models/task_model.dart';
import 'package:testapp/src/preferences/userloged.dart';
import 'package:testapp/src/providers/task_provider.dart';
import 'package:testapp/src/providers/user_provider.dart';

class LoginPage extends StatelessWidget {
  final usuarioProvider = UserProvider();

  LoginPage({Key? key}) : super(key: key);

  //Todo:build de la pagina
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  //Todo:Aqui va el fondo de inicio
  Widget _crearFondo(BuildContext context) {
    //Variable para saber el size del dispositivo
    final size = MediaQuery.of(context).size;

    final fondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );

    final logo = Container(
      padding: EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.task,
            color: Colors.white,
            size: 100.0,
          ),
          SizedBox(
            height: 10.0,
            width: double.infinity,
          ),
          Text(
            "TaskAPP",
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        fondo,
        logo,
      ],
    );
  }

  //Todo:Aqui va la cajita del login
  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);

    final zize = MediaQuery.of(context).size;

    bool _showPasswords = false;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: zize.height * 0.23,
          )),
          Container(
            width: zize.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 30.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text("Ingreso",
                    style: TextStyle(
                      fontSize: 18.0,
                    )),
                SizedBox(
                  height: 10.0,
                ),
                _crearEmail(bloc),
                SizedBox(
                  height: 10.0,
                ),
                _crearPassword(bloc),
                SizedBox(
                  height: 25.0,
                ),
                _crearBoton(bloc),
              ],
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
        ],
      ),
    );
  }

  //Todo:Llenar el campo del email
  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        bool f = snapshot.hasError;
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: 'ejemplo@correo.com',
                errorText: _validarerror(f, snapshot),
                labelText: 'Correo electrónico',
                //counterText: snapshot.data
              ),
              onChanged: bloc.changeEmail,
            ));
      },
    );
  }

  //Todo:Aqui va lo de llenar los campos el del password
  Widget _crearPassword(LoginBloc bloc) {
    bool _showPasswords = false;

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        bool f = snapshot.hasError;
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              obscureText: !_showPasswords,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Theme.of(context).primaryColor,
                ),

                labelText: 'Contraseña',
                errorText: _validarerror(f, snapshot),
                //counterText: snapshot.data
              ),
              onChanged: bloc.changePassword,
            ));
      },
    );
  }

  _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Text(
              "Ingresar",
              style: TextStyle(fontSize: 14),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 22.0,
          textColor: Colors.white,
        );
      },
    );
  }

  _validarerror(bool f, AsyncSnapshot snapshot) {
    if (f == true) {
      return snapshot.error.toString();
    }
  }

  _login(LoginBloc bloc, BuildContext context) async {
    TasksProviders task = TasksProviders();

    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    if (info['ok']) {
      final prefs1 = UserLoged();

      await prefs1.initPrefs();

      List<TaskModel> tareas = await task.obtenerTareasNuevas();

      if (tareas.isNotEmpty) {
        NotificationApi.showNotification(
            title: 'Bienvenido',
            body: 'Tiene ${tareas.length} nuevas tareas',
            payload: 'dddd');
      }

      Navigator.pushReplacementNamed(context, 'home_page1');
    } else {
      _mostrarAlerta(context, info['token']);
    }
  }

  void _mostrarAlerta(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Informacion incorrecta'),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Ok'))
            ],
          );
        });
  }
}
