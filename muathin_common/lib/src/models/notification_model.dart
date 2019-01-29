class NotificationModel {
  String title, body;

  NotificationModel transform({Map map}) {
    NotificationModel notification = new NotificationModel();

    notification.title = map['title'];
    notification.body = map['body'];

    return notification;
  }
}
