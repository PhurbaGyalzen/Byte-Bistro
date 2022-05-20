import 'dart:io' show Platform;
import "package:http/http.dart" as http;

const PORT = 3000;

class PersistentHtpp {
  static var client = http.Client();
  static const baseHost = "192.168.101.3";
  // static const baseHost = "192.168.11.67";
  // static const baseHost = "10.1.6.207";
  // static const baseHost = "100.91.255.71"; // dont touch this. make ur own.

  static String baseUrl = 'http://' +
      (Platform.environment['BACKEND_HOST'] ?? baseHost) +
      ':$PORT/';
}
