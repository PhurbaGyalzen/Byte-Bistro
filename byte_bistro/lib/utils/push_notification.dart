import 'package:awesome_notifications/awesome_notifications.dart';

void notify(String title, String body) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture:
            'https://i.postimg.cc/BQF1V6pQ/General-Manager-Linked-In-Article-Cover-Image.png'),
  );
}