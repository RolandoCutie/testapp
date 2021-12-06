// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multiselect/multiselect.dart';
import 'package:testapp/src/models/task_model.dart';
import 'package:testapp/src/models/user_model.dart';
import 'package:testapp/src/preferences/userloged.dart';

import 'package:testapp/src/providers/task_provider.dart';
import 'package:testapp/src/providers/user_provider.dart';

enum EnumType { onat, inventario, alquiler, compraproducto, transporte }
enum EnumProyect { proyecto1, proyecto2, proyeto3, proyecto4 }
enum EnumState { nueva, abierta, enproceso, cerrada }

class TaskDetailPage extends StatefulWidget {
  //const TaskCreatePage({Key? key}) : super(key: key);

  //Key del formulario para poder usarla para validar los campos

  const TaskDetailPage({Key? key}) : super(key: key);

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final formKey = GlobalKey<FormState>();
  final taskProvider = TasksProviders();
  final UserProvider userprovider = UserProvider();

  final usuariologeado = UserLoged();

  List<Object?> selected = [];

  TaskModel task = TaskModel();

  var currentSelectedDate = DateTime.now();

  var dateController1;

  @override
  Widget build(BuildContext context) {
    final taskdata = ModalRoute.of(context)?.settings.arguments;
    if (taskdata != null) {
      task = taskdata as TaskModel;
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskAPP'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
          child: Container(
        height: size.height,
        padding: EdgeInsets.only(
          left: 25.0,
          right: 25.0,
          top: 5,
        ),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                _createDetails(),
                SizedBox(
                  height: 20,
                ),
                if (usuariologeado.type == 'managerequipo' &&
                    task.state == "Nueva") ...[
                  FutureBuilder(
                      future: userprovider.obtenerUsuarios(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<UserModel>> snapshot) {
                        if (snapshot.hasData) {
                          final _items = snapshot.data!
                              .map((animal) => MultiSelectItem<UserModel>(
                                  animal, animal.name))
                              .toList();

                          return MultiSelectBottomSheetField(
                            initialChildSize: 0.4,
                            listType: MultiSelectListType.CHIP,
                            searchable: true,
                            buttonText: Text("Seleccionar Miembros"),
                            title: Text("Miembros"),
                            items: _items,
                            onConfirm: (values) {
                              selected = values;
                            },
                            chipDisplay: MultiSelectChipDisplay(
                              onTap: (value) {
                                setState(() {
                                  selected.remove(value);
                                });
                              },
                            ),
                          );
                        }
                        {
                          return Text('no hay miembros');
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  botton(context),
                  SizedBox(
                    height: 20,
                  ),
                ]

                //TODO:Aqui miro si la tarea esta abierta y pertenece al usuario que esta viendola

                else if (task.state == "Abierta" &&
                    task.responsables!.contains(usuariologeado.localId)) ...[
                  botton1(context),
                ] else if (task.state == "En proceso" &&
                    task.responsables!.contains(usuariologeado.localId)) ...[
                  botton2(context),
                ],

              ],
            )),
      )),
    );
  }

  Widget botton(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: _submit,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Text(
          "Acept Task",
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

  Widget botton1(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: _submit1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Text(
          "Begin Task",
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

  Widget botton2(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: _submit1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Text(
          "End Task",
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
    if (selected.isNotEmpty) {
      selected;
      task.state = 'Abierta';
      //task.responsables = [];

      if (selected.isNotEmpty) {
        for (var item in selected) {
          item as UserModel;
          task.responsables!.add(item.localId);
        }
      }
      bool f = await taskProvider.editTask(task);
      if (f == true) {
        Navigator.pop(context, 'home');
        mostrarSnackBar("Tarea editada");
      }
    } else {
      mostrarSnackBar("No ha asignado ningun miembro de equipo");
    }
  } 

  void _submit1() async {
    selected;

    if (task.state == 'Abierta') {
      task.state = 'En proceso';
    } else if (task.state == 'En proceso') {
      task.state = 'Cerrada';
    }

    bool f = await taskProvider.editTask(task);
    if (f == true) {

      Navigator.pop(context, 'home');
      mostrarSnackBar("Tarea ${task.state}");
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
  _createDetails() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tarea Asignada',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 23,
          ),
          Text(
            'Titulo:' + task.title,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 23,
          ),
          Text(
            'Descripcion:' + task.description,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 23,
          ),
          Text(
            'Tipo:' + task.type!,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 23,
          ),
          Text(
            'Fecha de Cumplimiento:' +
                task.date!.day.toString() +
                '-' +
                task.date!.month.toString() +
                '-' +
                task.date!.year.toString(),
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 23,
          ),
          Text(
            'Author:' + task.autor!,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 23,
          ),
          Text(
            'Proyecto:' + task.proyect!,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 23,
          ),
          Text(
            'Estado de la tarea:' + task.state,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
