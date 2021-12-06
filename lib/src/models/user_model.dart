// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String name;
  String email;
  String type;
  String localId;

  UserModel({
    this.id,
    this.name = 'd',
    this.type = 'd',
    this.localId = 'd',
    this.email = 'd',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        localId: json["localId"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "localId": localId,
        "email": email,
      };

  getString(String s) {}

  getNombre(String s) {
    return name;
  }

  void setNombre(String s, String value) {
    name = value;
  }

  getType(String s) {

    return type;
  }

  getLocalId(String s) {

    return localId;
  }

  
}
