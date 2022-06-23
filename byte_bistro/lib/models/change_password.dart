// To parse this JSON data, do
//
//     final changePassword = changePasswordFromJson(jsonString);

import 'dart:convert';

ChangePassword changePasswordFromJson(String str) => ChangePassword.fromJson(json.decode(str));

String changePasswordToJson(ChangePassword data) => json.encode(data.toJson());

class ChangePassword {
    ChangePassword({
        required this.message,
    });

    String message;

    factory ChangePassword.fromJson(Map<String, dynamic> json) => ChangePassword(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
