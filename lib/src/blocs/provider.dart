// ignore_for_file: prefer_conditional_assignment, unnecessary_null_comparison
import 'package:flutter/material.dart';


import 'login_bloc.dart';


class Provider extends InheritedWidget {

  //instancia de la clase
  static Provider? _instancia;


  //creacion de un singlenton
  factory Provider({Key? key, required Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia!;
  }

  //constructor privado que permite que la clase no se pueda inicializar desde afuera
  Provider._internal({Key? key, required Widget child}) : super(key: key, child: child);

  final loginBloc = LoginBloc();

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider)
        .loginBloc;
  }
}
