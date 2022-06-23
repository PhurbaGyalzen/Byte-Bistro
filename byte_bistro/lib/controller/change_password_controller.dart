import 'package:byte_bistro/Services/change_password_service.dart';
import 'package:byte_bistro/models/change_password.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  var changePassword = <ChangePassword>[].obs;
  ChangePasswordService changePasswordService1 =
      Get.put(ChangePasswordService());

  // @override
  // void onInit() {
  //   changePasswordController();
  //   super.onInit();
  // }

  changePasswordController(Map<String, dynamic> data) async {
    var response = await ChangePasswordService.changePasswordService(data);
    return response;
  }
}
