import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/src/models/user_model.dart';
import 'package:testapp/src/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class UserLoged {
  //Patron singlenton
  static final UserLoged _instancia = UserLoged._internal();

  factory UserLoged() {
    return _instancia;
  }

  UserLoged._internal();

  //Aqui hago una varibale para referirme a las preferencias del sistema
  late UserModel _prefs;

  initPrefs() async {

    _prefs = await UserProvider.obtenerUsuario();

  }

  String get nombre {
    return _prefs.getNombre('token') ?? 'uknow';
  }
    set nombre (String value) {
    _prefs.setNombre('token', value);
  }

   String get type {
    return _prefs.getType('token') ?? 'uknow';
  }

   String get localId {
    return _prefs.getLocalId('token') ?? 'uknow';
  }
  
   
}
