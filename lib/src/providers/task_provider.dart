import 'dart:convert';

import 'package:testapp/src/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/src/models/user_model.dart';

class TasksProviders {
  final String _url = 'https://testapp-ac4c3-default-rtdb.firebaseio.com/';

  Future<bool> createTask(TaskModel task) async {
    final url = '$_url/Tasks.json';

    final response =
        await http.post(Uri.parse(url), body: taskModelToJson(task));

    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;
  }

  Future<bool> editTask(TaskModel task) async {
    final url = '$_url/Tasks.json';

    final response =
        await http.post(Uri.parse(url), body: taskModelToJson(task));

    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;
  }

  Future<bool> editarProducto(TaskModel task) async {
    final url = '$_url/productos/${task.id}.json';

    final response =
        await http.put(Uri.parse(url), body: taskModelToJson(task));

    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;
  }

  Future<List<TaskModel>> obtenerTareas(String tipo) async {
    final url = '$_url/Tasks.json';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<TaskModel> tasks = [];

    if (decodeData == null) return [];

    decodeData.forEach((id, task) {
      final taskTemp = TaskModel.fromJson(task);

      taskTemp.id = id;

      //tODO:Arreglr con un switch despues
      if (tipo == "") {
        tasks.add(taskTemp);
      } else if (tipo == taskTemp.state) {
        tasks.add(taskTemp);
      }
    });

    return tasks;
  }

  /* Future<UserModel> obtenerUsuario(String id) async {
    final url = '$_url/Tasks.json';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<TaskModel> tasks = [];

    if (decodeData == null) return [];

    decodeData.forEach((id, task) {
      final taskTemp = TaskModel.fromJson(task);
      taskTemp.id = id;
      print(task);
      tasks.add(taskTemp);
    });

    return tasks;
  }*/

}
