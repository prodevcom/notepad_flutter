import 'package:cloud_firestore/cloud_firestore.dart';

class NotePadModel {
  late String? id;
  final String title;
  final String body;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NotePadModel({
    this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.updatedAt,
  });

  set setId(String newId) => id = newId;

  factory NotePadModel.create(String title, String body) {
    return NotePadModel(
      title: title,
      body: body,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  factory NotePadModel.update(
    String title,
    String body,
    NotePadModel oldest,
  ) {
    return NotePadModel(
      id: oldest.id,
      title: title,
      body: body,
      createdAt: oldest.createdAt,
      updatedAt: DateTime.now(),
    );
  }

  factory NotePadModel.fromJson(String id, Map<String, dynamic> json) {
    var createdAt = json["createdAt"] as Timestamp;
    var updatedAt = json["updatedAt"] as Timestamp?;

    return NotePadModel(
      id: id,
      title: json["title"],
      body: json["body"],
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}
