import 'dart:io' show Platform;
import "package:http/http.dart" as http;

const PORT = 3000;

class PersistentHtpp {
  static var client = http.Client();
  static const baseHost = "192.168.101.3";
  // static const baseHost = "192.168.11.64";

  //  static const baseHost = "192.168.1.66";

  

  static String baseUrl = 'http://' +
      (Platform.environment['BACKEND_HOST'] ?? baseHost) +
      ':$PORT/';
}
