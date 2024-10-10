import 'package:flutter_app/core/utiles.dart';

class  TaskModel {
  static const String collectionName ="TaskModel";
  String? id;
  String title;
  String description;
  DateTime selectedData;
  bool isDone;

  TaskModel({
     this.id,
    required this.title,
    required this.description,
    required this.selectedData,
     this.isDone = false,

  });

  factory TaskModel.firestore(Map<String, dynamic> json)=> TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        selectedData: DateTime.fromMicrosecondsSinceEpoch(json["selectedData"]),
        isDone: json["isDone"].tolowerCase()=='true',
      );


  Map<String, dynamic> tofirestore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "selectData":  extractDate(selectedData).millisecondsSinceEpoch,
      "isDone": isDone,
    };
  }
}


