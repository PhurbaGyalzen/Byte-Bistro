import 'dart:convert';

CreatedCart createdCartFromJson(String str) =>
    CreatedCart.fromJson(json.decode(str));

String createdCartToJson(CreatedCart data) => json.encode(data.toJson());

class CreatedCart {
  CreatedCart({
    required this.v,
    required this.id,
    required this.createdAt,
    required this.duration,
    required this.items,
    required this.paymentMethod,
    required this.status,
    required this.tableId,
    required this.updatedAt,
    required this.userId,
  });

  int v;
  String id;
  DateTime createdAt;
  int duration;
  List<Item> items;
  String paymentMethod;
  int status;
  int tableId;
  DateTime updatedAt;
  String userId;

  factory CreatedCart.fromJson(Map<String, dynamic> json) => CreatedCart(
        v: json["__v"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        duration: json["duration"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        paymentMethod: json["paymentMethod"],
        status: json["status"],
        tableId: json["tableId"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "__v": v,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "duration": duration,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "paymentMethod": paymentMethod,
        "status": status,
        "tableId": tableId,
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
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
