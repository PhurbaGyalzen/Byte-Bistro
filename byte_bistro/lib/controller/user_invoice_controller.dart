
import 'package:byte_bistro/Services/userInvoiceService.dart';
import 'package:byte_bistro/models/user_invoice_model.dart';
import 'package:get/get.dart';

class UserInvoiceController extends GetxController {
  var userInvoice = <UserInvoiceModel>[].obs;
  UserInvoiceService userInvoiceService = Get.put(UserInvoiceService());

  @override
  void onInit() {
    getUserInvoiceControllerInfo();
    super.onInit();
  }

  // get user
  Future getUserInvoiceControllerInfo() async {
    // print("response 1");
    List<UserInvoiceModel> response = await UserInvoiceService.getUserInvoiceService();
    // print("response ${response}");

    return response;
  }
}
