import 'dart:io' show Platform;
import "package:http/http.dart" as http;

class PersistentHtpp {
  static var client = http.Client();
  // static const baseOrign = "http://192.168.101.2:3000/";
  static const baseOrign = "http://192.168.11.64:3000/";
  static String baseUrl = Platform.environment['EMULATOR_ORIGIN'] ?? baseOrign;
}
