import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koloplan/components/page_transitions.dart';
import 'package:koloplan/data/view_models/firebase_view_model.dart';
import 'package:koloplan/firebase_analytics/firebase_analytics_service.dart';
import 'package:koloplan/firebase_analytics/models/loggable_event.dart';
import 'package:koloplan/screens/account/login_screen.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/enums.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/app_toast.dart';
import 'package:koloplan/widgets/buttons.dart';
import 'package:koloplan/widgets/floating_bottom_modal.dart';
import 'package:koloplan/widgets/password_widgets.dart';
import 'package:provider/provider.dart';
import '../../../locator.dart';
import '../create_pin_screen.dart';

class EnterPhoneReferralWidget extends StatefulWidget {
  const EnterPhoneReferralWidget({
    Key key,
    this.onNext,
    this.onBack,
  }) : super(key: key);
  final Function onNext;
  final Function onBack;

  @override
  _EnterPhoneReferralWidgetState createState() => _EnterPhoneReferralWidgetState();
}

class _EnterPhoneReferralWidgetState extends State<EnterPhoneReferralWidget> with AfterLayoutMixin<EnterPhoneReferralWidget> {
  String phoneNumber = "";
  String referralCode = '';
  bool autoValidate = false;
  bool loading = false;
  ABSFirebaseViewModel _firebaseViewModel;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FirebaseAnalyticsService _firebaseAnalyticsService = locator<FirebaseAnalyticsService>();

