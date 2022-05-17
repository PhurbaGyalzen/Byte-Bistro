import "package:http/http.dart" as http;

class PersistentHtpp {
  static var client = http.Client();
  static const baseUrl = "http://192.168.101.2:3000/";
  // static const baseUrl = "http://10.1.6.200:3000/";
}
