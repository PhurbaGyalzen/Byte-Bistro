import 'dart:convert';

GeneralResponse responseFromJson(String str) =>
    GeneralResponse.fromJson(json.decode(str));

String responseToJson(GeneralResponse data) => json.encode(data.toJson());

class GeneralResponse {
  GeneralResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      GeneralResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
