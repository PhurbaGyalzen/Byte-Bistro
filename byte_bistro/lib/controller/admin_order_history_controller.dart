
import 'package:byte_bistro/Services/admin_order_history.dart';

import 'package:byte_bistro/models/admin_order_history.dart';

import 'package:get/get.dart';

class AdminOrderHistoryController extends GetxController {
  var userInvoice = <AdminOrderHistory>[].obs;
 AdminOrderHistoryService adminService = Get.put(AdminOrderHistoryService());

  @override
  void onInit() {
    getAdminOrderHistoryControllerInfo();
    super.onInit();
  }

  
  static Future getAdminOrderHistoryControllerInfo() async {
 
     List<AdminOrderHistory> response = await AdminOrderHistoryService.getAdminOrderHistoryService();

    return response;
  }
}
