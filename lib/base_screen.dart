import 'package:flutter/material.dart';
import 'package:koloplan/screens/account/temp_login_screen.dart';
import 'data/local_database/user_local.dart';
import 'data/models/individual/secondary_state.dart';
import 'locator.dart';
import 'navigator_service.dart';


class BaseScreen extends StatefulWidget {
  final Widget child;

  const BaseScreen({Key key,@required this.child}) : super(key: key);
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with WidgetsBindingObserver {
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("App Resumed");
      if (_localStorage.getSecondaryState().lastMinimized == null ||
          _localStorage.getSecondaryState().email == null) {
        return;
      }
      print(
          "App Resumed 2 ${DateTime.now().difference(_localStorage.getSecondaryState().lastMinimized).inSeconds}");
      print("App Resumed 211 ${_localStorage.getSecondaryState().lastMinimized.toIso8601String()}");
      print("App Resumed biometrics  ${_localStorage.getSecondaryState().biometricsEnabled}");
      print("App Resumed 2ww ${DateTime.now().toIso8601String()}");
      if (DateTime.now()
          .difference(_localStorage.getSecondaryState().lastMinimized)
          .inSeconds >
          5) {
        print("App should stop");
        SecondaryState state = SecondaryState(
            isLoggedIn: false,
            email: _localStorage.getSecondaryState().email,
            password: _localStorage.getSecondaryState().password,
            biometricsEnabled:
            _localStorage.getSecondaryState().biometricsEnabled);
        _localStorage.saveSecondaryState(state);
        // TODO: implement initState
        //Navigate to temporary screen
        locator<NavigationService>().navigateTo1(TempLoginScreen.route(show: true));
      }
    } else if (state == AppLifecycleState.inactive) {
      print("App inactive");
    } else if (state == AppLifecycleState.paused) {
      DateTime time = DateTime.now();
      SecondaryState secondaryState = _localStorage.getSecondaryState();
      secondaryState.lastMinimized = time;
      print("kkkk ${secondaryState.lastMinimized.toIso8601String()}");
      print("biometrics ${secondaryState.biometricsEnabled}");

      _localStorage.saveSecondaryState(secondaryState);
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}



