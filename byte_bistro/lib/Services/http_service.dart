import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import './storage_service.dart';

const PORT = 3000;

class PersistentHtpp {
  static var client = http.Client();
  static const baseHost = "192.168.101.2";

  static String baseUrl =
      'http://' + (dotenv.env['BACKEND_HOST'] ?? baseHost) + ':$PORT/';
  // static String baseUrl = 'http://httpbin.org/';

  static Map<String, String> headers = {};

  static void setHeaders(Map<String, String> hdrs) async {
    headers = {...headers, ...hdrs};
  }

  static Future<bool> storeAndSetHeader({String? token}) async {
    /* store token in the storage and set the global headers too. */
    if (token == null) {
      token = await Storage.get('token') ?? '';
    }
    await Storage.set('token', token);
    headers = {
      ...headers,
      "Authorization": "Bearer " + (await Storage.get('token') ?? "")
    };
    return true;
  }

  static Future<http.Response> _req(String method, String path,
      {Map<String, String>? extraHeaders, String body = ""}) async {
    http.Request request = http.Request(method, Uri.parse(baseUrl + path));
    extraHeaders ??= {};
    ({...headers, ...extraHeaders}).forEach((key, value) {
      request.headers[key] = value;
    });
    if (method == 'POST' || method == 'PUT') {
      request.bodyBytes = request.encoding.encode(body);
    }

    http.StreamedResponse streamedResponse = await client.send(request);
    http.Response response = await http.Response.fromStream(streamedResponse);
    if (isUserNotAuthenticated(response)) {
      print("JWT token has expired. redirecting to login page");
      Get.offAllNamed('/login');
    }
    return response;
  }

  static Future<http.Response> get(String path) async {
    http.Response response = await _req('GET', path);
    return response;
  }

  static Future<http.Response> post(String path, {String body = ""}) async {
    http.Response response = await _req('POST', path,
        extraHeaders: {"Content-Type": "application/json"}, body: body);
    return response;
  }

  static Future<http.Response> put(String path, {String body = ""}) async {
    http.Response response = await _req('PUT', path,
        extraHeaders: {"Content-Type": "application/json"}, body: body);
    return response;
  }

  static bool isUserNotAuthenticated(http.Response response) {
    return response.statusCode == 401;
  }
}
