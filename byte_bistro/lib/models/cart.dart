// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

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

// var cartData = '''{
//     "_id": "628d04284aeaa390fb4d0013",
//     "userId": "627fbfa1d464ffbeb80b985b",
//     "items": [
//         {
//             "foodId": {
//                 "_id": "628b791788b361630f91205f",
//                 "name": "momo piro xa",
//                 "price": 250,
//                 "image": "https://images.unsplash.com/photo-1626776876758-b49742918522?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=960",
//                 "isAvailable": true
//             },
//             "qty": 3,
//             "_id": "628d04284aeaa390fb4d0014"
//         }
//     ],
//     "tableId": 7,
//     "createdAt": "2022-05-24T16:13:28.124Z",
//     "updatedAt": "2022-05-24T16:13:28.124Z",
//     "__v": 0
// }''';

// var adminData = '''
// [
//     {
//         "_id": "628d04284aeaa390fb4d0013",
//         "userId": "627fbfa1d464ffbeb80b985b",
//         "items": [
//             {
//                 "foodId": "628b791788b361630f91205f",
//                 "qty": 3,
//                 "_id": "628d04284aeaa390fb4d0014"
//             }
//         ],
//         "tableId": 7,
//         "createdAt": "2022-05-24T16:13:28.124Z",
//         "updatedAt": "2022-05-24T16:13:28.124Z",
//         "__v": 0
//     }
// ]''';

// void main() {
//   // Cart res = cartFromJson(cartData);
//   // print(res);
//   List<dynamic> js = (jsonDecode(adminData));
//   // print(js.runtimeType);
//   var carts = json.decode(adminData).map((x) {
//     print(x.runtimeType);
//     // return Cart.fromJson(x)
//   });
//   print(carts);
// }
