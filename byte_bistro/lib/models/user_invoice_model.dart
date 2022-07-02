// To parse this JSON data, doUserInvoiceModel
//
//     final userInvoiceModel = userInvoiceModelFromJson(jsonString);

import 'dart:convert';

List<UserInvoiceModel> userInvoiceModelFromJson(String str) => List<UserInvoiceModel>.from(json.decode(str).map((x) => UserInvoiceModel.fromJson(x)));

String userInvoiceModelToJson(List<UserInvoiceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserInvoiceModel {
    UserInvoiceModel({
        required this.id,
       required this.userId,
        required  this.items,
        required this.tableId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    String id;
    UserId? userId;
    List<Item> items;
    int tableId;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory UserInvoiceModel.fromJson(Map<String, dynamic> json) => UserInvoiceModel(
        id: json["_id"],
        userId: userIdValues.map[json["userId"]],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        tableId: json["tableId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userIdValues.reverse[userId],
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

    Id? id;
    Name? name;
    int price;
    Image? image;
    bool isAvailable;

    factory FoodId.fromJson(Map<String, dynamic> json) => FoodId(
        id: idValues.map[json["_id"]],
        name: nameValues.map[json["name"]],
        price: json["price"],
        image: imageValues.map[json["image"]],
        isAvailable: json["isAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "_id": idValues.reverse[id],
        "name": nameValues.reverse[name],
        "price": price,
        "image": imageValues.reverse[image],
        "isAvailable": isAvailable,
    };
}

enum Id { THE_62_B608_C2_CC64_BCDA1_BBFC313, THE_62_BC7_D1_C5_D5_F90_B2_CC7_B8_C84, THE_62_B60924_CC64_BCDA1_BBFC31_F }

final idValues = EnumValues({
    "62b608c2cc64bcda1bbfc313": Id.THE_62_B608_C2_CC64_BCDA1_BBFC313,
    "62b60924cc64bcda1bbfc31f": Id.THE_62_B60924_CC64_BCDA1_BBFC31_F,
    "62bc7d1c5d5f90b2cc7b8c84": Id.THE_62_BC7_D1_C5_D5_F90_B2_CC7_B8_C84
});

enum Image { IMAGES_1656096958618_IMAGE_PICKER1125605492_JPG, IMAGES_1656519962757_IMAGE_PICKER1445710890_JPG, IMAGES_1656097057463_IMAGE_PICKER914129604_JPG }

final imageValues = EnumValues({
    "images/1656096958618-image_picker1125605492.jpg": Image.IMAGES_1656096958618_IMAGE_PICKER1125605492_JPG,
    "images/1656097057463-image_picker914129604.jpg": Image.IMAGES_1656097057463_IMAGE_PICKER914129604_JPG,
    "images/1656519962757-image_picker1445710890.jpg": Image.IMAGES_1656519962757_IMAGE_PICKER1445710890_JPG
});

enum Name { CHOWMEIN, BURGER, MOMO }

final nameValues = EnumValues({
    "Burger": Name.BURGER,
    "Chowmein": Name.CHOWMEIN,
    "Momo": Name.MOMO
});

enum UserId { THE_627_FBFA1_D464_FFBEB80_B985_B }

final userIdValues = EnumValues({
    "627fbfa1d464ffbeb80b985b": UserId.THE_627_FBFA1_D464_FFBEB80_B985_B
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
