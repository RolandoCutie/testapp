import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:testapp/src/blocs/validators.dart';

class LoginBloc with Validators {

  //Streams para controlar los aprametros de la pagina login
  final _emailController = BehaviorSubject<String>();

  final _passwordController = BehaviorSubject<String>();

  //Obtener el utlimo valor ingresado a los Streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  //Para validar que los dos streams esten bien validados
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Obtener valores de los sstreams
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  //Insertar datos dentro de los streams  
  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;


}
