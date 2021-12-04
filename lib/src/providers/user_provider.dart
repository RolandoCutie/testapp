import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider {
  final String _firebaseToken = 'AIzaSyD5uRxBtopPvzqGDO83MKpksJNrG5gE4dA';

  Future nuevoUsuario(String email, String password) async {
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

      return {'ok': true, 'token': decodeResp['idToken']};
    }
    else{
      return {'ok': false, 'token': decodeResp['error']['message ']};
    }
  }
}
