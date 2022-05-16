import "package:http/http.dart" as http;

class PersistentHtpp {
  static var client = http.Client();
  static const baseUrl = "http://192.168.101.2:3000/";
}
