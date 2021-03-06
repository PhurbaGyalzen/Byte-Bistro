import 'dart:convert';

enum CartStatus {
  Pending,
  Preping,
  Ready,
  Completed,
}

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
    required this.status,
    required this.duration,
  });

  String id;
  UserId userId;
  List<Item> items;
  int tableId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int status;
  int duration;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        tableId: json["tableId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        status: json['status'],
        duration: json['duration'],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "tableId": tableId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        'status': status,
        'duration': duration,
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

Cart predefinedFalsyCartModel = cartFromJson('''
{
        "status": 0,
        "duration": 0,
        "_id": "",
        "userId": {
            "_id": "",
            "fullname": ""
        },
        "items": [
            {
                "foodId": {
                    "_id": "",
                    "name": "",
                    "price": 0,
                    "image": "",
                    "isAvailable": false
                },
                "qty": 0,
                "_id": ""
            }
        ],
        "tableId": 0,
        "createdAt": "2022-06-30T10:16:02.200Z",
        "updatedAt": "2022-06-30T10:16:02.200Z",
        "__v": 0
    }
''');
