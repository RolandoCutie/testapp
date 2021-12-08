import 'package:flutter/material.dart';
import 'package:testapp/src/blocs/provider.dart';
import 'package:testapp/src/blocs/tasks_bloc.dart';
import 'package:testapp/src/models/task_model.dart';
import 'package:testapp/src/providers/task_provider.dart';

class TaskEndedPage extends StatelessWidget {
  TaskEndedPage({Key? key}) : super(key: key);
  final taskprovider = TasksProviders();
  @override
  Widget build(BuildContext context) {
    final taskbloc = Provider.of1(context);
    taskbloc.cargarTasksFinalizadas();
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Finalizadas'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _crearListado(),
    );
    //floatingActionButton: _crearBoton(context),
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: taskprovider.obtenerTareasFinalizadas(),
      builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
        if (snapshot.hasData) {
          final tasks = snapshot.data;
          if (tasks!.isNotEmpty) {
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, i) => _crearItem(context, tasks[i], i),
            );
          } else {
            return Center(
              child: Text('No hay tareas finalizadas'),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, TaskModel task, int i) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        top: size.height * 0.01,
        right: size.width * 0.05,
        left: size.width * 0.05,
      ),
      child: Card(
          elevation: 5.0,
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      (i + 1).toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    task.type!,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  onTap: () => Navigator.pushNamed(context, 'task_detail',
                      arguments: task)),
            ],
          )),
    );
  }
}
