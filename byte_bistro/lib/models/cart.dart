// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    required this.id,
    required this.userId,
    required this.items,
    required this.tableId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String userId;
  List<Item> items;
  int tableId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        userId: json["userId"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        tableId: json["tableId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "tableId": tableId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Item {
  Item({
    required this.foodId,
    required this.qty,
    required this.id,
  });

  String foodId;
  int qty;
  String id;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        foodId: json["foodId"],
        qty: json["qty"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "foodId": foodId,
        "qty": qty,
        "_id": id,
      };
}
