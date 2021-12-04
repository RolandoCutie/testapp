// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/src/models/task_model.dart';
import 'package:testapp/src/providers/task_provider.dart';

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
  final taskProvider = TasksProviders();

  TaskModel task = TaskModel();

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
                _createDate(),
                SizedBox(
                  height: 20,
                ),
                _createProyect(),
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
            'Titulo',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          onSaved: (value) => task.title = value!,
          initialValue: task.title,
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
            'Descripcion',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          onSaved: (value) => task.description = value!,
          initialValue: task.description,
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
              'Type',
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
          )
        ]);
  }

  _createProyect() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              'Proyecto',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DropdownButtonFormField<String>(
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
              contentPadding: EdgeInsets.zero,
              filled: false,
              fillColor: Colors.red,
              border: OutlineInputBorder(),
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
          )
        ]);
  }

  Widget botton(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: _submit,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Text(
          "Create Task",
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            'Date',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: callDatePicker,
          child: Container(
            child: Text(
              "Select Date",
              style: TextStyle(fontSize: 14),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 22.0,
          textColor: Colors.white,
        )
      ],
    );
  }

  void _submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();

    print('Todo ok');
    print(task.proyect);
    print(task.date);

    task.state = "Nueva";

    //TODO:Aqui debo preguntar id del autor que esta creando esta task para mandarlo

    task.autor = "1";

    final f = await taskProvider.createTask(task);

    if (f == true) {
      Navigator.pop(context, 'home');
      mostrarSnackBar("Tarea creada");
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
