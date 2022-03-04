import 'package:koloplan/utils/enums.dart';

abstract class LoggableEvent{
  String get eventName;
  Map<String,dynamic> get parameters;
}

class UserEvent implements LoggableEvent {
  final String name;
  final String userId;
  final String userName;
  final String userEvent;
  final String currentPage;
  final AnalyticsEventStatus eventStatus;

  // user_events_mobile
  @override
  String get eventName => this.name;

  UserEvent(
      this.name, {
    this.userId = "",
    this.userName = "",
    this.userEvent = "",
    this.currentPage = "",
    this.eventStatus = AnalyticsEventStatus.NULL
  });

  @override
  Map<String, dynamic> get parameters => {
    "userId": userId,
    "userName": userName,
    "userEvent": userEvent,
    "currentPage": currentPage,
    "eventStatus": eventStatus.toString()
  };
}

