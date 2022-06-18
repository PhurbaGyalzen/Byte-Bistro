import 'package:byte_bistro/Services/favourite_service.dart';
import 'package:byte_bistro/models/favourite.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  var favouriteList = [].obs;
  FavouriteService favouriteService = Get.put(FavouriteService());

  @override
  void onInit() {
    getUserFavourites('627fbfa1d464ffbeb80b985b');
    super.onInit();
  }

  getAllFavourites() async {
    var response = await favouriteService.getAllFavourites();
    favouriteList.value = response as List;
    return response;
  }

  getSingleFavourite(String favouriteId) async {
    var response = await favouriteService.getSingleFavourite(favouriteId);
    // favouriteList.value = response;
    return response;
  }

  getUserFavourites(String userId) async {
    var response = await favouriteService.getUserFavourites(userId);
    favouriteList.value = response as List;
    return response;
  }

  addFavourite(Map<String, dynamic> data) async {
    var response = await favouriteService.addFavourite(data);
    return response;
  }

  removeFavorite(String favouriteId) async {
    var response = await favouriteService.removeFavourite(favouriteId);
    var data = getUserFavourites('627fbfa1d464ffbeb80b985b');
    favouriteList.value = data as List;
    return response;
  }
}
