import 'package:byte_bistro/Services/storage_service.dart';
import 'package:byte_bistro/utils/utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:byte_bistro/Services/http_service.dart';

const PORT = 3001;

class WebSocketService {
  static String origin = trimRight(PersistentHtpp.baseUrl, '/');
  static IO.Socket socket = IO.io(origin, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  static Future<bool> authenticate() async {
    WebSocketService._connect();
    String? token = await Storage.get('token');
    if (token == null) {
      return false;
    }
    socket.emit('auth', [
      {'token': token}
    ]);
    return true;
  }

  static bool _connect() {
    if (socket.connected) {
      print('socket is already connected.');
      return true;
    }
    print('socket is connecting first time.');
    socket.connect();
    return true;
  }
}
