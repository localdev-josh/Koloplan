import 'package:flutter/foundation.dart';

NotificationActivityList notificationItemList = NotificationActivityList(menuItems: [
  NotificationItemModel(
      id: "1",
      title: "Fancy African tonight?",
      message: "Get 10% off when you use the code AFRICAN10.",
  ),
  NotificationItemModel(
    id: "2",
    title: "Lunch reminder",
    message: "Hello! It's time for lunch, don't forget to have one",
  ),
]);

class NotificationActivityList {
  List<NotificationItemModel> menuItems;

  NotificationActivityList({@required this.menuItems});
}

class NotificationItemModel {
  String id;
  String title;
  String message;
  String image;

  NotificationItemModel({
    this.id,
    this.title,
    this.message,
    this.image
  });
}



