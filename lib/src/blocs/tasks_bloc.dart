import 'package:rxdart/rxdart.dart';
import 'package:testapp/src/models/task_model.dart';
import 'package:testapp/src/providers/task_provider.dart';

class TaskBloc {
  final _taskController = BehaviorSubject<List<TaskModel>>();
  final _loadingController = BehaviorSubject<bool>();

  final _taskProvider = TasksProviders();

  Stream<List<TaskModel>> get taskStream => _taskController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;

  void cargarTasksNuevas() async {
    _taskController.drain();
    final tasks = await _taskProvider.obtenerTareasNuevas();
    _taskController.sink.add(tasks);
    _taskController.drain();
  }

  void cargarTasksPendientes() async {
    final tasks = await _taskProvider.obtenerTareasPendientes();

    _taskController.sink.add(tasks);
  }

  void cargarTasksFinalizadas() async {
    final tasks = await _taskProvider.obtenerTareasFinalizadas();

    _taskController.drain();
    _taskController.sink.add(tasks);
    _taskController.drain();
  }

  void agregarTasks(TaskModel model) async {
    _loadingController.sink.add(true);
    await _taskProvider.createTask(model);
    _loadingController.sink.add(false);
  }

  void editarTasks(TaskModel model) async {
    _loadingController.sink.add(true);
    await _taskProvider.editTask(model);
    _loadingController.sink.add(false);
  }

  dispose() {
    _taskController.close();
    _loadingController.close();
  }
}
