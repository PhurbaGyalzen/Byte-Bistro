// To parse this JSON data, do
//
//     final userInvoiceModel = userInvoiceModelFromJson(jsonString);

import 'dart:convert';

List<UserInvoiceModel> userInvoiceModelFromJson(String str) => List<UserInvoiceModel>.from(json.decode(str).map((x) => UserInvoiceModel.fromJson(x)));

String userInvoiceModelToJson(List<UserInvoiceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserInvoiceModel {
    UserInvoiceModel({
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
    String userId;
    List<Item> items;
    int tableId;
    int status;
    int duration;
    String createdAt;
    String updatedAt;
    int v;

    factory UserInvoiceModel.fromJson(Map<String, dynamic> json) => UserInvoiceModel(
        id: json["_id"],
        userId: json["userId"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        tableId: json["tableId"],
        status: json["status"],
        duration: json["duration"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "tableId": tableId,
        "status": status,
        "duration": duration,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
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
