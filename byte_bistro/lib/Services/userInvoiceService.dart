import 'dart:convert';

import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/models/user_invoice_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInvoiceService {
  //
  static Future<List<UserInvoiceModel>> getUserInvoiceService() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var token = prefs.getString("token");
    // var prefs = SharedPreferences();
    String endpoint = PersistentHtpp.baseUrl + 'cart/user';
    try {
      final response =
          await PersistentHtpp.client.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
      });

      final jsonResponse = response.body;
      if (response.statusCode == 200) {
        return userInvoiceModelFromJson(jsonResponse);
      } else {
        return Future.error('Internal Server Error');
      }
    } catch (err) {
      return Future.error(' Error fetching data $err');
    }
  }
}
