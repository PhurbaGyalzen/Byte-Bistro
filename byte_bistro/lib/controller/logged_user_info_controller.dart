import 'package:byte_bistro/Services/logged_user_info.dart';
import 'package:byte_bistro/models/loged_user_info.dart';
import 'package:get/get.dart';

class LoggedUserInfoController extends GetxController {
  var userInfo = <LoggedUserInfo>[].obs;
  LoggedUserInfoService loggedUserInfoService =
      Get.put(LoggedUserInfoService());

  @override
  void onInit() {
    getLoggedUserInfo();
    super.onInit();
  }

  // get user
  Future getLoggedUserInfo() async {
    LoggedUserInfo response = await LoggedUserInfoService.getUserInfoSevice();

    userInfo.value = [response];

    return response;
  }

  static updateProfileInfo(Map<String, dynamic> data) async {
    var response = LoggedUserInfoService.updateUserInfoService(data);
    return 'success';
  }
}
