// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multiselect/multiselect.dart';
import 'package:testapp/src/blocs/provider.dart';
import 'package:testapp/src/blocs/tasks_bloc.dart';
import 'package:testapp/src/models/task_model.dart';
import 'package:testapp/src/models/user_model.dart';
import 'package:testapp/src/preferences/userloged.dart';

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

  final UserProvider userprovider = UserProvider();
  late TaskBloc bloc;

  final usuariologeado = UserLoged();

  List<Object?> selected = [];

  TaskModel task = TaskModel();

  var currentSelectedDate = DateTime.now();

  var dateController1;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of1(context);
    final taskdata = ModalRoute.of(context)?.settings.arguments;
    if (taskdata != null) {
      task = taskdata as TaskModel;
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        height: size.height + 170,
        width: size.width,
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.02,
                ),
                _createDetails(size),
                SizedBox(
                  height: size.height * 0.02,
                ),
                if (usuariologeado.type == 'managerequipo' &&
                    task.state == "Nueva") ...[
                  SizedBox(
                    width: size.width * 0.90,
                    child: FutureBuilder(
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
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  botton(context),
                  SizedBox(
                    height: size.height * 0.02,
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
          "Aceptar tarea",
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
          "Aceptar tarea",
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
          "Terminar tarea",
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
      bloc.editarTasks(task);

      mostrarSnackBar("Tarea editada");

      Navigator.pop(context);
    } else {
      mostrarSnackBar("No ha asignado ningún miembro de equipo");
    }
  }

  void _submit1() async {
    selected;

    if (task.state == 'Abierta') {
      task.state = 'En proceso';
    } else if (task.state == 'En proceso') {
      task.state = 'Cerrada';
    }

    bloc.editarTasks(task);

    mostrarSnackBar("Tarea ${task.state}");

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

  _createDetails(Size size) {
    return Container(
      
      margin: EdgeInsets.only(
        left: size.width * 0.10,
        right: size.width * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          Text(
             task.title,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            'Descripción: ' + task.description,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            'Tipo: ' + task.type!,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            'Fecha de cumplimiento: ' +
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
            height: size.height * 0.02,
          ),
          if (task.autor!.isNotEmpty) ...[
            FutureBuilder(
              future: userprovider.obtenerUsuarios1(),
              initialData: const [],
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  //List<UserModel> users = snapshot.data;
                  List<String> nombredeusuarios = [];

                  for (UserModel user in snapshot.data) {
                    if (task.autor!.contains(user.localId)) {
                      nombredeusuarios.add(user.name);
                    }
                  }

                  return Text(
                    'Autor: ' + nombredeusuarios.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Text(
                    'No tiene autor asignado todavia',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
            )
          ],
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            'Proyecto: ' + task.proyect!,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            'Estado de la tarea: ' + task.state,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          if (task.responsables!.isNotEmpty) ...[
            FutureBuilder(
              future: userprovider.obtenerUsuarios(),
              initialData: const [],
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  //List<UserModel> users = snapshot.data;
                  List<String> nombredeusuarios = [];

                  for (UserModel user in snapshot.data) {
                    if (task.responsables!.contains(user.localId)) {
                      nombredeusuarios.add(user.name);
                    }
                  }

                  return Text(
                    'Responsables: ' + nombredeusuarios.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Text(
                    'No hay responsables asignados todavia',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
            )
          ],
        ],
      ),
    );
  }
}
