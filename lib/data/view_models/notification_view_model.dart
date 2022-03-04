import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:koloplan/data/models/notification_activity.dart';
import 'package:koloplan/data/services/dashboard_service.dart';
import 'package:rxdart/rxdart.dart';
import '../../locator.dart';

abstract class ABSNotificationViewModel extends ChangeNotifier {
  List<NotificationItemModel> _notificationList = [];
  List<NotificationItemModel> get NotificationList => _notificationList;
  set setNotificationList(List<NotificationItemModel> value);
  clearNotificationList(NotificationItemModel foodItem);

  final _listController = BehaviorSubject<List<NotificationItemModel>>.seeded([]);
  Stream<List<NotificationItemModel>> get listStream => _listController.stream;
  set setOrderList(List<NotificationItemModel> value);

  addToList(NotificationItemModel orderItem);
  removeFromList(NotificationItemModel orderItem);

  @override
  void dispose() {
    super.dispose();
    _listController.close();
  }

}

class NotificationViewModel extends ABSNotificationViewModel {
  ABSDashboardService _dashboardService = locator<ABSDashboardService>();

  NotificationViewModel();

  set setNotificationList(List<NotificationItemModel> value) {
    _notificationList = value;
    notifyListeners();
  }

  set setOrderList(List<NotificationItemModel> value) {
    _listController.sink.add(value);
    notifyListeners();
  }

  clearNotificationList(NotificationItemModel foodItem) {
    // int index = _notificationList.indexWhere((element) => element.id == foodItem.id);
    // _notificationList.removeAt(index);
    //remove it from the list
    _notificationList.remove(foodItem);
    notifyListeners();
  }

  addToList(NotificationItemModel orderItem) {
    _listController.sink.add(addNotificationToList(orderItem));
    notifyListeners();
  }

  removeFromList(NotificationItemModel orderItem) {
    _listController.sink.add(removeNotificationFromList(orderItem));
    notifyListeners();
  }

  List<NotificationItemModel> addNotificationToList(NotificationItemModel notificationItem) {
    bool isPresent = false;
    if (_notificationList.length > 0) {
      for (int i = 0; i < _notificationList.length; i++) {
        if (_notificationList[i].id == notificationItem.id) {
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }

      if (!isPresent) {
        _notificationList.add(notificationItem);
      }
    } else {
      _notificationList.add(notificationItem);
    }
    return _notificationList;
  }

  List<NotificationItemModel> removeNotificationFromList(NotificationItemModel notificationItem) {
    _notificationList.remove(notificationItem);
    return _notificationList;
  }
}
