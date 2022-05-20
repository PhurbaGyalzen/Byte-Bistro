import 'dart:io' show Platform;
import "package:http/http.dart" as http;

const PORT = 3000;

class PersistentHtpp {
  static var client = http.Client();
<<<<<<< HEAD:frontend/byte_bistro/lib/Services/http_service.dart
  static const baseHost = "192.168.101.3";
  // static const baseHost = "192.168.11.64";

  //  static const baseHost = "192.168.1.66";

  
=======
  // static const baseHost = "192.168.101.2";
  static const baseHost = "192.168.11.67";
  // static const baseHost = "100.91.255.71"; // dont touch this. make ur own.
>>>>>>> 9b997189c23901243ff3d53a44a43eb7ad8a07ce:byte_bistro/lib/Services/http_service.dart

  static String baseUrl = 'http://' +
      (Platform.environment['BACKEND_HOST'] ?? baseHost) +
      ':$PORT/';
}
