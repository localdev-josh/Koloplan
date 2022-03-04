import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koloplan/data/local_database/user_local.dart';
import 'package:koloplan/data/models/individual/secondary_state.dart';
import 'package:koloplan/data/view_models/firebase_view_model.dart';
import 'package:koloplan/data/view_models/identity_view_model.dart';
import 'package:koloplan/firebase_analytics/firebase_analytics_service.dart';
import 'package:koloplan/screens/dashboard_controller/home_controller_screen.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/styles/styles.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/app_toast.dart';
import 'package:koloplan/widgets/buttons.dart';
import 'package:koloplan/widgets/splash_tap.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '../../locator.dart';
import 'forgot_password_screen.dart';
import 'login_screen.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class TempLoginScreen extends StatefulWidget {
  final bool show;

  const TempLoginScreen({Key key, this.show = false}) : super(key: key);
  static Route<dynamic> route({bool show}) {
    return MaterialPageRoute(
        builder: (_) => TempLoginScreen(
              show: show,
            ),
        settings: RouteSettings(name: TempLoginScreen().toStringShort()));
  }

  @override
  _TempLoginScreenState createState() => _TempLoginScreenState();
}

class _TempLoginScreenState extends State<TempLoginScreen> with AfterLayoutMixin<TempLoginScreen> {
  bool obscureText = true;
  ABSFirebaseViewModel _firebaseViewModel;
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  final FirebaseAnalyticsService _firebaseAnalyticsService = locator<FirebaseAnalyticsService>();
  final FocusNode _nodeText1 = FocusNode();
  bool loading = false;
  String password = "";

  LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool _canCheckBiometric = false;
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool isBiometricStored = true;
  bool showBiometric = false;


