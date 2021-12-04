// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:testapp/src/models/task_model.dart';
import 'package:testapp/src/providers/task_provider.dart';

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
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 35, bottom: 12),
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
                  height: 40,
                ),
                botton(context)
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

  void _submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();

    print('Todo ok');
    print(task.proyect);
    print(task.date);

    //TODO:Aqui debo preguntar id del autor que esta creando esta task para mandarlo

    task.autor = "1";

    taskProvider.createTask(task);
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