  @override
  void afterFirstLayout(BuildContext context) {
    if(_firebaseViewModel.phoneNumber.isNotEmpty) {
      setState(() {
        phoneNumberController.text = _firebaseViewModel.phoneNumber;
      });
    }
    if(_firebaseViewModel.referralCode.isNotEmpty) {
      setState(() {
        referralCodeController.text = _firebaseViewModel.referralCode;
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
              YMargin(45),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Container(
                      height: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      // margin: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                      decoration: BoxDecoration(
                          color: Color(0xff0C1B40),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          )),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/nigeria.svg", width: 15, height: 15),
                          XMargin(5),
                          Text(
                            "+234",
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: AppColors.kInputFieldTextColor
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Transform.translate(
                        offset: Offset(0, 0),
                        child: TextField(
                          controller: phoneNumberController,
                          onChanged: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                          focusNode: _nodeText1,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 15),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.kInputFieldBg,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12)),
                                borderSide: BorderSide(color: Color(0xff1B2D58), width: 1.0)
                                // borderSide: BorderSide(color: Color(0xff1B2D58), width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                                borderSide: BorderSide(color: AppColors.kPrimaryColorLight.withOpacity(0.6), width: 1.5),
                              ),
                              labelText: 'Phone number',
                              labelStyle: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 14),
                              hintText: 'Enter your phone number',
                              hintStyle: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 14)
                            // counterText: 'counter',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              phoneNumberController.text.length != 11 ?
              phoneNumberController.text.length != 0 ?
                  Container()
                  : Container() : Container(),
              phoneNumberController.text.length != 0 ?
              !hasSpecial(phoneNumberController.text)
                  ? PasswordCheck(
                title: 'Digits only',
                marginTop: 15,
              )
                  : PasswordError(
                title: 'Digits only',
                errorColor: AppColors.kRed,
                textColor: AppColors.kWhite,
                marginTop: 15,
              ) : Container(),
              phoneNumberController.text.length != 0 ? YMargin(10) : YMargin(25),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                      child: Transform.translate(
                        offset: Offset(0, 5),
                        child: TextField(
                          controller: referralCodeController,
                          onChanged: (value) {
                            setState(() {
                              referralCode = value;
                            });
                          },
                          focusNode: _nodeText2,
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
                              labelText: 'Referral code (optional)',
                              labelStyle: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 14),
                              hintText: 'Enter a referral code',
                              hintStyle: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 14)
                            // counterText: 'counter',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              YMargin(37),
              PrimaryButtonNew(
                onTap: phoneNumberController.text.length != 11 || !isValidNumber(phoneNumberController.text) ? null : () async {
                  if (loading) {
                    return;
                  }
                  setState(() {
                    autoValidate = true;
                  });
                  if (phoneNumberController.text.length != 11) {
                    return;
                  }
                  _firebaseViewModel.phoneNumber = phoneNumber;
                  _firebaseViewModel.referralCode = referralCode;

                  final analyticsEvent = UserEvent(
                    "mobile_signup_enterPhoneNumber",
                    userEvent: AppStrings.createAccountEvent,
                    currentPage: "Create Account - Phone Number",
                    eventStatus: AnalyticsEventStatus.SUCCESSFUL,
                  );
                  if(_firebaseViewModel.referralCode.isEmpty) {
                    final analyticsEvent = UserEvent(
                        "mobile_signup_notReferred",
                        userEvent: AppStrings.createAccountEvent,
                        currentPage: "Create Account - Referral code",
                        eventStatus: AnalyticsEventStatus.SUCCESSFUL
                    );
                    _firebaseAnalyticsService.logEvent(analyticsEvent);
                  } else {
                    final analyticsEvent = UserEvent(
                        "mobile_signup_referred",
                        userEvent: AppStrings.createAccountEvent,
                        currentPage: "Create Account - Referral code",
                        eventStatus: AnalyticsEventStatus.SUCCESSFUL
                    );
                    _firebaseAnalyticsService.logEvent(analyticsEvent);
                  }
                  _firebaseAnalyticsService.logEvent(analyticsEvent);

                  if(_nodeText1.hasFocus || _nodeText2.hasFocus) {
                    _nodeText1.unfocus();
                    _nodeText2.unfocus();
                    await Future.delayed(Duration(milliseconds: 500));
                  }

                  showModalBottomSheet<Null>(
                      context: context,
                      builder: (BuildContext modalContext) {
                        return FloatingModalWidget(
                          title: "Terms and condition",
                          subtitle: "By clicking create account, you agree to our Terms and conditions.",
                          onTap: () async {
                            EasyLoading.show();
                            var registerResult = await _firebaseViewModel.registerCustomerWithEmail(
                              email: _firebaseViewModel.email,
                              password: _firebaseViewModel.password,
                              firstName: _firebaseViewModel.firstName,
                              lastName: _firebaseViewModel.lastName,
                              phoneNumber: _firebaseViewModel.phoneNumber,
                              referralCode: _firebaseViewModel.referralCode,
                            );
                            if(!registerResult.error) {
                              Future.delayed(Duration(milliseconds: 1000)).whenComplete(() async {
                                var loginResult = await _firebaseViewModel.loginCustomerWithEmail(
                                  email: _firebaseViewModel.email,
                                  password: _firebaseViewModel.password,
                                );
                                EasyLoading.dismiss();
                                if(!loginResult.error) {
                                  successToastBar(context, message: "Profile created",
                                      title: "Success", alignToast: Alignment.topRight);
                                  Navigator.pushAndRemoveUntil(
                                      context, FadeRoute(page: CreatePinScreen()), (Route<dynamic> route) => false);
                                } else {
                                  errorToastBar(context, message: "${loginResult.errorMessage}" ?? "Login failed. Kindly try again later",
                                      title: "Login Error", alignToast: Alignment.topRight);
                                  Navigator.pushAndRemoveUntil(
                                      context, FadeRoute(page: LoginScreen()), (Route<dynamic> route) => false);
                                }
                              });
                            } else {
                              EasyLoading.dismiss();
                              errorToastBar(context, message: "${registerResult.errorMessage}" ?? "User registration failed. Kindly try again later",
                                  title: "Registration Error", alignToast: Alignment.topRight);
                            }
                          },
                        );
                      },
                      isScrollControlled: true,
                      isDismissible: true);
                },
                title: "Create account",
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

  String upperCheck = r'[A-Z]';
  String lowerCheck = r'[a-z]';

  bool isValidNumber(String number) {
    return hasSpecial(number) == false && hasUpperCase(number) == false && hasLowercase(number) == false;
  }

  bool hasSpecial(String number) {
    return RegExp(specialChar, unicode: true).hasMatch(number);
  }

  bool hasUpperCase(String number) {
    return RegExp(upperCheck, unicode: true).hasMatch(number);
  }

  bool hasLowercase(String number) {
    return RegExp(lowerCheck, unicode: true).hasMatch(number);
  }
}
