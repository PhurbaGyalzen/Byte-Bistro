import 'package:byte_bistro/Services/favourite_service.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:byte_bistro/models/favourite.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  var favouriteList = [].obs;
  FavouriteService favouriteService = Get.put(FavouriteService());
  final LoggedUserInfoController loggedUserInfoController =
      Get.put(LoggedUserInfoController());
  // var loggedUserInfo;

  @override
  void onInit() {
    super.onInit();
    loggedUserInfoController.getLoggedUserInfo().then((value) {
      print("In fav controller");
      print(value);
      getUserFavourites(value.id);
    });
    // getUserFavourites2();
    // print(loggedUserInfoController.userInfo[0].id.toString());
    // getUserFavourites();
    // print(favouriteList.value);
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

  getUserFavourites2() async {
    var data = await loggedUserInfoController.getLoggedUserInfo();
    var response = await favouriteService.getUserFavourites(data.id.toString());
    favouriteList.value = response as List;
    return response;
  }

  addFavourite(Map<String, dynamic> data) async {
    var response = await favouriteService.addFavourite(data);
    var result =
        getUserFavourites(loggedUserInfoController.userInfo.toString());
    favouriteList.value = result as List;
    return response;
  }

  removeFavorite(String favouriteId) async {
    var response = await favouriteService.removeFavourite(favouriteId);
    var data = getUserFavourites(loggedUserInfoController.userInfo.toString());
    favouriteList.value = data as List;
    return response;
  }
}
