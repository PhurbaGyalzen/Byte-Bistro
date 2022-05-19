// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

Food foodFromJson(String str) => Food.fromJson(json.decode(str));

String foodToJson(Food data) => json.encode(data.toJson());

class Food {
  Food({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.categories,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.ingredients,
    required this.isAvailable,
  });

  List<dynamic> categories;
  String id;
  String name;
  String description;
  int price;
  String image;
  String category;
  List<String> ingredients;
  bool isAvailable;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
        category: json["category"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        isAvailable: json["isAvailable"],
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "_id": id,
        "name": name,
        "description": description,
        "price": price,
        "image": image,
        "category": category,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "isAvailable": isAvailable,
      };
}
