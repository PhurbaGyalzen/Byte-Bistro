import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:http/http.dart';
import './storage_service.dart';

const PORT = 3000;

class PersistentHtpp {
  static var client = http.Client();
  static const baseHost = "192.168.101.2";

  static String baseUrl =
      'http://' + (dotenv.env['BACKEND_HOST'] ?? baseHost) + ':$PORT/';

  static Map<String, String> headers = {
    //   "Authorization": "Bearer " + (await Storage.get('token') ?? "")
  };

  static void setHeaders(Map<String, String> hdrs) async {
    headers = {
      ...headers,
      "Authorization": "Bearer " + (await Storage.get('token') ?? "")
    };
  }

  static Future<Response> get(String path) async {
    Response response =
        await client.get(Uri.parse(baseUrl + path), headers: headers);
    return response;
  }

  static Future<Response> post(String path, {String body = ""}) async {
    Response response = await client.post(Uri.parse(baseUrl + path),
        headers: {...headers, "Content-Type": "application/json"}, body: body);
    return response;
  }
}
