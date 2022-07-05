import 'package:flutter_test/flutter_test.dart';
import 'package:byte_bistro/models/Cart.dart';

void main() {
  group("Carts Model", () {
    test('Giving Carts Cart json when calling fromJson gives Song object',
        () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      List<Map<String, dynamic>> carts = [
        {
          "_id": "62c17e73e821bf46030e38fa",
          "userId": {
            "_id": "627fbfa1d464ffbeb80b985b",
            "fullname": "Sanjib Limbu Updated"
          },
          "items": [
            {
              "foodId": {
                "_id": "62c172bae821bf46030e36f7",
                "name": "Momo Piro xa",
                "price": 200,
                "image": "images/1656844985391-image_picker230561552.jpg",
                "isAvailable": true
              },
              "qty": 1,
              "_id": "62c17e73e821bf46030e38fb"
            }
          ],
          "tableId": 7,
          "status": 0,
          "duration": 25,
          "createdAt": "2022-07-03T11:33:07.616Z",
          "updatedAt": "2022-07-03T12:26:33.727Z",
          "__v": 0
        },
        {
          "_id": "62c17e7ee821bf46030e390f",
          "userId": {
            "_id": "627fbfa1d464ffbeb80b985b",
            "fullname": "Sanjib Limbu Updated"
          },
          "items": [
            {
              "foodId": {
                "_id": "62c172bae821bf46030e36f7",
                "name": "Momo Piro xa",
                "price": 200,
                "image": "images/1656844985391-image_picker230561552.jpg",
                "isAvailable": true
              },
              "qty": 1,
              "_id": "62c17e7ee821bf46030e3910"
            },
            {
              "foodId": {
                "_id": "62c1736ce821bf46030e3718",
                "name": "Chowmein",
                "price": 200,
                "image": "images/1656845162427-image_picker1798307226.jpg",
                "isAvailable": false
              },
              "qty": 1,
              "_id": "62c17e7ee821bf46030e3911"
            }
          ],
          "tableId": 7,
          "status": 1,
          "duration": 25,
          "createdAt": "2022-07-03T11:33:18.252Z",
          "updatedAt": "2022-07-05T04:15:33.911Z",
          "__v": 0
        },
        {
          "_id": "62c41bb3bcef5ccb83d39b8a",
          "userId": {
            "_id": "627fbfa1d464ffbeb80b985b",
            "fullname": "Sanjib Limbu Updated"
          },
          "items": [
            {
              "foodId": {
                "_id": "62c172bae821bf46030e36f7",
                "name": "Momo Piro xa",
                "price": 200,
                "image": "images/1656844985391-image_picker230561552.jpg",
                "isAvailable": true
              },
              "qty": 1,
              "_id": "62c41bb3bcef5ccb83d39b8b"
            },
            {
              "foodId": {
                "_id": "62c1736ce821bf46030e3718",
                "name": "Chowmein",
                "price": 200,
                "image": "images/1656845162427-image_picker1798307226.jpg",
                "isAvailable": false
              },
              "qty": 3,
              "_id": "62c41bb3bcef5ccb83d39b8c"
            }
          ],
          "tableId": 7,
          "status": 0,
          "duration": 25,
          "createdAt": "2022-07-05T11:08:35.892Z",
          "updatedAt": "2022-07-05T11:08:35.892Z",
          "__v": 0
        },
      ];

      // Act
      List<Cart> cartObjects =
          carts.map((cart) => Cart.fromJson(cart)).toList();

      // Assert
      expect(cartObjects.length, 3);
      expect(cartObjects[0].userId.fullname, 'Sanjib Limbu Updated');
      expect(cartObjects[1].id, '62c17e7ee821bf46030e390f');
    });
    test('Testing if Cart.fromJson works with empty json', () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      List<Map<String, dynamic>> carts = [];

      // Act
      List<Cart> cartObjects =
          carts.map((cart) => Cart.fromJson(cart)).toList();

      // Assert
      expect(cartObjects.length, 0);
    });
    test('Check if Cart.toJson converts the Cart instance to a Map Object',
        () async {
      // ignore: todo
      // TODO: Implement

      // Arrange
      Cart cart = Cart(
          id: "62c17e73e821bf46030e38fa",
          userId: UserId.fromJson({
            "_id": "627fbfa1d464ffbeb80b985b",
            "fullname": "Sanjib Limbu Updated"
          }),
          items: [
            Item.fromJson({
              "foodId": {
                "_id": "62c172bae821bf46030e36f7",
                "name": "Momo Piro xa",
                "price": 200,
                "image": "images/1656844985391-image_picker230561552.jpg",
                "isAvailable": true
              },
              "qty": 1,
              "_id": "62c17e73e821bf46030e38fb"
            })
          ],
          tableId: 7,
          status: 0,
          duration: 25,
          createdAt: DateTime.parse("2022-07-03T11:33:07.616Z"),
          updatedAt: DateTime.parse("2022-07-03T12:26:33.727Z"),
          v: 0);

      // Act
      Map<String, dynamic> cartJson = cart.toJson();

      // Assert
      expect(cartJson['_id'], '62c17e73e821bf46030e38fa');
      expect(cartJson['userId']['fullname'], 'Sanjib Limbu Updated');
      expect(cartJson['__v'], 0);
    });
  });
}
