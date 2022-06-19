// To parse this JSON data, do
//
//     final favourite = favouriteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Favourite> favouriteFromJson(String str) => List<Favourite>.from(json.decode(str).map((x) => Favourite.fromJson(x)));

String favouriteToJson(List<Favourite> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favourite {
    Favourite({
        required this.id,
        required this.userId,
        required this.foodId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    UserId userId;
    FoodId foodId;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        foodId: FoodId.fromJson(json["foodId"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "foodId": foodId.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class FoodId {
    FoodId({
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

    factory FoodId.fromJson(Map<String, dynamic> json) => FoodId(
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

class UserId {
    UserId({
        required this.id,
        required this.favoriteFoods,
    });

    String id;
    List<String> favoriteFoods;

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        favoriteFoods: List<String>.from(json["favoriteFoods"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "favoriteFoods": List<dynamic>.from(favoriteFoods.map((x) => x)),
    };
}
