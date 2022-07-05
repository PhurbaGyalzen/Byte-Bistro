import 'package:flutter_test/flutter_test.dart';
import 'package:byte_bistro/models/Favourite.dart';

void main() {
  group("Categories Model", () {
    test(
        'Giving Categories Favourite json when calling fromJson gives Song object',
        () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      List<Map<String, dynamic>> categories = [
        {
          "_id": "62c44b4569185754cbb0b494",
          "userId": {
            "_id": "627fbfa1d464ffbeb80b985b",
            "favoriteFoods": [
              "62aee6eb5c7583886d8ae4f9",
              "62b1bc7f32bf72d6edfa4498",
              "62b1be4232bf72d6edfa44ad",
              "62b1bdb632bf72d6edfa44aa",
              "62b4ab75227ceafe50380789",
              "62b608c2cc64bcda1bbfc313",
              "62b60924cc64bcda1bbfc31f",
              "62bc7d1c5d5f90b2cc7b8c84",
              "62c173a9e821bf46030e372d",
              "62c172bae821bf46030e36f7"
            ]
          },
          "foodId": {
            "_id": "62c173a9e821bf46030e372d",
            "name": "Burger",
            "price": 300,
            "description": "Burger",
            "image": "images/1656845224148-image_picker339903063.jpg",
            "categories": ["62b4ac82227ceafe503807b9"],
            "isAvailable": true,
            "ingredients": [],
            "createdAt": "2022-07-03T10:47:05.787Z",
            "updatedAt": "2022-07-05T14:28:10.033Z",
            "__v": 0
          },
          "createdAt": "2022-07-05T14:31:33.335Z",
          "updatedAt": "2022-07-05T14:31:33.335Z",
          "__v": 0
        },
        {
          "_id": "62c44b5569185754cbb0b4b7",
          "userId": {
            "_id": "627fbfa1d464ffbeb80b985b",
            "favoriteFoods": [
              "62aee6eb5c7583886d8ae4f9",
              "62b1bc7f32bf72d6edfa4498",
              "62b1be4232bf72d6edfa44ad",
              "62b1bdb632bf72d6edfa44aa",
              "62b4ab75227ceafe50380789",
              "62b608c2cc64bcda1bbfc313",
              "62b60924cc64bcda1bbfc31f",
              "62bc7d1c5d5f90b2cc7b8c84",
              "62c173a9e821bf46030e372d",
              "62c172bae821bf46030e36f7"
            ]
          },
          "foodId": {
            "_id": "62c172bae821bf46030e36f7",
            "name": "Momo Piro xa",
            "price": 200,
            "description": "Momo ma buff mitho hunxa ",
            "image": "images/1656844985391-image_picker230561552.jpg",
            "categories": ["62b4ac6a227ceafe503807b3"],
            "isAvailable": true,
            "ingredients": [],
            "createdAt": "2022-07-03T10:43:06.250Z",
            "updatedAt": "2022-07-05T14:29:02.665Z",
            "__v": 0
          },
          "createdAt": "2022-07-05T14:31:49.473Z",
          "updatedAt": "2022-07-05T14:31:49.473Z",
          "__v": 0
        }
      ];

      // Act
      List<Favourite> favouriteObjects =
          categories.map((favourite) => Favourite.fromJson(favourite)).toList();

      // Assert
      expect(favouriteObjects.length, 2);
      expect(favouriteObjects[0].foodId.name, 'Burger');
      expect(favouriteObjects[1].id, '62c44b5569185754cbb0b4b7');
    });
    test('Testing if Favourite.fromJson works with empty json', () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      List<Map<String, dynamic>> categories = [];

      // Act
      List<Favourite> favouriteObjects =
          categories.map((favourite) => Favourite.fromJson(favourite)).toList();

      // Assert
      expect(favouriteObjects.length, 0);
    });
    // test(
    //     'Check if Favourite.toJson converts the Favourite instance to a Map Object',
    //     () async {
    //   // ignore: todo
    //   // TODO: Implement

    //   // Arrange
    //   Favourite favourite = Favourite(
    //       id: "62c44b4569185754cbb0b494",
    //       userId: UserId.fromJson(
    //         {
    //           "_id": "627fbfa1d464ffbeb80b985b",
    //           "favoriteFoods": [
    //             "62aee6eb5c7583886d8ae4f9",
    //             "62b1bc7f32bf72d6edfa4498",
    //             "62b1be4232bf72d6edfa44ad",
    //             "62b1bdb632bf72d6edfa44aa",
    //             "62b4ab75227ceafe50380789",
    //             "62b608c2cc64bcda1bbfc313",
    //             "62b60924cc64bcda1bbfc31f",
    //             "62bc7d1c5d5f90b2cc7b8c84",
    //             "62c173a9e821bf46030e372d",
    //             "62c172bae821bf46030e36f7"
    //           ]
    //         },
    //       ),
    //       foodId: FoodId.fromJson(
    //         {
    //           "_id": "62c172bae821bf46030e36f7",
    //           "name": "Momo Piro xa",
    //           "price": 200,
    //           "description": "Momo ma buff mitho hunxa ",
    //           "image": "images/1656844985391-image_picker230561552.jpg",
    //           "categories": ["62b4ac6a227ceafe503807b3"],
    //           "isAvailable": true,
    //           "ingredients": [],
    //           "createdAt": "2022-07-03T10:43:06.250Z",
    //           "updatedAt": "2022-07-05T14:29:02.665Z",
    //           "__v": 0
    //         },
    //       ),
    //       createdAt: DateTime.parse("2022-07-05T14:31:33.335Z"),
    //       updatedAt: DateTime.parse("2022-07-05T14:31:33.335Z"),
    //       v: 0);

    //   // Act
    //   Map<String, dynamic> favouriteJson = favourite.toJson();

    //   // Assert
    //   expect(favouriteJson['_id'], '627fbfa1d464ffbeb80b985b');
    //   expect(favouriteJson['foodId']['name'], 'Momo Piro xa');
    //   expect(favouriteJson['__v'], 0);
    // });
  });
}
