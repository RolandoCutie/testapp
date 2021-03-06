// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/src/blocs/provider.dart';
import 'package:testapp/src/blocs/tasks_bloc.dart';

import 'package:testapp/src/models/task_model.dart';
import 'package:testapp/src/preferences/userloged.dart';

enum EnumType { onat, inventario, alquiler, compraproducto, transporte }
enum EnumProyect { proyecto1, proyecto2, proyeto3, proyecto4 }
enum EnumState { nueva, abierta, enproceso, cerrada }

class TaskCreatePage extends StatefulWidget {
  //const TaskCreatePage({Key? key}) : super(key: key);

  //Key del formulario para poder usarla para validar los campos

  const TaskCreatePage({Key? key}) : super(key: key);

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TaskBloc bloc;

  TaskModel task = TaskModel();

  var currentSelectedDate = DateTime.now();

  var dateController1;
  @override
  Widget build(BuildContext context) {
    bloc = Provider.of1(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Crear tarea'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
          child: Container(
        height: size.height + 140,
        width: size.width,
        padding: EdgeInsets.only(
          left: size.width * 0.10,
          right: size.width * 0.10,
          //top: size.height * 0.10,
        ),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.02,
                ),
                _createTitle(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                _createDescription(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                _createType(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                _createProyect(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                _createDate(),
                SizedBox(
                  height: size.height * 0.02,
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
          padding: EdgeInsets.all(10),
          child: TextFormField(
            onSaved: (value) => task.title = value!,
            initialValue: task.title,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'T??tulo'),
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
          padding: EdgeInsets.all(10),
          child: TextFormField(
            onSaved: (value) => task.description = value!,
            initialValue: task.description,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Descripci??n'),
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
              padding: EdgeInsets.all(10),
              child: DropdownButtonFormField<String>(
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
                  border: OutlineInputBorder(),
                  labelText: 'Tipo',
                  contentPadding: EdgeInsets.all(10),
                  filled: false,
                  fillColor: Colors.red,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                items: [
                  DropdownMenuItem(
                    child: Text('ONAT'),
                    value: "ONAT",
                  ),
                  DropdownMenuItem(
                    child: Text('Inventario'),
                    value: "Inventario",
                  ),
                  DropdownMenuItem(
                    child: Text('Alquiler'),
                    value: "Alquiler",
                  ),
                  DropdownMenuItem(
                    child: Text('Compra producto'),
                    value: "Compra producto",
                  ),
                  DropdownMenuItem(
                    child: Text('Transporte'),
                    value: "Transporte",
                  ),
                ],
              ))
        ]);
  }

  _createProyect() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              child: DropdownButtonFormField<String>(
                //value: task.proyect,
                onChanged: (value) {},

                onSaved: (value) => task.proyect = value!,
                validator: (value) {
                  if (value == "") {
                    return 'Ingrese los datos';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Proyecto',
                  contentPadding: EdgeInsets.all(10),
                  filled: false,
                  fillColor: Colors.red,
                ),
                // ignore: prefer_const_literals_to_create_immutables
                items: [
                  DropdownMenuItem(
                    child: Text('Proyecto 1'),
                    value: "Proyecto 1",
                  ),
                  DropdownMenuItem(
                    child: Text('Proyecto 2'),
                    value: "Proyecto 2",
                  ),
                  DropdownMenuItem(
                    child: Text('Proyecto 3'),
                    value: "Proyecto 3",
                  ),
                  DropdownMenuItem(
                    child: Text('Proyecto 4'),
                    value: "Proyecto 4",
                  ),
                ],
              ))
        ]);
  }

  Widget botton(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: _submit,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
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
    );
  }

  _createDate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: callDatePicker,
              child: Container(
                child: Text(
                  "Seleccionar fecha",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 22.0,
              textColor: Colors.white,
            ))
      ],
    );
  }

  void _submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final usuariologeado = UserLoged();

    print('Todo ok');
    print(task.proyect);
    print(task.date);

    task.state = "Nueva";

    task.responsables = ["1"];

    //TODO:Aqui debo preguntar id del autor que esta creando esta task para mandarlo

    task.autor = usuariologeado.localId;
    formKey.currentState!.save();
    
    bloc.agregarTasks(task);

    mostrarSnackBar("Tarea creada");

    Navigator.pop(context);
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

  Future<DateTime?> getDatePickerWidget(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: currentSelectedDate,
        firstDate: DateTime(2017),
        lastDate: DateTime(2031),
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        });
  }

  void callDatePicker() async {
    var selectedDate = await getDatePickerWidget(context);
    setState(() {
      currentSelectedDate = selectedDate!;

      var str = json.encode(selectedDate, toEncodable: myEncode);
      task.date = selectedDate;
    });
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }
}
