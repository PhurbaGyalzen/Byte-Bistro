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

String indCart = '''
{
        "status": 0,
        "duration": 25,
        "_id": "62bd77e292a41fc8ce5428a4",
        "userId": {
            "_id": "627fbfa1d464ffbeb80b985b",
            "fullname": "Sanjib Limbu Updated"
        },
        "items": [
            {
                "foodId": {
                    "_id": "62b608c2cc64bcda1bbfc313",
                    "name": "Chowmein",
                    "price": 120,
                    "image": "images/1656096958618-image_picker1125605492.jpg",
                    "isAvailable": true
                },
                "qty": 2,
                "_id": "62bd77e292a41fc8ce5428a5"
            }
        ],
        "tableId": 9,
        "createdAt": "2022-06-30T10:16:02.200Z",
        "updatedAt": "2022-06-30T10:16:02.200Z",
        "__v": 0
    }
''';
// String lCarts = '[' + indCart + ']';

String lCarts = '''
[
  {
    "_id":"628d04284aeaa390fb4d0013",
    "userId": {
      "_id":"627fbfa1d464ffbeb80b985b",
      "fullname": "limbu"
    },
    "items":[
      {"foodId":"628b791788b361630f91205f","qty":3,"_id":"628d04284aeaa390fb4d0014"}
    ],
    "tableId":7,
    "createdAt":"2022-05-24T16:13:28.124Z",
    "updatedAt":"2022-05-24T16:13:28.124Z",
    "__v":0
  }
]
''';

String ind =
    '{"_id":"628d04284aeaa390fb4d0013","userId": {"_id":"627fbfa1d464ffbeb80b985b", "fullname": "limbu"},"items":[{"foodId":"628b791788b361630f91205f","qty":3,"_id":"628d04284aeaa390fb4d0014"}],"tableId":7,"createdAt":"2022-05-24T16:13:28.124Z","updatedAt":"2022-05-24T16:13:28.124Z","__v":0}';

void main() {
  // Cart cart = cartFromJson(indCart);
  // for (int i=0; i<)
  // var carts = json.decode(lCarts).map((x) {
  //   // print(x.runtimeType);
  //   // print(json.decode(x));
  //   print('dg');
  //   return x;
  // });
  // print(json.decode(indCart));
  // print(Cart.fromJson(json.decode(indCart)));
  // print(json.decode(lCarts).runtimeType);
  // print(json.decode(lCarts).map((x) {
  //   print(x);
  //   print(x.runtimeType);
  //   // print(json.decode(x));
  //   print(Cart.fromJson(x));
  // }));
  // print(List<Cart>.from(json.decode(lCarts).map((x) => Cart.fromJson(x))));
  // print(carts);
}
