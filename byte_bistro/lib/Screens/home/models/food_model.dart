// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

List<Food> foodFromJson(String str) =>
    List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
  Food({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.categories,
    required this.isAvailable,
    required this.ingredients,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String name;
  int price;
  String description;
  String image;
  List<dynamic> categories;
  bool isAvailable;
  List<dynamic> ingredients;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        image: json["image"],
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
        isAvailable: json["isAvailable"],
        ingredients: List<dynamic>.from(json["ingredients"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "description": description,
        "image": image,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "isAvailable": isAvailable,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
