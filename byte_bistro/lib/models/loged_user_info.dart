// To parse this JSON data, do
//
//     final loggedUserInfo = loggedUserInfoFromJson(jsonString);

import 'dart:convert';

LoggedUserInfo loggedUserInfoFromJson(String str) => LoggedUserInfo.fromJson(json.decode(str));

String loggedUserInfoToJson(LoggedUserInfo data) => json.encode(data.toJson());

class LoggedUserInfo {
    LoggedUserInfo({
        required this.favoriteFoods,
        required this.id,
        required this.username,
        required this.passwordHash,
        required this.email,
        required this.fullname,
        required this.phones,
        required this.bio,
        required this.address,
        required this.isAdmin,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    List<dynamic> favoriteFoods;
    String id;
    String username;
    String passwordHash;
    String email;
    String address;
    String fullname;
    List<dynamic> phones;
    String bio;
    bool isAdmin;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory LoggedUserInfo.fromJson(Map<String, dynamic> json) => LoggedUserInfo(
        favoriteFoods: List<dynamic>.from(json["favoriteFoods"].map((x) => x)),
        id: json["_id"],
        username: json["username"],
        address: json["address"],
        passwordHash: json["passwordHash"],
        email: json["email"],
        fullname: json["fullname"],
        phones: List<dynamic>.from(json["phones"].map((x) => x)),
        bio: json["bio"],
        isAdmin: json["isAdmin"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "favoriteFoods": List<dynamic>.from(favoriteFoods.map((x) => x)),
        "_id": id,
        "username": username,
        "passwordHash": passwordHash,
        "email": email,
        "address": address,
        "fullname": fullname,
        "phones": List<dynamic>.from(phones.map((x) => x)),
        "bio": bio,
        "isAdmin": isAdmin,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
