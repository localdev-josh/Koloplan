import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'models/loggable_event.dart';

// This class is to log custom events
// You can get access to an instance via locator i.e locator<FirebaseAnalyticsService>()
class FirebaseAnalyticsService {
  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);

  void logEvent(LoggableEvent event){
    print("Firebase event name is ${event.eventName}");
    for(var item in event.parameters.entries) {
      print("Firebase parameter key ${item.key}");
      print("Firebase parameter value ${item.value}");
    }
    _firebaseAnalytics.logEvent(name: event.eventName, parameters: event.parameters);
  }
}