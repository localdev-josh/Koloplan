import 'dart:io';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koloplan/components/page_transitions.dart';
import 'package:koloplan/data/local_database/user_local.dart';
import 'package:koloplan/data/models/individual/secondary_state.dart';
import 'package:koloplan/data/view_models/identity_view_model.dart';
import 'package:koloplan/screens/dashboard_controller/home_controller_screen.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/app_toast.dart';
import 'package:koloplan/widgets/face_id.dart';
import 'package:koloplan/widgets/splash_tap.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';


class CreatePinWidget extends StatefulWidget {
  const CreatePinWidget({
    Key key,
    this.onNext,
  }) : super(key: key);

  final Function onNext;

  @override
  _CreatePinWidgetState createState() => _CreatePinWidgetState();
}

class _CreatePinWidgetState extends State<CreatePinWidget> with SingleTickerProviderStateMixin {
  String pin1 = "";
  String pin2 = "";
  String pin3 = "";
  String pin4 = "";
  String pin5 = "";
  bool setOnce = false;
  bool verificationCodeLoading = false;
  ABSIdentityViewModel _identityViewModel;
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  bool _canCheckBiometric;
  List<BiometricType> _availableBiometrics;

  @override
  void initState() {
    super.initState();
    _checkBiometrics().whenComplete(() {
      if(_canCheckBiometric) {
        _getAvailableBiometrics();
      } else {
        setState(() {
          _canCheckBiometrics = false;
        });
      }
    });
  }

