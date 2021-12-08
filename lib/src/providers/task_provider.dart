import 'dart:convert';

import 'package:testapp/src/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/src/models/user_model.dart';
import 'package:testapp/src/preferences/user_preferences.dart';
import 'package:testapp/src/preferences/userloged.dart';

class TasksProviders {
  final String _url = 'https://testapp-ac4c3-default-rtdb.firebaseio.com';
  final _prefs = PreferenciasUsuarios();

  Future<bool> createTask(TaskModel task) async {

    final url = '$_url/tasks.json';

    final response =
    await http.post(Uri.parse(url), body: taskModelToJson(task));

    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;

  }

  Future<bool> editTask(TaskModel task) async {
    final url = '$_url/tasks/${task.id}.json';

    final response =
        await http.put(Uri.parse(url), body: taskModelToJson(task));

    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;
  }

  Future<bool> createUser(UserModel task) async {
    final url = '$_url/User.json';

    final response =
        await http.post(Uri.parse(url), body: userModelToJson(task));

    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;
  }


  Future<List<TaskModel>> obtenerTareas() async {
    final usuariologeado = UserLoged();

    final url = '$_url/tasks.json';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<TaskModel> tasks = [];

    decodeData.forEach((id, task) {
      final taskTemp = TaskModel.fromJson(task);

      taskTemp.id = id;
      tasks.add(taskTemp);
      
    });
    return tasks;
  }

  Future<List<TaskModel>> obtenerTareasNuevas() async {
    final usuariologeado = UserLoged();

    final url = '$_url/tasks.json';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<TaskModel> tasks = [];

    decodeData.forEach((id, task) {
      final taskTemp = TaskModel.fromJson(task);

      taskTemp.id = id;

      if (usuariologeado.type == 'managerequipo') {
        if ("Nueva" == taskTemp.state) {
          tasks.add(taskTemp);
        }
      } else if (usuariologeado.type == 'miembroequipo') {
        if ("Abierta" == taskTemp.state &&
            taskTemp.responsables!.contains(usuariologeado.localId)) {
          tasks.add(taskTemp);
        }
      }
    });
    return tasks;
  }

  Future<List<TaskModel>> obtenerTareasPendientes() async {
    final usuariologeado = UserLoged();

    final url = '$_url/tasks.json';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<TaskModel> tasks = [];

    decodeData.forEach((id, task) {
      final taskTemp = TaskModel.fromJson(task);

      taskTemp.id = id;

      if (usuariologeado.type == 'managergeneral' ||
          usuariologeado.type == 'managerequipo') {
        if (taskTemp.state == 'Abierta' || taskTemp.state == 'En proceso') {
          tasks.add(taskTemp);
        }
      } else if (usuariologeado.type == 'miembroequipo') {
        if ("En proceso" == taskTemp.state &&
            taskTemp.responsables!.contains(usuariologeado.localId)) {
          tasks.add(taskTemp);
        }
      }
    });
    return tasks;
  }


  Future<List<TaskModel>> obtenerTareasFinalizadas() async {
    final usuariologeado = UserLoged();

    final url = '$_url/tasks.json';

    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<TaskModel> tasks = [];

    decodeData.forEach((id, task) {
      final taskTemp = TaskModel.fromJson(task);

      taskTemp.id = id;

      if (usuariologeado.type == 'managergeneral' ||
          usuariologeado.type == 'managerequipo') {
        if (taskTemp.state == 'Cerrada') {
          tasks.add(taskTemp);
        }
      } else if (usuariologeado.type == 'miembroequipo') {
        if ("Cerrada" == taskTemp.state &&
            taskTemp.responsables!.contains(usuariologeado.localId)) {
          tasks.add(taskTemp);
        }
      }
    });
    return tasks;
  }
}
