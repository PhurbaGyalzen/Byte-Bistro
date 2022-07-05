import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:byte_bistro/Screens/home/models/food_model.dart';

void main() {
  group("Food Model", () {
    test('Giving Food Food json when calling fromJson gives  object', () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      List<Map<String, dynamic>> foods = [
        {
          "_id": "62c172bae821bf46030e36f7",
          "name": "Momo Piro xa",
          "price": 200,
          "description": "Momo ma buff mitho hunxa ",
          "image": "images/1656844985391-image_picker230561552.jpg",
          "categories": [
            {"_id": "62b4ac6a227ceafe503807b3", "name": "Momo", "__v": 0}
          ],
          "isAvailable": true,
          "ingredients": [],
          "createdAt": "2022-07-03T10:43:06.250Z",
          "updatedAt": "2022-07-05T14:29:02.665Z",
          "__v": 0
        },
        {
          "_id": "62c1736ce821bf46030e3718",
          "name": "Chowmein",
          "price": 200,
          "description": "Chowmein",
          "image": "images/1656845162427-image_picker1798307226.jpg",
          "categories": [
            {"_id": "62b4ac7b227ceafe503807b6", "name": "Chowmein", "__v": 0}
          ],
          "isAvailable": false,
          "ingredients": [],
          "createdAt": "2022-07-03T10:46:04.075Z",
          "updatedAt": "2022-07-05T14:28:16.780Z",
          "__v": 0
        },
      ];

      // Act
      List<Food> foodObjects =
          foods.map((food) => Food.fromJson(food)).toList();

      // Assert
      expect(foodObjects.length, 2);
      expect(foodObjects[0].name, 'Momo Piro xa');
      expect(foodObjects[1].price, 200);
    });
    test('Testing if Food.fromJson works with empty json', () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      List<Map<String, dynamic>> foods = [];

      // Act
      List<Food> foodObjects =
          foods.map((food) => Food.fromJson(food)).toList();

      // Assert
      expect(foodObjects.length, 0);
    });
    test('Check if Food.toJson converts the Song instance to a Map Object',
        () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      Food food = Food(
          id: "62c172bae821bf46030e36f7",
          name: "Momo Piro xa",
          price: 200,
          description: "Momo ma buff mitho hunxa ",
          image: "images/1656844985391-image_picker230561552.jpg",
          categories: [
            Category.fromJson(
              {"_id": "62b4ac6a227ceafe503807b3", "name": "Momo", "__v": 0},
            )
          ],
          isAvailable: true,
          ingredients: [],
          createdAt: DateTime.parse("2022-07-03T10:43:06.250Z"),
          updatedAt: DateTime.parse("2022-07-05T14:29:02.665Z"),
          v: 0);

      // Act
      Map<String, dynamic> foodJson = food.toJson();

      // Assert
      expect(foodJson['_id'], '62c172bae821bf46030e36f7');
      expect(foodJson['name'], 'Momo Piro xa');
      expect(foodJson['__v'], 0);
    });
  });
}
