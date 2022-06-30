import 'package:byte_bistro/Services/notification_service.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var notificationList = [].obs;
  NotificationService notificationService = Get.put(NotificationService());

  @override
  void onInit() {
    // getAllNotification();
    super.onInit();
  }

  // get all notification
  getAllNotification() async {
    var response = await notificationService.getAllnotification();
    notificationList.value = response;
    return response;
  }

  // get single notification
  getSingleNotification(String notificationId) async {
    var response = notificationService.getSingleNotification(notificationId);
    notificationList.value = response as List;
    return response;
  }

  // delete notification
  deleteNotification(String notificationId) async {
    var response = await notificationService.deleteNotification(notificationId);
    return response;
  }

  addNotification(Map<String, dynamic> data) async {
    var response = await notificationService.addNotification(data);
    return response;
  }

  addOfferNotification(Map<String, dynamic> data) async {
    var response = await notificationService.addOfferNotification(data);
    return response;
  }

  getUserNotification(String userId) async {
    var response = await notificationService.getUserNotification(userId);
    notificationList.value = response as List;
    return response;
  }

  getOfferNotification() async {
    var response = await notificationService.getOfferNotification();
    notificationList.value = response as List;
    return response;
  }

  updateNotification(String notificationId, Map<String, dynamic> data) async {
    var response =
        await notificationService.updateNotification(notificationId, data);
    return response;
  }
}
