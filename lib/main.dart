import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koloplan/data/models/individual/user_data.dart';
import 'package:koloplan/screens/account/temp_login_screen.dart';
import 'package:koloplan/screens/dashboard_controller/home_controller_screen.dart';
import 'package:hive/hive.dart';
import 'package:koloplan/screens/landing_screen.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/network_error_indicator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import 'animations/loading.dart';
import 'base_screen.dart';
import 'data/local_database/user_local.dart';
import 'data/models/individual/secondary_state.dart';
import 'data/view_models/dashboard_view_model.dart';
import 'data/view_models/firebase_view_model.dart';
import 'data/view_models/identity_view_model.dart';
import 'data/view_models/notification_view_model.dart';
import 'locator.dart';
import 'navigator_service.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/foundation.dart' show kIsWeb;

// Dukka interview (Koloplan)

String oneSignalAppID;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  // OneSignal app id for in-app notifications, used for sending messages among customers
  oneSignalAppID = AppStrings.oneSignalID;
  OneSignal.shared.init(oneSignalAppID, iOSSettings: null);
  OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

  RenderErrorBox.backgroundColor = Colors.transparent;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);

  // * init hive flutter *
  var appDocumentDir;
  if (kIsWeb) {
    // Set web-specific directory
  } else {
    appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  }
  print("Application path is ${appDocumentDir.path}");
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserDataAdapter());
  Hive.registerAdapter(SecondaryStateAdapter());

  //open up hive
  await Hive.openBox(AppStrings.state);
  await Hive.openBox("pinState");

  await Firebase.initializeApp();
  //initialize service locator
  setUpLocator();
  Paint.enableDithering = true;
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 500)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 50.0
    ..radius = 0.0
    ..infoWidget = LoadingWIdget()
    ..indicatorWidget = LoadingWIdget()
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskType = EasyLoadingMaskType.clear
    ..maskColor = Colors.blue.withOpacity(0)
    ..userInteractions = false;
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String _connectionStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    initConnectivity();
    OverlaySupportEntry entry;
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((_updateConnectionStatus) {
      if (_updateConnectionStatus == ConnectivityResult.wifi || _updateConnectionStatus == ConnectivityResult.mobile) {
        if (entry != null) {
          entry.dismiss();
        }
      } else {
        entry = showOverlayNotification((context) {
          return GestureDetector(
              onTap: () {
                entry.dismiss();
              },
              child: NetworkErrorAnimation(onNext: () {
                entry.dismiss();
              }));
        }, duration: Duration(hours: 1));
      }
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    /// If the widget was removed from the tree while the asynchronous platform
    /// message was in flight, we want to discard the reply rather than calling
    /// setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    // Check to see if Android Location permissions are enabled
    // Described in https://github.com/flutter/flutter/issues/51529
    if (Platform.isAndroid) {
      print('Checking Android permissions');
      var status = await Permission.location.status;
      // Blocked?
      if (status.isUndetermined || status.isDenied || status.isRestricted) {
        // Ask the user to unblock
        if (await Permission.location.request().isGranted) {
          // Either the permission was already granted before or the user just granted it.
          print('Location permission granted');
        } else {
          print('Location permission not granted');
        }
      } else {
        print('Permission already granted (previous execution?)');
      }
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print('Result: $result');
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;
        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status = await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status = await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } on PlatformException catch (e) {
          print('Error: $e.toString()');
          wifiName = "Failed to get Wifi Name";
        }
        print('Wi-Fi Name: $wifiName');

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
            await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
              await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }
        print('BSSID: $wifiBSSID');

        try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = '$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n';
        });
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    print("Firehere");
    return OverlaySupport(
      child: BaseScreen(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<ABSFirebaseViewModel>(
              create: (_) => FirebaseViewModel(),
            ),
            ChangeNotifierProvider<ABSDashboardViewModel>(
              create: (_) => DashboardViewModel(),
            ),
            ChangeNotifierProvider<ABSIdentityViewModel>(
              create: (_) => IdentityViewModel(),
            ),
            ChangeNotifierProvider<ABSNotificationViewModel>(
              create: (_) => NotificationViewModel(),
            ),
          ],
          child: MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: AppStrings.fontNormal,
              primarySwatch: Colors.blue,
              primaryColor: AppColors.kSecondaryColor,
              indicatorColor: AppColors.kRed,
              bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            builder: EasyLoading.init(),
            navigatorKey: locator<NavigationService>().navigatorKey,
            home: HomeApp(),
          ),
        ),
      ),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> with WidgetsBindingObserver {
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  String opened = "";
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    if(Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: AppColors.kBlack,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.kBlack,
          systemNavigationBarIconBrightness: Brightness.dark));
    }
    // * To handle in-app notification action *
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult notification) async {
      opened = notification.action.actionId;
      if(notification.notification.payload.launchUrl != null) {
        await launch(notification.notification.payload.launchUrl);
      } else if(notification.notification.payload.buttons[0].icon != null) {
        await launch(notification.notification.payload.buttons[0].icon);
      } else {
        print("In-app navigation");
      }
      //will be called whenever a notification is opened
    });

    // * Will be called whenever a notification is received *
    OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
      print("I received a notification ${notification.payload.title}");
      print("I received a notification content ${notification.payload.body}");
    });

    UserData user = _localStorage.getUser();
    if (user != null) {
      SecondaryState state = SecondaryState(
          isLoggedIn: _localStorage.getSecondaryState().isLoggedIn,
          email: _localStorage.getSecondaryState().email,
          password: _localStorage.getSecondaryState().password,
          biometricsEnabled: _localStorage.getSecondaryState().biometricsEnabled);
      _localStorage.saveSecondaryState(state);
    }
  }

  @override
  Widget build(BuildContext context) {
    SecondaryState state = _localStorage.getSecondaryState();
    UserData user = _localStorage.getUser();
    return state.isLoggedIn == false ? user == null ? LandingScreen() : TempLoginScreen(show: true) : HomeControllerScreen();
  }
}

