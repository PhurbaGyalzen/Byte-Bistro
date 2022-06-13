// To parse this JSON data, do
//
//     final notificationl = notificationlFromJson(jsonString);

import 'dart:convert';

List<Notificationl> notificationlFromJson(String str) =>
    List<Notificationl>.from(
        json.decode(str).map((x) => Notificationl.fromJson(x)));

String notificationlToJson(List<Notificationl> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notificationl {
  Notificationl({
    required this.id,
    required this.userId,
    required this.message,
    required this.read,
    required this.isOffer,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  UserId userId;
  String message;
  bool read;
  bool isOffer;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Notificationl.fromJson(Map<String, dynamic> json) => Notificationl(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        message: json["message"],
        read: json["read"],
        isOffer: json["isOffer"],
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
        "isOffer": isOffer,
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
