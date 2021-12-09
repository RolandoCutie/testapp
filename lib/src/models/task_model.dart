// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

import 'package:testapp/src/models/user_model.dart';

enum EnumType { onat, inventario, alquiler, compraproducto, transporte }
enum EnumProyect { proyecto1, proyecto2, proyeto3, proyecto4 }
enum EnumState { nueva, abierta, enproceso, cerrada }

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  String? id;
  String title;
  String description;
  String? type;
  DateTime? date;
  List<String>? responsables;
  String? autor;
  String state;
  String? proyect;

  TaskModel({
    this.id,
    this.title = '',
    this.description = '',
    this.type,
    this.date,
    this.responsables,
    this.autor,
    this.state = '',
    this.proyect,
  });

   factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        type: json["type"] == null ? null : json["type"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        responsables: json["responsables"] == null
            ? null
            : List<String>.from(json["responsables"].map((x) => x)),
        autor: json["autor"] == null ? null : json["autor"],
        state: json["state"] == null ? null : json["state"],
        proyect: json["proyect"] == null ? null : json["proyect"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "title": title,
        "description": description,
        "type": type,
        "date": date!.toIso8601String(),
        "responsables": List<String>.from(responsables!.map((x) => x)),
        "autor": autor,
        "state": state,
        "proyect": proyect,
      };
}
