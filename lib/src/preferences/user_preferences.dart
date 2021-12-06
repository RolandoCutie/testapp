import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/src/models/user_model.dart';
import 'package:testapp/src/providers/user_provider.dart';

class PreferenciasUsuarios {
  
  //Patron singlenton
  static final PreferenciasUsuarios _instancia =
      PreferenciasUsuarios._internal();

  factory PreferenciasUsuarios() {
    return _instancia;
  }

  PreferenciasUsuarios._internal();

  //Aqui hago una varibale para referirme a las preferencias del sistema
  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //GET y SET del Nombre
  set token(String value) {
    _prefs.setString('token', value);
  }

  String get token {
    return _prefs.getString('token') ?? 'uknow';
  }

  //GET y SET del la ultimaPagina
  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
  

  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  
}