  Future<void> _checkBiometrics() async {
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

  Future<void> _getAvailableBiometrics() async {
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
      } else if(_availableBiometrics.contains(BiometricType.face)) {
        setState(() {
          _canCheckBiometrics = true;
        });
      } else if(_availableBiometrics.contains(BiometricType.iris)) {
        setState(() {
          _canCheckBiometrics = true;
        });
      } else {
        setState(() {
          _canCheckBiometrics = false;
        });
        print("Other local_auth not here");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _identityViewModel = Provider.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // color: AppColors.kSecondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(50),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 51,
                    decoration: pin1.isEmpty
                        ? BoxDecoration(
                        color: AppColors.kInputFieldBgLight,
                        border: Border.all(color: AppColors.kInputFieldBorder),
                        borderRadius: BorderRadius.circular(7))
                        : BoxDecoration(
                        color: AppColors.kInputFieldBg,
                        border: Border.all(color: AppColors.kInputFieldBorder),
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                      child: Text(
                        pin1,
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 22,
                            color: AppColors.kWhite,
                            // letterSpacing: ,
                            fontFamily: AppStrings.fontSemiBold,
                            height: 1.5),
                      ),
                    ),
                  ),
                ),
                XMargin(11),
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 51,
                    decoration: (pin1.isNotEmpty && pin2.isEmpty)
                        ? BoxDecoration(
                        color: AppColors.kInputFieldBgLight,
                        border: Border.all(color: AppColors.kInputFieldBorder),
                        borderRadius: BorderRadius.circular(7))
                        : BoxDecoration(
                        color: AppColors.kInputFieldBg,
                        border: Border.all(color: AppColors.kInputFieldBorder),
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                      child: Text(
                        pin2,
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 22,
                            color: AppColors.kWhite,
                            // letterSpacing: ,
                            fontFamily: AppStrings.fontSemiBold,
                            height: 1.5),
                      ),
                    ),
                  ),
                ),
                XMargin(11),
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 51,
                    decoration: (pin1.isNotEmpty &&
                            pin2.isNotEmpty &&
                            pin3.isEmpty)
                        ? BoxDecoration(
                        color: AppColors.kInputFieldBgLight,
                        border: Border.all(color: AppColors.kInputFieldBorder),
                        borderRadius: BorderRadius.circular(7))
                        : BoxDecoration(
                        color: AppColors.kInputFieldBg,
                        border: Border.all(color: AppColors.kInputFieldBorder),
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                      child: Text(
                        pin3,
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 22,
                            color: AppColors.kWhite,
                            // letterSpacing: ,
                            fontFamily: AppStrings.fontSemiBold,
                            height: 1.5),
                      ),
                    ),
                  ),
                ),
                XMargin(11),
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 51,
                    decoration: (pin1.isNotEmpty &&
                            pin2.isNotEmpty &&
                            pin3.isNotEmpty &&
                            pin4.isEmpty)
                        ? BoxDecoration(
                        color: AppColors.kInputFieldBgLight,
                        border: Border.all(color: AppColors.kInputFieldBorder),
                        borderRadius: BorderRadius.circular(7))
                        : BoxDecoration(
                        color: AppColors.kInputFieldBg,
                        border: Border.all(color: AppColors.kInputFieldBorder),
                        borderRadius: BorderRadius.circular(7)),
                    child: Center(
                      child: Text(
                        pin4,
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 22,
                            color: AppColors.kWhite,
                            // letterSpacing: ,
                            fontFamily: AppStrings.fontSemiBold,
                            height: 1.5),
                      ),
                    ),
                  ),
                ),
                XMargin(11),
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 51,
                    decoration: (pin1.isNotEmpty &&
                            pin2.isNotEmpty &&
                            pin3.isNotEmpty &&
                            pin4.isNotEmpty &&
                            pin5.isEmpty)
                        ? BoxDecoration(
                        color: AppColors.kInputFieldBgLight,
                        border: Border.all(color: AppColors.kInputFieldBorder),
                            borderRadius: BorderRadius.circular(7))
                        : BoxDecoration(
                        color: AppColors.kInputFieldBg,
                        border: Border.all(color: AppColors.kInputFieldBorder),
                            borderRadius: BorderRadius.circular(7)),
                    child: Center(
                      child: Text(
                        pin5,
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 22,
                            color: AppColors.kWhite,
                            // letterSpacing: ,
                            fontFamily: AppStrings.fontSemiBold,
                            height: 1.5),
                      ),
                    ),
                  ),
                ),
                XMargin(11),
              ],
            ),
          ),
          YMargin(50),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Splash(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      if (pin1.isEmpty) {
                        setState(() {
                          pin1 = "1";
                        });
                      } else if (pin2.isEmpty) {
                        setState(() {
                          pin2 = "1";
                        });
                      } else if (pin3.isEmpty) {
                        setState(() {
                          pin3 = "1";
                        });
                      } else if (pin4.isEmpty) {
                        setState(() {
                          pin4 = "1";
                        });
                      } else if (pin5.isEmpty) {
                        setState(() {
                          pin5 = "1";
                        });
                        confirmCode();
                      }
                    },
                    splashColor: AppColors.kWhite,
                    maxRadius: 30,
                    minRadius: 29.5,
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: BorderedText(
                          strokeColor: Colors.white,
                          // strokeColor: Color(0xff7F94C9),
                          strokeWidth: 1.5,
                          child: Text(
                            "1",
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                // color: Color(0xff7F94C9),
                                // letterSpacing: ,
                                fontFamily: AppStrings.fontSemiBold,
                                height: 1.5),
                            // style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Splash(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      if (pin1.isEmpty) {
                        setState(() {
                          pin1 = "2";
                        });
                      } else if (pin2.isEmpty) {
                        setState(() {
                          pin2 = "2";
                        });
                      } else if (pin3.isEmpty) {
                        setState(() {
                          pin3 = "2";
                        });
                      } else if (pin4.isEmpty) {
                        setState(() {
                          pin4 = "2";
                        });
                      } else if (pin5.isEmpty) {
                        setState(() {
                          pin5 = "2";
                        });
                        confirmCode();
                      }
                    },
                    splashColor: AppColors.kWhite,
                    maxRadius: 30,
                    minRadius: 29.5,
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: BorderedText(
                          // strokeColor: Color(0xff7F94C9),
                          strokeColor: Colors.white,
                          strokeWidth: 1.5,
                          child: Text(
                            "2",
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                // color: Color(0xff7F94C9),
                                fontFamily: AppStrings.fontSemiBold,
                                height: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Splash(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      HapticFeedback.lightImpact();
                      if (pin1.isEmpty) {
                        setState(() {
                          pin1 = "3";
                        });
                      } else if (pin2.isEmpty) {
                        setState(() {
                          pin2 = "3";
                        });
                      } else if (pin3.isEmpty) {
                        setState(() {
                          pin3 = "3";
                        });
                      } else if (pin4.isEmpty) {
                        setState(() {
                          pin4 = "3";
                        });
                      } else if (pin5.isEmpty) {
                        setState(() {
                          pin5 = "3";
                        });
                        confirmCode();
                      }
                    },
                    splashColor: AppColors.kWhite,
                    maxRadius: 30,
                    minRadius: 29.5,
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: BorderedText(
                          strokeColor: Colors.white,
                          strokeWidth: 1.5,
                          child: Text(
                            "3",
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                // letterSpacing: ,
                                fontFamily: AppStrings.fontSemiBold,
                                height: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Splash(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        if (pin1.isEmpty) {
                          setState(() {
                            pin1 = "4";
                          });
                        } else if (pin2.isEmpty) {
                          setState(() {
                            pin2 = "4";
                          });
                        } else if (pin3.isEmpty) {
                          setState(() {
                            pin3 = "4";
                          });
                        } else if (pin4.isEmpty) {
                          setState(() {
                            pin4 = "4";
                          });
                        } else if (pin5.isEmpty) {
                          setState(() {
                            pin5 = "4";
                          });
                          confirmCode();
                        }
                      },
                      splashColor: AppColors.kWhite,
                      maxRadius: 30,
                      minRadius: 29.5,
                      child: Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                          child: BorderedText(
                            strokeColor: Colors.white,
                            strokeWidth: 1.5,
                            child: Text(
                              "4",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  // letterSpacing: ,
                                  fontFamily: AppStrings.fontSemiBold,
                                  height: 1.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Splash(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        if (pin1.isEmpty) {
                          setState(() {
                            pin1 = "5";
                          });
                        } else if (pin2.isEmpty) {
                          setState(() {
                            pin2 = "5";
                          });
                        } else if (pin3.isEmpty) {
                          setState(() {
                            pin3 = "5";
                          });
                        } else if (pin4.isEmpty) {
                          setState(() {
                            pin4 = "5";
                          });
                        } else if (pin5.isEmpty) {
                          setState(() {
                            pin5 = "5";
                          });
                          confirmCode();
                        }
                      },
                      splashColor: AppColors.kWhite,
                      maxRadius: 30,
                      minRadius: 29.5,
                      child: Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                          child: BorderedText(
                            strokeColor: Colors.white,
                            strokeWidth: 1.5,
                            child: Text(
                              "5",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  // letterSpacing: ,
                                  fontFamily: AppStrings.fontSemiBold,
                                  height: 1.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Splash(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        if (pin1.isEmpty) {
                          setState(() {
                            pin1 = "6";
                          });
                        } else if (pin2.isEmpty) {
                          setState(() {
                            pin2 = "6";
                          });
                        } else if (pin3.isEmpty) {
                          setState(() {
                            pin3 = "6";
                          });
                        } else if (pin4.isEmpty) {
                          setState(() {
                            pin4 = "6";
                          });
                        } else if (pin5.isEmpty) {
                          setState(() {
                            pin5 = "6";
                          });
                          confirmCode();
                        }
                      },
                      splashColor: AppColors.kWhite,
                      maxRadius: 30,
                      minRadius: 29.5,
                      child: Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                          child: BorderedText(
                            strokeColor: Colors.white,
                            strokeWidth: 1.5,
                            child: Text(
                              "6",
                              textScaleFactor: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  // letterSpacing: ,
                                  fontFamily: AppStrings.fontSemiBold,
                                  height: 1.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Splash(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      if (pin1.isEmpty) {
                        setState(() {
                          pin1 = "7";
                        });
                      } else if (pin2.isEmpty) {
                        setState(() {
                          pin2 = "7";
                        });
                      } else if (pin3.isEmpty) {
                        setState(() {
                          pin3 = "7";
                        });
                      } else if (pin4.isEmpty) {
                        setState(() {
                          pin4 = "7";
                        });
                      } else if (pin5.isEmpty) {
                        setState(() {
                          pin5 = "7";
                        });
                        confirmCode();
                      }
                    },
                    splashColor: AppColors.kWhite,
                    maxRadius: 30,
                    minRadius: 29.5,
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: BorderedText(
                          strokeColor: Colors.white,
                          strokeWidth: 1.5,
                          child: Text(
                            "7",
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                // letterSpacing: ,
                                fontFamily: AppStrings.fontSemiBold,
                                height: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Splash(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      if (pin1.isEmpty) {
                        setState(() {
                          pin1 = "8";
                        });
                      } else if (pin2.isEmpty) {
                        setState(() {
                          pin2 = "8";
                        });
                      } else if (pin3.isEmpty) {
                        setState(() {
                          pin3 = "8";
                        });
                      } else if (pin4.isEmpty) {
                        setState(() {
                          pin4 = "8";
                        });
                      } else if (pin5.isEmpty) {
                        setState(() {
                          pin5 = "8";
                        });
                        confirmCode();
                      }
                    },
                    splashColor: AppColors.kWhite,
                    maxRadius: 30,
                    minRadius: 29.5,
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: BorderedText(
                          strokeColor: Colors.white,
                          strokeWidth: 1.5,
                          child: Text(
                            "8",
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                // letterSpacing: ,
                                fontFamily: AppStrings.fontSemiBold,
                                height: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Splash(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      if (pin1.isEmpty) {
                        setState(() {
                          pin1 = "9";
                        });
                      } else if (pin2.isEmpty) {
                        setState(() {
                          pin2 = "9";
                        });
                      } else if (pin3.isEmpty) {
                        setState(() {
                          pin3 = "9";
                        });
                      } else if (pin4.isEmpty) {
                        setState(() {
                          pin4 = "9";
                        });
                      } else if (pin5.isEmpty) {
                        setState(() {
                          pin5 = "9";
                        });
                        confirmCode();
                      }
                    },
                    splashColor: AppColors.kWhite,
                    maxRadius: 30,
                    minRadius: 29.5,
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: BorderedText(
                          strokeColor: Colors.white,
                          strokeWidth: 1.5,
                          child: Text(
                            "9",
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                // letterSpacing: ,
                                fontFamily: AppStrings.fontSemiBold,
                                height: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Splash(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      if (pin1.isEmpty) {
                        setState(() {
                          pin1 = "0";
                        });
                      } else if (pin2.isEmpty) {
                        setState(() {
                          pin2 = "0";
                        });
                      } else if (pin3.isEmpty) {
                        setState(() {
                          pin3 = "0";
                        });
                      } else if (pin4.isEmpty) {
                        setState(() {
                          pin4 = "0";
                        });
                      } else if (pin5.isEmpty) {
                        setState(() {
                          pin5 = "0";
                        });
                        confirmCode();
                      }
                    },
                    splashColor: AppColors.kWhite,
                    maxRadius: 30,
                    minRadius: 29.5,
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: BorderedText(
                          strokeColor: Colors.white,
                          strokeWidth: 1.5,
                          child: Text(
                            "0",
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                // letterSpacing: ,
                                fontFamily: AppStrings.fontSemiBold,
                                height: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Splash(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      if (pin5.isNotEmpty) {
                        pin5 = '';
                      } else if (pin4.isNotEmpty) {
                        pin4 = '';
                      } else if (pin3.isNotEmpty) {
                        pin3 = '';
                      } else if (pin2.isNotEmpty) {
                        pin2 = '';
                      } else if (pin1.isNotEmpty) {
                        pin1 = '';
                      }
                      setState(() {});
                    },
                    splashColor: AppColors.kWhite,
                    maxRadius: 30,
                    minRadius: 29.5,
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: Text("Delete",
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: AppColors.kRed4,
                          fontFamily: AppStrings.poppinsExtraBold,
                          fontSize: 16
                        ),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          YMargin(70)
        ],
      ),
    );
  }

  void confirmCode() async {
    if(_canCheckBiometrics == true) {
      showModalBottomSheet<Null>(
          context: context,
          builder: (BuildContext context) {
            return EnableFaceIdWidget(
              androidFaceId: Platform.isAndroid && _availableBiometrics.contains(BiometricType.face),
              androidFingerPrint: Platform.isAndroid && _availableBiometrics.contains(BiometricType.fingerprint),
              iosFaceId: Platform.isIOS && _availableBiometrics.contains(BiometricType.face),
              iosFingerPrint: Platform.isIOS && _availableBiometrics.contains(BiometricType.fingerprint),
              onNext: (bool authStatus) {
                successToastBar(context, message: "Secret pin created",
                    title: "Success", alignToast: Alignment.topRight);
                if(authStatus == true) {
                  locator<ABSStateLocalStorage>().saveSecondaryState(
                      SecondaryState.updateBiometrics(
                          true, locator<ABSStateLocalStorage>().getSecondaryState()));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeControllerScreen()),
                          (Route<dynamic> route) => false);
                } else {
                  locator<ABSStateLocalStorage>().saveSecondaryState(
                      SecondaryState.updateBiometrics(
                          false, locator<ABSStateLocalStorage>().getSecondaryState()));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeControllerScreen()),
                          (Route<dynamic> route) => false);
                }
              },
            );
          });
    } else {
      successToastBar(context, message: "Secret pin created",
          title: "Success", alignToast: Alignment.topRight);
      locator<ABSStateLocalStorage>().saveSecondaryState(
          SecondaryState.updateBiometrics(
              false, locator<ABSStateLocalStorage>().getSecondaryState()));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomeControllerScreen()),
              (Route<dynamic> route) => false);
    }
  }
}
