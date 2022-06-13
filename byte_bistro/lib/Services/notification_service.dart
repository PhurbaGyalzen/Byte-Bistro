import 'dart:convert';

import 'package:byte_bistro/Services/http_service.dart';

import '../Models/notification.dart';

class NotificationService {
  Future<List<Notificationl>> getAllnotification() async {
    String endpoint = PersistentHtpp.baseUrl + '/notification';
    try {
      final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
      final jsonResponse = response.body;
      if (response.statusCode == 200) {
        return notificationlFromJson(jsonResponse);
      } else {
        return Future.error('Internal Server Error');
      }
    } catch (err) {
      return Future.error(' Error fetching data $err');
    }
  }

  Future getSingleNotification(String notificationId) async {
    String endpoint = PersistentHtpp.baseUrl + 'notification/$notificationId';

    final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
    final jsonResponse = response.body;
    if (response.statusCode == 200) {
      return notificationlFromJson(jsonResponse);
    } else {
      return null;
    }
  }

  Future<String> addNotification(Map<String, dynamic> data) async {
    String endpoint = PersistentHtpp.baseUrl + 'notification';
    try {
      final response = await PersistentHtpp.client.post(
        Uri.parse(endpoint),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return Future.error('err');
      }
    } catch (err) {
      return Future.error(' err');
    }
  }

  Future<List<Notificationl>> getUserNotification(String userId) async {
    String endpoint = PersistentHtpp.baseUrl + 'notification/user/$userId';
    try {
      final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
      final jsonResponse = response.body;
      if (response.statusCode == 200) {
        return notificationlFromJson(jsonResponse);
      } else {
        return Future.error('Internal Server Error');
      }
    } catch (err) {
      return Future.error(' Error fetching data $err');
    }
  }

  Future<String> updateNotification(
    String notificationId,
    Map<String, dynamic> data,
  ) async {
    String endpoint = PersistentHtpp.baseUrl + 'notification/$notificationId';
    try {
      final response = await PersistentHtpp.client.patch(
        Uri.parse(endpoint),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return Future.error('err');
      }
    } catch (err) {
      return Future.error(' err');
    }
  }

  Future<String> deleteNotification(String notificationId) async {
    String endpoint = PersistentHtpp.baseUrl + 'notification/$notificationId';
    try {
      final response = await PersistentHtpp.client.delete(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        return 'success';
      } else {
        return Future.error('err');
      }
    } catch (err) {
      return Future.error(' err');
    }
  }
}
