// To parse this JSON data, do
//
//     final loggedUserInfo = loggedUserInfoFromJson(jsonString);

import 'dart:convert';

LoggedUserInfo loggedUserInfoFromJson(String str) => LoggedUserInfo.fromJson(json.decode(str));

String loggedUserInfoToJson(LoggedUserInfo data) => json.encode(data.toJson());

class LoggedUserInfo {
    LoggedUserInfo({
        required this.profile,
        required this.id,
        required this.username,
        required this.passwordHash,
        required this.email,
        required this.fullname,
        required this.phones,
        required this.bio,
        required this.isAdmin,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.address,
        required this.favoriteFoods,
    });

    String profile;
    String id;
    String username;
    String passwordHash;
    String email;
    String fullname;
    List<dynamic> phones;
    String bio;
    bool isAdmin;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String address;
    List<String> favoriteFoods;

    factory LoggedUserInfo.fromJson(Map<String, dynamic> json) => LoggedUserInfo(
        profile: json["profile"],
        id: json["_id"],
        username: json["username"],
        passwordHash: json["passwordHash"],
        email: json["email"],
        fullname: json["fullname"],
        phones: List<dynamic>.from(json["phones"].map((x) => x)),
        bio: json["bio"],
        isAdmin: json["isAdmin"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        address: json["address"],
        favoriteFoods: List<String>.from(json["favoriteFoods"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "profile": profile,
        "_id": id,
        "username": username,
        "passwordHash": passwordHash,
        "email": email,
        "fullname": fullname,
        "phones": List<dynamic>.from(phones.map((x) => x)),
        "bio": bio,
        "isAdmin": isAdmin,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "address": address,
        "favoriteFoods": List<dynamic>.from(favoriteFoods.map((x) => x)),
    };
}
