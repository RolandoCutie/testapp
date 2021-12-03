// ignore_for_file: unnecessary_new

import 'dart:async';

class Validators {
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Más de 6 caracteres por favor');
    }
  });

  final validarEmail =StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    // ignore: unused_local_variable
    RegExp regex = new RegExp(pattern.toString());

    if (regex.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('El formato de email es incorrecto');
    }
  });
}
