import 'package:flutter_test/flutter_test.dart';
import 'package:byte_bistro/models/category.dart';

void main() {
  group("Categories Model", () {
    test(
        'Giving Categories category json when calling fromJson gives Song object',
        () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      List<Map<String, dynamic>> categories = [
        {"_id": "62b4ac6a227ceafe503807b3", "name": "Momo", "__v": 0},
        {"_id": "62b4ac7b227ceafe503807b6", "name": "Chowmein", "__v": 0},
        {"_id": "62b4ac82227ceafe503807b9", "name": "Burger", "__v": 0},
        {"_id": "62b4ac88227ceafe503807bc", "name": "Pizza", "__v": 0},
        {"_id": "62c42f6fbcef5ccb83d3a3a7", "name": "Paratha", "__v": 0},
        {"_id": "62c43362bcef5ccb83d3a43c", "name": "Rara", "__v": 0},
        {"_id": "62c433d2bcef5ccb83d3a447", "name": "Alu curry", "__v": 0}
      ];

      // Act
      List<Category> categoryObjects =
          categories.map((category) => Category.fromJson(category)).toList();

      // Assert
      expect(categoryObjects.length, 7);
      expect(categoryObjects[0].name, 'Momo');
      expect(categoryObjects[1].id, '62b4ac7b227ceafe503807b6');
    });
    test('Testing if Category.fromJson works with empty json', () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      List<Map<String, dynamic>> categories = [];

      // Act
      List<Category> categoryObjects =
          categories.map((category) => Category.fromJson(category)).toList();

      // Assert
      expect(categoryObjects.length, 0);
    });
    test('Check if Category.toJson converts the Category instance to a Map Object',
        () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      Category category =
          Category(id: "62b4ac82227ceafe503807b9", name: "Burger", v: 0);

      // Act
      Map<String, dynamic> categoryJson = category.toJson();

      // Assert
      expect(categoryJson['_id'], '62b4ac82227ceafe503807b9');
      expect(categoryJson['name'], 'Burger');
      expect(categoryJson['__v'], 0);
    });
  });
}
