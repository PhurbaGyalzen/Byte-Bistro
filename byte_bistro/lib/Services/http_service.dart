import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;

const PORT = 3000;

class PersistentHtpp {
  static var client = http.Client();
  static const baseHost = "192.168.1.66";
  // static const baseHost = "192.168.11.67";

  static String baseUrl =
      'http://' + (dotenv.env['BACKEND_HOST'] ?? baseHost) + ':$PORT/';
}
