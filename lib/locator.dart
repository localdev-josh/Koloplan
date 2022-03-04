import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'data/local_database/user_local.dart';
import 'data/services/dashboard_service.dart';
import 'data/services/firebase_service.dart';
import 'data/services/identity_service.dart';
import 'firebase_analytics/firebase_analytics_service.dart';
import 'navigator_service.dart';

GetIt locator = GetIt.instance;

void setUpLocator(){
  locator.registerLazySingleton(() => NavigationService());

  locator.registerLazySingleton<ABSDashboardService>(() => DashboardService());
  locator.registerLazySingleton<ABSIdentityService>(() => IdentityService());
  locator.registerLazySingleton<ABSStateLocalStorage>(() => StateBoxStorage());
  locator.registerLazySingleton<ABSFirebaseService>(() => FirebaseService());
  locator.registerLazySingleton(() => FirebaseAnalytics());
  locator.registerLazySingleton(() => FirebaseAnalyticsService());
}