  @override
  void initState() {
    super.initState();
    if(Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // statusBarColor: AppColors.kWhite,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.kBlack,
          systemNavigationBarIconBrightness: Brightness.light));
    }
    _checkBiometrics(context).whenComplete(() {
      if(_canCheckBiometric) {
        _getAvailableBiometrics(context);
      } else {
        setState(() {
          _canCheckBiometrics = false;
        });
      }
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  Future<void> _checkBiometrics(BuildContext context) async {
    bool canCheckBiometrics;
    try{
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print("check biometrics $e");
    }

    if(!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics(BuildContext context) async {
    List<BiometricType> availableBiometrics;
    try{
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print("Available biometrics $e");
    }

    if(!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
      if(_availableBiometrics.contains(BiometricType.fingerprint)) {
        setState(() {
          _canCheckBiometrics = true;
        });
        _authenticate();
      } else if(_availableBiometrics.contains(BiometricType.face)) {
        setState(() {
          _canCheckBiometrics = true;
        });
        _authenticate();
      } else if(_availableBiometrics.contains(BiometricType.iris)) {
        setState(() {
          _canCheckBiometrics = true;
        });
        _authenticate();
      } else {
        setState(() {
          _canCheckBiometrics = false;
        });
        print("Other local_auth not here");
      }
    });
  }

  Future<void> _authenticate() async {
    locator<ABSStateLocalStorage>().saveSecondaryState(
        SecondaryState.updateBiometrics(
            true,
            locator<ABSStateLocalStorage>()
                .getSecondaryState()));
    bool authenticated = false;
    try{
      print("here man");
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Login to your Koloplan account",
          useErrorDialogs: true,
          stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print("Fingerprint authenticate $e");
    }

    if(!mounted) return;

    setState(() {
      _authorized = authenticated ? "Authorized" : "Not Authorized";

      // print("Authorized ${_authorized}");
      if(_authorized == "Authorized") {
        locator<ABSStateLocalStorage>().saveSecondaryState(
            SecondaryState.updateBiometrics(
                true,
                locator<ABSStateLocalStorage>()
                    .getSecondaryState()));

        if(_localStorage.getSecondaryState().password.isNotEmpty || _localStorage.getSecondaryState().password != null) {
          setState(() {
            password = _localStorage.getSecondaryState().password;
          });
          login(context);
        } else {
          errorToastBar(context, message: "Login with your credentials",
              title: "Error", alignToast: Alignment.topRight);
        }
      }
    });
  }

  Future<void> _authenticateFirst(BuildContext context) async {
    bool authenticated = false;
    try{
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "Scan your fingerprint to authenticate",
          useErrorDialogs: true,
          stickyAuth: false
      );
    } on PlatformException catch (e) {
      print("Fingerprint authenticate $e");
    }

    if(!mounted) return;

    setState(() {
      _authorized = authenticated ? "Authorized" : "Not Authorized";

      if(_authorized == "Authorized") {
        locator<ABSStateLocalStorage>().saveSecondaryState(
            SecondaryState.updateBiometrics(
                true,
                locator<ABSStateLocalStorage>()
                    .getSecondaryState()));

        if(_localStorage.getSecondaryState().password.isNotEmpty || _localStorage.getSecondaryState().password != null) {
          setState(() {
            password = _localStorage.getSecondaryState().password;
          });
          login(context);
        } else {
          errorToastBar(context, message: "Login with your credentials",
              title: "Error", alignToast: Alignment.topRight);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _firebaseViewModel = Provider.of(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            _nodeText1.unfocus();
          },
          child: Stack(
            children: [
             /// Insert BG picture
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YMargin(height > 800
                          ? 140
                          : height > 700
                          ? 100
                          : 80),
                      BorderedText(
                          strokeWidth: 0.5,
                          strokeColor: AppColors.kTextColor,
                          child: Text(
                              "Good ${DateTime.now().hour < 12 ? 'morning' : DateTime.now().hour > 16 ? 'evening' : 'afternoon'}, ${_firebaseViewModel.user.firstName ?? "User"}",
                              textScaleFactor: 1,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                decorationColor: AppColors.kWhite,
                                fontSize: 21,
                                height: 1.6,
                                fontFamily: AppStrings.poppinsExtraBold,
                                color: Colors.white
                            ),
                          )),
                      YMargin(7),
                      Text(
                        "Achieve more with Koloplan today!",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontFamily: AppStrings.fontNormal,
                              height: 1.5,
                              fontSize: 13.8,
                              color: AppColors.kGreyText1)
                      ),
                      YMargin(50),
                      Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12)),
                        child: Transform.translate(
                          offset: Offset(0, 5),
                          child: TextField(
                            focusNode: _nodeText1,
                            onTap: () {
                              _nodeText1.requestFocus();
                            },
                            obscureText: obscureText,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            style: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 15),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.kInputFieldBg,
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Color(0xff1B2D58), width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: AppColors.kPrimaryColorLight.withOpacity(0.6), width: 1.5),
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 14),
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 14),
                                suffixIcon: Splash(
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  splashColor: AppColors.kWhite,
                                  maxRadius: 25,
                                  minRadius: 24.5,
                                  child: IntrinsicWidth(
                                    child: Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.only(right: 20, left: 10),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        obscureText ? Icons.visibility_off : Icons.visibility,
                                        size: 22,
                                        color: Color(0xff163073),
                                      ),
                                    ),
                                  ),
                                )
                              // counterText: 'counter',
                            ),
                          ),
                        ),
                      ),
                      _canCheckBiometric == true ? YMargin(40) : Container(),
                      _canCheckBiometric ?
                      _localStorage.getSecondaryState()
                          .biometricsEnabled ==
                          true ?
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              _authenticate();
                            },
                            // fingerprint Face ID Android Face
                            child: SvgPicture.asset(
                              Platform.isAndroid ? _availableBiometrics.contains(BiometricType.face) && _availableBiometrics.contains(BiometricType.fingerprint) == false ?
                              "assets/images/Android Face.svg" : _availableBiometrics.contains(BiometricType.fingerprint) && _availableBiometrics.contains(BiometricType.face) == false ?
                              "assets/images/fingerprint.svg" : "assets/images/Android Face.svg" : _availableBiometrics.contains(BiometricType.face) && _availableBiometrics.contains(BiometricType.fingerprint) == false ?
                              "assets/images/Face ID.svg" : _availableBiometrics.contains(BiometricType.fingerprint) && _availableBiometrics.contains(BiometricType.face) == false ?
                              "assets/images/fingerprint.svg" : "assets/images/Face ID.svg",
                              color: AppColors.kWhite,
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      ) : Container()
                          : Container(),
                      YMargin(40),
                      Center(
                        child: Splash(
                            splashColor: AppColors.kWhite,
                            maxRadius: 25,
                            minRadius: 24.5,
                            onTap: () {
                              Navigator.of(context).push(LoginScreen.route(isLanding: true));
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.all(10),
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        decorationColor: AppColors.kPrimaryBlueFaded,
                                        fontFamily: AppStrings.fontSemiBold,
                                        color: AppColors.kWhite1,
                                        fontSize: 13
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Not you? '),
                                      TextSpan(
                                          text: 'Switch account', style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 14)),

                                    ]),
                              ),
                            )),
                      ),
                      YMargin(20),
                      PrimaryButtonNew(
                        onTap: password.length >= 8
                            ? () async {
                          await login(context);
                        }
                            : null,
                        title: "Log in",
                        width: MediaQuery.of(context).size.width,
                        fontBold: true,
                        fontSizePrimary: 15,
                        bg: AppColors.kWhite,
                        textColor: AppColors.kSecondaryColor,
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future login(BuildContext context) async {
    EasyLoading.show(status: "");
    var result = await _firebaseViewModel.loginCustomerWithEmail(
      email: _localStorage.getSecondaryState().email,
      password: password
    );
    EasyLoading.dismiss();
    if (result.error == true) {
      errorToastBar(context, message: result.errorMessage ??
          "Login failed",
          title: "Login error", alignToast: Alignment.topRight);
    } else {
      Navigator.of(context).pushReplacement(HomeControllerScreen.route());
    }
  }
}
