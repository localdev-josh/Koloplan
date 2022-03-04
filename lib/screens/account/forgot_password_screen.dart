import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/animator_widget.dart';
import 'package:flutter_animator/widgets/attention_seekers/rubber_band.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:koloplan/data/view_models/identity_view_model.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/utils/validator.dart';
import 'package:koloplan/widgets/app_toast.dart';
import 'package:koloplan/widgets/buttons.dart';
import 'package:koloplan/widgets/splash_tap.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ForgotPasswordScreen(),
        settings: RouteSettings(name: ForgotPasswordScreen().toStringShort()));
  }

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with AfterLayoutMixin<ForgotPasswordScreen> {
  String _email = "";
  final FocusNode _nodeText1 = FocusNode();
  bool _emailError = false;
  bool loading = false;
  bool isEmpty = false;
  bool notTyping = true;
  GlobalKey<AnimatorWidgetState> _animationKey = GlobalKey<AnimatorWidgetState>();
  Timer _animationTimer;
  bool autoValidate = false;
  ABSIdentityViewModel _identityViewModel;

  var forgotPasswordDone = false;

  @override
  void afterFirstLayout(BuildContext context) {
    _animationTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      _animationKey.currentState.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationKey.currentState.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _identityViewModel = Provider.of(context);
    return Scaffold(
        backgroundColor: AppColors.kSecondaryColorDark,
        body: GestureDetector(
          onTap: () {
            _nodeText1.unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  child: Image.asset(
                    "assets/images/ball_basket.png",
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        forgotPasswordDone
                            ? Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              YMargin(15),
                              Splash(
                                onTap: () => Navigator.pop(context),
                                splashColor: AppColors.kWhite,
                                maxRadius: 25,
                                minRadius: 24.5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: BorderedText(
                                    strokeColor: AppColors.kPrimaryBlueFaded,
                                    strokeWidth: 0.1,
                                    child: Text(
                                      "Go back",
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 15.5,
                                          color: AppColors.kPrimaryBlueFaded,
                                          // letterSpacing: ,
                                          fontFamily: AppStrings.fontSemiBold,
                                          height: 1.5),
                                    ),
                                  ),
                                ),
                              ),
                              YMargin(65),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text("Please check your mailbox",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    decorationColor: AppColors.kWhite,
                                    color: AppColors.kWhite,
                                    fontSize: 24,
                                    letterSpacing: -1.2,
                                    fontFamily: AppStrings.fontSemiBold,
                                  ),),
                              ),
                              YMargin(19),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20),
                                child: Text(
                                  "We just sent you an email with a link to reset your password."
                                      " Kindly click on the link to reset your password.",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.kPrimaryBlueFaded.withOpacity(0.8),
                                      // letterSpacing: ,
                                      fontFamily: AppStrings.fontNormal,
                                      height: 1.6),
                                ),
                              ),
                            ],
                          ),
                        )
                            : buildEnterEmail(),
                        forgotPasswordDone ? YMargin(50) : YMargin(37),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: PrimaryButtonNew(
                              title: "Continue",
                              width: MediaQuery.of(context).size.width,
                              // loading: loading,
                              onTap: forgotPasswordDone
                                  ? () {
                                Navigator.of(context).push(LoginScreen.route(isLanding: true));
                              }
                                  : () async {
                                setState(() {
                                  autoValidate = true;
                                  notTyping = true;
                                });
                                print("Email error $_emailError");
                                if (_emailError || _email.isEmpty) {
                                  if(_email.isEmpty) {
                                    isEmpty = true;
                                  } else {
                                    isEmpty = false;
                                  }
                                  setState(() {});
                                  return;
                                }
                              }),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildEnterEmail() {
    return GestureDetector(
      onTap: () async {
        _nodeText1.unfocus();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(15),
            Splash(
              onTap: () async {
                if(_nodeText1.hasFocus) {
                  _nodeText1.unfocus();
                  await Future.delayed(Duration(milliseconds: 500));
                }
                Navigator.pop(context);
              },
              splashColor: AppColors.kWhite,
              maxRadius: 25,
              minRadius: 24.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BorderedText(
                  strokeColor: AppColors.kPrimaryBlueFaded,
                  strokeWidth: 0.1,
                  child: Text(
                    "Go back",
                    textScaleFactor: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15.5,
                        color: AppColors.kPrimaryBlueFaded,
                        // letterSpacing: ,
                        fontFamily: AppStrings.fontSemiBold,
                        height: 1.5),
                  ),
                ),
              ),
            ),
            YMargin(65),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Forgot password',
                        textScaleFactor: 1,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          decorationColor: AppColors.kWhite,
                          color: AppColors.kWhite,
                          fontSize: 24,
                          letterSpacing: -1.2,
                          fontFamily: AppStrings.fontSemiBold,
                        ),
                      ),
                      XMargin(10),
                      RubberBand(key: _animationKey, child: BorderedText(
                          strokeWidth: 1.4,
                          strokeColor: AppColors.kWhite,
                          // strokeColor: AppColors.kSubText,
                          child: Text(
                            '?',
                            textScaleFactor: 1,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              decorationColor: AppColors.kWhite,
                              color: AppColors.kWhite,
                              fontSize: 24.2,
                              letterSpacing: -1.2,
                              fontFamily: AppStrings.fontSemiBold,
                            ),
                          ))
                      ),
                    ],
                  ),
                  YMargin(10),
                  Text(
                    'It\'s alright to forget things, provide email used in signing up',
                    textScaleFactor: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.kPrimaryBlueFaded.withOpacity(0.8),
                        // letterSpacing: ,
                        fontFamily: AppStrings.fontNormal,
                        height: 1.6),
                  ),
                ],
              ),
            ),
            YMargin(45),

            Container(
              height: 58,
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
                      labelStyle: TextStyle(fontFamily: AppStrings.fontNormal, color: AppColors.kInputFieldTextColor, fontSize: 14),
                      hintText: 'Enter your email address',
                      hintStyle: TextStyle(fontFamily: AppStrings.fontNormal, color: AppColors.kInputFieldTextColor, fontSize: 14)
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
                    style: TextStyle(fontSize: 12, color: AppColors.kRed, fontFamily: AppStrings.fontNormal, letterSpacing: -0.2),
                  ),
                ) else if(_emailError && notTyping)
              Padding(
                padding: const EdgeInsets.only(left: 28, top: 10),
                child: Text(
                  "Email is incorrect",
                  textScaleFactor: 1,
                  style: TextStyle(fontSize: 12, color: AppColors.kRed, fontFamily: AppStrings.fontNormal, letterSpacing: -0.2),
                ),
              )
            else
              SizedBox(),
          ],
        ),
      ),
    );
  }
}
