// ignore_for_file: void_checks

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testapp/src/models/task_model.dart';
import 'package:testapp/src/models/user_model.dart';
import 'package:testapp/src/preferences/user_preferences.dart';

class UserProvider {
  final String _firebaseToken = 'AIzaSyD5uRxBtopPvzqGDO83MKpksJNrG5gE4dA';

  static const String _url =
      'https://testapp-ac4c3-default-rtdb.firebaseio.com/';

  static final prefs = PreferenciasUsuarios();

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToke': true,
    };

    final resp = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken'),
      body: json.encode(authData),
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      //TODO:salvar el token en el storage

      prefs.token = decodeResp['idToken'];

      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'token': decodeResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToke': true,
    };

    final resp = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken'),
      body: json.encode(authData),
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      //TODO:salvar el token en el storage
      prefs.token = decodeResp['localId'];
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'token': decodeResp['error']['message']};
    }
  }

  static Future<UserModel> obtenerUsuario() async {
    final url = '$_url/User.json';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodeData = json.decode(resp.body);

    UserModel task1 = UserModel();

    decodeData.forEach((id, task) {
      final taskTemp = UserModel.fromJson(task);

      taskTemp.id = id;

      if (taskTemp.localId == prefs.token) task1 = taskTemp;
    });

    return task1;
  }

   Future<List<UserModel>> obtenerUsuarios() async {
    final url = '$_url/User.json';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodeData = json.decode(resp.body);

    UserModel task1 = UserModel();

    List<UserModel> tasks = [];

    decodeData.forEach((id, task) {
      final taskTemp = UserModel.fromJson(task);

      taskTemp.id = id;

      if (taskTemp.type == 'miembroequipo') tasks.add(taskTemp);
    });

    return tasks;
  }
   Future<List<UserModel>> obtenerUsuarios1() async {
    final url = '$_url/User.json';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodeData = json.decode(resp.body);

    UserModel task1 = UserModel();

    List<UserModel> tasks = [];

    decodeData.forEach((id, task) {
      final taskTemp = UserModel.fromJson(task);

      taskTemp.id = id;

      tasks.add(taskTemp);
    });

    return tasks;
  }

  

  /*Future<UserModel> getLogedUser() async {
    final response = await userprovider.obtenerUsuario();
    return response;
  }*/
}
