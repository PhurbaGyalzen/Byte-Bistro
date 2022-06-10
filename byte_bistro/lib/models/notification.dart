// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Notification> notificationFromJson(String str) => List<Notification>.from(
    json.decode(str).map((x) => Notification.fromJson(x)));

String notificationToJson(List<Notification> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notification {
  Notification({
    required this.id,
    required this.userId,
    required this.message,
    required this.read,
    required this.type,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  UserId userId;
  String message;
  bool read;
  String type;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        message: json["message"],
        read: json["read"],
        type: json["type"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "message": message,
        "read": read,
        "type": type,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class UserId {
  UserId({
    required this.id,
    required this.fullname,
  });

  String id;
  String fullname;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullname": fullname,
      };
}
