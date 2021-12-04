// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:testapp/src/blocs/provider.dart';
import 'package:testapp/src/models/task_model.dart';
import 'package:testapp/src/providers/task_provider.dart';

class TaskNewsPage extends StatelessWidget {
  TaskNewsPage({Key? key}) : super(key: key);

  final taskprovider = TasksProviders();
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('TaskAPP'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _crearListado(),
    );
    //floatingActionButton: _crearBoton(context),
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: taskprovider.obtenerTareas("Nueva"),
      builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
        if (snapshot.hasData) {
          final tasks = snapshot.data;
          return ListView.builder(
            itemCount: tasks!.length,
            itemBuilder: (context, i) => _crearItem(context, tasks[i]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, TaskModel task) {
    return Container(
        height: 90.0,
        margin: EdgeInsets.only(left: 26.0, right: 26.0, top: 20.0),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ]),
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            "Descripcion:${task.description}",
            style: TextStyle(color: Colors.white),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(20),
          ),
          onTap: () =>
              Navigator.pushNamed(context, 'task_detail', arguments: task),
        ));
  }
}
