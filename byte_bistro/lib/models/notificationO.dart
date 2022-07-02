// To parse this JSON data, do
//
//     final notificationO = notificationOFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<NotificationO> notificationOFromJson(String str) =>
    List<NotificationO>.from(
        json.decode(str).map((x) => NotificationO.fromJson(x)));

String notificationOToJson(List<NotificationO> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationO {
  NotificationO({
    required this.userId,
    required this.id,
    required this.title,
    required this.message,
    required this.read,
    required this.isOffer,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  dynamic userId;
  String id;
  String title;
  String message;
  bool read;
  bool isOffer;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory NotificationO.fromJson(Map<String, dynamic> json) => NotificationO(
        userId: json["userId"],
        id: json["_id"],
        title: json["title"],
        message: json["message"],
        read: json["read"],
        isOffer: json["isOffer"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "_id": id,
        "title": title,
        "message": message,
        "read": read,
        "isOffer": isOffer,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
