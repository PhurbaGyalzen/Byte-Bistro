import "package:http/http.dart" as http;

class PersistentHtpp {
  static var client = http.Client();
  static const baseUrl = "http://192.168.101.3:3000/";
  // static const baseUrl = "http://100.91.255.71:3000/";
}
