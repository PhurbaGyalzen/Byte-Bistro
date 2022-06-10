import 'dart:convert';

import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/models/notification.dart';

class NotificationService {
  Future<List<Notification>> getAllNotification() async {
    String endpoint = PersistentHtpp.baseUrl + 'notification';
    try {
      final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
      final jsonResponse = response.body;
      if (response.statusCode == 200) {
        return notificationFromJson(jsonResponse);
      } else {
        return Future.error('Internal Server Error');
      }
    } catch (err) {
      return Future.error(' Error fetching data $err');
    }
  }
}
