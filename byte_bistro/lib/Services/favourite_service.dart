import 'dart:convert';
import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/models/favourite.dart';

class FavouriteService {
  Future<List<Favourite>> getAllFavourites() async {
    String endpoint = PersistentHtpp.baseUrl + 'favourite';
    try {
      final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
      final stringData = response.body;
      if (response.statusCode == 200) {
        return favouriteFromJson(stringData);
      } else {
        return Future.error('Internal Server Error');
      }
    } catch (err) {
      return Future.error(' Error fetching data $err');
    }
  }

  Future getSingleFavourite(String favouriteId) async {
    String endpoint = PersistentHtpp.baseUrl + 'favourite/$favouriteId';

    final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
    final jsonResponse = response.body;
    if (response.statusCode == 200) {
      return favouriteFromJson(jsonResponse);
    } else {
      return null;
    }
  }

  Future<List<Favourite>> getUserFavourites(String userId) async {
    String endpoint = PersistentHtpp.baseUrl + 'favourite/user/$userId';
    try {
      final response = await PersistentHtpp.client.get(Uri.parse(endpoint));
      final stringData = response.body;
      if (response.statusCode == 200) {
        return favouriteFromJson(stringData);
      } else {
        return Future.error('Internal Server Error');
      }
    } catch (err) {
      return Future.error(' Error fetching data $err');
    }
  }

  Future addFavourite(Map<String, dynamic> data) async {
    String endpoint = PersistentHtpp.baseUrl + 'favourite';
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
      } else if (response.statusCode == 400) {
        return 'isFavourite';
      }
    } catch (err) {
      return Future.error(' err');
    }
  }

  Future removeFavourite(String favouriteId) async {
    String endpoint = PersistentHtpp.baseUrl + 'favourite/$favouriteId';
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
