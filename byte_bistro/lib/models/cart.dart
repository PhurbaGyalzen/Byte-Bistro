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
/* 
String indCart = '''
{
  "_id": "628cc6fb620fe24d3929b7d2",
  "userId": "627fd5dd52fdb37643db330c",
  "items": [
    {
      "foodId": {
        "_id": "628bb15477df225b15e71a6f",
        "name": "Pizza",
        "price": 700,
        "image": "https://www.tasteofhome.com/wp-content/uploads/2018/01/exps14079_SD14079D12_18_2bC_RMS-1-696x696.jpg",
        "isAvailable": true
      },
      "qty": 2,
      "_id": "628cc6fb620fe24d3929b7d3"
    }
  ],
  "tableId": 7,
  "createdAt": "2022-05-24T11:52:27.585Z",
  "updatedAt": "2022-05-24T13:15:37.268Z",
  "__v": 0
}
''';

String lCarts = '[' + indCart + ']';

void main() {
  // Cart cart = cartFromJson(indCart);
  List<Cart> carts =
      List<Cart>.from(json.decode(lCarts).map((x) => Cart.fromJson(x)));
  print(carts);
} */
