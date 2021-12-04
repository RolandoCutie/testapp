import 'dart:convert';

import 'package:testapp/src/models/user_model.dart';

//TaskState taskModelFromJson(String str) => TaskState.fromJson(json.decode(str));

//String taskModelToJson(TaskState data) => json.encode(data.toJson());
enum ViewState { loading, completed, failed }

class TaskState {
  
  List<String>? title;
  ViewState state;

  TaskState({
    
    this.title,
    this.state = ViewState.completed,
    
  });
}
