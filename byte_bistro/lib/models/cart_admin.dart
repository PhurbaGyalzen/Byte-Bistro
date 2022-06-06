// To parse this JSON data, do
//
//     final cartAdmin = cartAdminFromJson(jsonString);

import 'dart:convert';

List<CartAdmin> cartAdminFromJson(String str) => List<CartAdmin>.from(json.decode(str).map((x) => CartAdmin.fromJson(x)));

String cartAdminToJson(List<CartAdmin> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartAdmin {
    CartAdmin({
        required this.id,
        required this.userId,
        required this.items,
        required this.tableId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    UserId userId;
    List<Item> items;
    int tableId;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory CartAdmin.fromJson(Map<String, dynamic> json) => CartAdmin(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        tableId: json["tableId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
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

    dynamic foodId;
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
