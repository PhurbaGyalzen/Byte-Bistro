import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:byte_bistro/Services/http_service.dart';

const PORT = 3001;

class WebSocketService {
  static String origin =
      'http:' + PersistentHtpp.baseUrl.split(':')[1] + ':$PORT';
  static var socket = IO.io(origin, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
}
