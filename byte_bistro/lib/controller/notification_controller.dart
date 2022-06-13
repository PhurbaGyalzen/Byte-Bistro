import 'package:byte_bistro/Services/notification_service.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var notificationList = [].obs;
  NotificationService notificationService = Get.put(NotificationService());

  @override
  void onInit() {
    getAllNotification();
    super.onInit();
  }

  // get all notification
  getAllNotification() async {
    var response = await notificationService.getAllNotification();
    notificationList.value = response;
    return response;
  }

  // get single notification
  getSingleNotification(String notificationId) async {
    var response = notificationService.getSingleNotification(notificationId);
    notificationList.value = response as List;
    return response;
  }
  



}
