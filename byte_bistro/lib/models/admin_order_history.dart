// To parse this JSON data, do
//
//     final adminOrderHistory = adminOrderHistoryFromJson(jsonString);

import 'dart:convert';

List<AdminOrderHistory> adminOrderHistoryFromJson(String str) => List<AdminOrderHistory>.from(json.decode(str).map((x) => AdminOrderHistory.fromJson(x)));

String adminOrderHistoryToJson(List<AdminOrderHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminOrderHistory {
    AdminOrderHistory({
        required this.id,
        required this.userId,
        required this.items,
        required this.tableId,
        required this.status,
        required this.duration,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    UserId userId;
    List<Item> items;
    int tableId;
    int status;
    int duration;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory AdminOrderHistory.fromJson(Map<String, dynamic> json) => AdminOrderHistory(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        tableId: json["tableId"],
        status: json["status"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "tableId": tableId,
        "status": status,
        "duration": duration,
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

    FoodId foodId;
    int qty;
    String id;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        foodId: FoodId.fromJson(json["foodId"]),
        qty: json["qty"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "foodId": foodId.toJson(),
        "qty": qty,
        "_id": id,
    };
}

class FoodId {
    FoodId({
        required this.id,
        required this.name,
        required this.price,
        required this.image,
        required this.isAvailable,
    });

    String id;
    String name;
    int price;
    String image;
    bool isAvailable;

    factory FoodId.fromJson(Map<String, dynamic> json) => FoodId(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        isAvailable: json["isAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "image": image,
        "isAvailable": isAvailable,
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
