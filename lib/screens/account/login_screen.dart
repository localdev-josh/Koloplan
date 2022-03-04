import 'dart:io';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koloplan/data/view_models/firebase_view_model.dart';
import 'package:koloplan/data/view_models/identity_view_model.dart';
import 'package:koloplan/firebase_analytics/firebase_analytics_service.dart';
import 'package:koloplan/firebase_analytics/models/loggable_event.dart';
import 'package:koloplan/screens/dashboard_controller/home_controller_screen.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/styles/styles.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/utils/validator.dart';
import 'package:koloplan/widgets/app_toast.dart';
import 'package:koloplan/widgets/buttons.dart';
import 'package:koloplan/widgets/splash_tap.dart';
import 'package:provider/provider.dart';
import '../../locator.dart';
import 'create_account.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({this.isLanding = false, Key key}) : super(key: key);

  static Route<dynamic> route({bool isLanding = false}) {
    return MaterialPageRoute(
        builder: (_) => LoginScreen(isLanding: isLanding),
        settings: RouteSettings(name: LoginScreen().toStringShort()));
  }

  final bool isLanding;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final FirebaseAnalyticsService _firebaseAnalyticsService = locator<FirebaseAnalyticsService>();
  ABSFirebaseViewModel _firebaseViewModel;
  bool obscureText = true;
  bool autoValidate = false;
  bool isEmpty = false;
  bool notTyping = true;
  String _email = "";
  String _password = "";
  bool _emailError = false;
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

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
  }

  @override
  Widget build(BuildContext context) {
    _firebaseViewModel = Provider.of(context);
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      body: GestureDetector(
        onTap: () {
          _nodeText1.unfocus();
          _nodeText2.unfocus();
        },
        child: Container(
            child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YMargin(15),
                      widget.isLanding
                          ? Splash(
                        onTap: () async {
                          if(_nodeText1.hasFocus || _nodeText2.hasFocus) {
                            _nodeText1.unfocus();
                            _nodeText2.unfocus();
                            await Future.delayed(Duration(milliseconds: 500));
                          }
                          Navigator.pop(context);
                        },
                        splashColor: AppColors.kWhite,
                        maxRadius: 25,
                        minRadius: 24.5,
                        child: IntrinsicWidth(
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/icons/arrow_right.svg"),
                                XMargin(8),
                                Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    Transform.translate(
                                      offset: Offset(0, -1),
                                      child: Text("Back",
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            decorationColor: AppColors.kPrimaryBlueFaded,
                                            fontFamily: AppStrings.poppinsBold,
                                            color: AppColors.kRed4,
                                            fontSize: 14.5
                                        ),
                                      ),
                                    ),
                                    Text("Back",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          decorationColor: AppColors.kPrimaryBlueFaded,
                                          fontFamily: AppStrings.poppinsBold,
                                          color: AppColors.kWhite1,
                                          fontSize: 14.5
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      )
                          : Container(
                        height: 65,
                        width: 45,
                        color: Colors.transparent,
                      ),
                      widget.isLanding ? YMargin(60) : YMargin(0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1,
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationColor: AppColors.kWhite,
                                  fontSize: 21,
                                  height: 1.6,
                                  fontFamily: AppStrings.poppinsExtraBold,
                                  color: Colors.white
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Enjoy life,\n'),
                                TextSpan(
                                    text: 'it\'s a gift', style: TextStyle(color: AppColors.kPrimaryColor)),

                              ]),
                        ),
                      ),
                      YMargin(45),

                      Container(
                        height: 55,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
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
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              notTyping = false;
                              if (EmailValidator.validate(value)) {
                                _emailError = false;
                              } else {
                                _emailError = true;
                              }
                              _email = value;
                              if(value.isEmpty) {
                                isEmpty = true;
                              } else {
                                isEmpty = false;
                              }
                              setState(() {});
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
                                labelText: 'Email address',
                                labelStyle: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 14),
                                hintText: 'Enter your email address',
                                hintStyle: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 14)
                              // counterText: 'counter',
                            ),
                          ),
                        ),
                      ),

                      if (autoValidate == false ? false : true)
                        if(isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 28, top: 10),
                            child: Text(
                              "Email field cannot be empty",
                              textScaleFactor: 1,
                              style: TextStyle(fontSize: 12, color: AppColors.kRed, fontFamily: AppStrings.fontSemiBold, letterSpacing: -0.2),
                            ),
                          ) else if(_emailError && notTyping)
                          Padding(
                            padding: const EdgeInsets.only(left: 28, top: 10),
                            child: Text(
                              "Email is incorrect",
                              textScaleFactor: 1,
                              style: TextStyle(fontSize: 12, color: AppColors.kRed, fontFamily: AppStrings.fontSemiBold, letterSpacing: -0.2),
                            ),
                          )
                        else
                          SizedBox(),

                      YMargin(25),
                      Container(
                        height: 55,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12)),
                        child: Transform.translate(
                          offset: Offset(0, 5),
                          child: TextField(
                            focusNode: _nodeText2,
                            onTap: () {
                              _nodeText2.requestFocus();
                            },
                            obscureText: obscureText,
                            onChanged: (value) {
                              setState(() {
                                _password = value;
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
                      YMargin(37),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: PrimaryButtonNew(
                          onTap: _password.length < 3
                              ? null
                              : () async {
                            HapticFeedback.lightImpact();
                            setState(() {
                              autoValidate = true;
                              notTyping = true;
                            });
                            if (_emailError || _email.isEmpty || _password == null) {
                              if(_email.isEmpty) {
                                isEmpty = true;
                              } else {
                                isEmpty = false;
                              }
                              setState(() {});
                              return;
                            }
                            if(_nodeText1.hasFocus || _nodeText2.hasFocus) {
                              _nodeText1.unfocus();
                              _nodeText2.unfocus();
                              await Future.delayed(Duration(milliseconds: 500));
                            }

                            EasyLoading.show(status: "");
                            var result = await _firebaseViewModel.loginCustomerWithEmail(
                                email: _email,
                                password: _password
                            );
                            EasyLoading.dismiss();
                            if (result.error) {
                              errorToastBar(context, message: result.errorMessage ??
                                  "Login failed",
                                  title: "Login error", alignToast: Alignment.topRight);
                            } else {
                              Navigator.of(context).pushReplacement(HomeControllerScreen.route());
                            }
                          },
                          title: "Log in",
                          width: MediaQuery.of(context).size.width,
                          fontBold: true,
                          fontSizePrimary: 15,
                          bg: AppColors.kWhite,
                          textColor: AppColors.kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
