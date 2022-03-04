import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:koloplan/data/view_models/firebase_view_model.dart';
import 'package:koloplan/data/view_models/identity_view_model.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/utils/validator.dart';
import 'package:koloplan/widgets/app_toast.dart';
import 'package:koloplan/widgets/buttons.dart';
import 'package:koloplan/widgets/password_widgets.dart';
import 'package:koloplan/widgets/splash_tap.dart';
import 'package:provider/provider.dart';

class EnterEmailPasswordWidget extends StatefulWidget {
  const EnterEmailPasswordWidget({
    Key key,
    this.onNext,
    this.onBack,
  }) : super(key: key);
  final Function onNext;
  final Function onBack;

  @override
  _EnterEmailPasswordWidgetState createState() => _EnterEmailPasswordWidgetState();
}

class _EnterEmailPasswordWidgetState extends State<EnterEmailPasswordWidget> with AfterLayoutMixin<EnterEmailPasswordWidget> {
  String _email = "";
  bool _emailError = false;
  bool autoValidate = false;
  bool isEmpty = false;
  bool notTyping = true;
  ABSFirebaseViewModel _firebaseViewModel;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool obscureText = true;
  String password = '';

  @override
  void afterFirstLayout(BuildContext context) {
    if(_firebaseViewModel.email.isNotEmpty) {
      setState(() {
        emailController.text = _firebaseViewModel.email;
      });
    }
    if(_firebaseViewModel.password.isNotEmpty) {
      setState(() {
        passwordController.text = _firebaseViewModel.password;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _firebaseViewModel = Provider.of(context);
    return GestureDetector(
      onTap: () {
        _nodeText1.unfocus();
        _nodeText2.unfocus();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(40),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12)),
                child: Transform.translate(
                  offset: Offset(0, 5),
                  child: TextField(
                    controller: emailController,
                    focusNode: _nodeText1,
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
                    padding: const EdgeInsets.only(top: 10, left: 8),
                    child: Text(
                      "Email field cannot be empty",
                      textScaleFactor: 1,
                      style: TextStyle(fontSize: 12, color: AppColors.kRed, fontFamily: AppStrings.fontNormal, letterSpacing: -0.2),
                    ),
                  ) else if(_emailError && notTyping)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 8),
                    child: Text(
                      "Email is incorrect",
                      textScaleFactor: 1,
                      style: TextStyle(fontSize: 12, color: AppColors.kRed, fontFamily: AppStrings.fontNormal, letterSpacing: -0.2),
                    ),
                  )
                else
                  SizedBox(),
              YMargin(25),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12)),
                child: Transform.translate(
                  offset: Offset(0, 5),
                  child: TextField(
                    controller: passwordController,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    focusNode: _nodeText2,
                    obscureText: obscureText,
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
                              // child: Text(obscureText ? "Show" : "Hide",
                              //     textScaleFactor: 1,
                              //     style: TextStyle(
                              //       color: Color(0xff989898).withOpacity(1),
                              //       fontSize: 12.8,
                              //       letterSpacing: -0.4,
                              //       height: 1.65,
                              //       fontFamily: AppStrings.fontSemiBold,
                              //     )),
                            ),
                          ),
                        )
                      // counterText: 'counter',
                    ),
                  ),
                ),
              ),
              YMargin(20),
              passwordController.text.isNotEmpty ?
              Container(
                color: Colors.transparent,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    passwordController.text.length >= 8
                        ? PasswordCheck(
                      title: '8+ characters',
                    )
                        : PasswordError(
                      title: '8+ characters',
                    ),
                    XMargin(5),
                    hasUpperCase(passwordController.text)
                        ? PasswordCheck(
                      title: 'Uppercase',
                      // flex: 3,
                    )
                        : PasswordError(
                      title: 'Uppercase',
                      // flex: 3,
                    ),
                    XMargin(5),
                    hasLowercase(passwordController.text)
                        ? PasswordCheck(
                      title: 'Lowercase',
                      // flex: 3,
                    )
                        : PasswordError(
                      title: 'Lowercase',
                      // flex: 3,
                    ),
                    XMargin(5),
                    hasSpecial(passwordController.text)
                        ? PasswordCheck(
                      title: '1 Special Character',
                      // flex: 3,
                    )
                        : PasswordError(
                      title: '1 Special Character',
                      // flex: 3,
                    ),
                    XMargin(5),
                    hasNum(passwordController.text)
                        ? PasswordCheck(
                      title: '1+ Number',
                    )
                        : PasswordError(
                      title: '1+ Number',
                    ),
                    XMargin(5),
                    passwordController.text == "" || passwordController.text == null ?
                    Container() :
                    passwordController.text.length <= 25
                        ? PasswordCheck(
                      title: '25 characters maximum',
                    )
                        : PasswordError(
                      title: '25 characters maximum',
                    ),
                  ],
                ),
              ) : Container(),
              YMargin(37),
              PrimaryButtonNew(
                onTap: !isValidPass(passwordController.text) ? null : () async {
                  setState(() {
                    autoValidate = true;
                    notTyping = true;
                  });
                  if (_emailError || emailController.text.isEmpty || !isValidPass(passwordController.text)) {
                    if(emailController.text.isEmpty) {
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
                  print("Authenticate email widget is ${emailController.text}");
                  var result = await _firebaseViewModel.authenticateUser(email: emailController.text);
                  EasyLoading.dismiss();
                  print("Auth result is $result");
                  if (!result) {
                    errorToastBar(context, message: "This email address already exists. Please try again with another email.",
                        title: "Error", alignToast: Alignment.topRight);
                  } else {
                    widget.onNext(emailController.text, passwordController.text);
                  }
                },
                title: "Next",
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
    );
  }

  String specialChar =
      r'^(?=.*?[)(\][)(|:};{?.="\u0027%!+<@>#\$/&*~^_-`,\u005C\u002D])';

  String oneNumber = r'^(?=.*?[0-9])';
  final caps1 = RegExp(r'^[a-zA-Z0-9]+$');
  final caps = RegExp(r'^(?=.*?[A-Z])', unicode: true);
  String upperCheck = r'[A-Z]';
  String lowerCheck = r'[a-z]';

  bool isValidPass(String password) {
    //print("regex $hasCaps $hasLower $hasSpecial ${password.length >= 8}");
    return hasSpecial(password) == true &&
        hasNum(password) == true && hasUpperCase(password) && hasLowercase(password) &&
        password.length >= 8 && password.length <=25;
  }

  bool hasNum(String password) {
    return RegExp(oneNumber, unicode: true).hasMatch(password);
  }

  bool hasUpperCase(String password) {
    return RegExp(upperCheck, unicode: true).hasMatch(password);
  }

  bool hasLowercase(String password) {
    return RegExp(lowerCheck, unicode: true).hasMatch(password);
  }

  bool hasSpecial(String password) {
    return RegExp(specialChar, unicode: true).hasMatch(password);
  }
}
