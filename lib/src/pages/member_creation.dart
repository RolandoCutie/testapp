// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/src/models/task_model.dart';
import 'package:testapp/src/models/user_model.dart';
import 'package:testapp/src/providers/task_provider.dart';

enum EnumType { managergeneral, managerequipo, miembroequipo, }
enum EnumProyect { proyecto1, proyecto2, proyeto3, proyecto4 }
enum EnumState { nueva, abierta, enproceso, cerrada }

class MemberCreatePage extends StatefulWidget {
  //const TaskCreatePage({Key? key}) : super(key: key);

  //Key del formulario para poder usarla para validar los campos

  const MemberCreatePage({Key? key}) : super(key: key);

  @override
  State<MemberCreatePage> createState() => _MemberCreateState();
}

class _MemberCreateState extends State<MemberCreatePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final taskProvider = TasksProviders();

  UserModel task = UserModel();

  var currentSelectedDate = DateTime.now();

  var dateController1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('TaskAPP'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
          child: Container(
        height: size.height,
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 35, bottom: 12),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                _createTitle(),
                SizedBox(
                  height: 20,
                ),
                _createDescription(),
                SizedBox(
                  height: 20,
                ),
                _createType(),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
               _createlocalid()
               ,
                SizedBox(
                  height: 20,
                ),
                botton(context)
              ],
            )),
      )),
    );
  }

  _createTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            'Nombre',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          onSaved: (value) => task.name = value!,
          initialValue: task.name,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == "") {
              return 'Ingrese los datos';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }

  _createDescription() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            'Email',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          onSaved: (value) => task.email = value!,
          initialValue: task.email,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == "") {
              return 'Ingrese los datos';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }

  _createType() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              'Tipo',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DropdownButtonFormField<String>(
            //value: task.type,
            // value: exp_month.toString(),
            onChanged: (value) {},

            onSaved: (value) => task.type = value!,
            validator: (value) {
              if (value == "") {
                return 'Ingrese los datos';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              filled: false,
              fillColor: Colors.red,
              border: OutlineInputBorder(),
            ),
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              DropdownMenuItem(
                child: Text('Manager General'),
                value: "managergeneral",
              ),
              DropdownMenuItem(
                child: Text('Manager Equipo'),
                value: "managerequipo",
              ),
              DropdownMenuItem(
                child: Text('Miembro Equipo'),
                value: "miembroequipo",
              ),
            ],
          )
        ]);
  }

  _createlocalid() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            'LocalId',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          onSaved: (value) => task.localId = value!,
          initialValue: task.localId,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == "") {
              return 'Ingrese los datos';
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }

 

  Widget botton(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: _submit,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Text(
          "Create Member",
          style: TextStyle(fontSize: 14),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 22.0,
      textColor: Colors.white,
    );
  }

 

  void _submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();

   

    final f = await taskProvider.createUser(task);

    if (f == true) {
      Navigator.pop(context, 'home');
      mostrarSnackBar("Usuario creeado");
    }
  }

  void mostrarSnackBar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(
        mensaje,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Theme.of(context).primaryColor,
    );
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        snackbar,
      );
    });
  }

 


}
