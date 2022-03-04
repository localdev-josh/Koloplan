import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koloplan/data/local_database/user_local.dart';
import 'package:koloplan/data/models/individual/secondary_state.dart';
import 'package:koloplan/screens/dashboard_controller/home_controller_screen.dart';
import 'package:local_auth/local_auth.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/buttons.dart';
import '../locator.dart';

typedef authCallBack = Function(bool authStatus);
class EnableFaceIdWidget extends StatefulWidget {
  final authCallBack onNext;
  final bool iosFaceId;
  final bool iosFingerPrint;
  final bool androidFaceId;
  final bool androidFingerPrint;
  const EnableFaceIdWidget({
    Key key,
    this.onNext,
    this.iosFaceId,
    this.iosFingerPrint,
    this.androidFaceId,
    this.androidFingerPrint
  }) : super(key: key);

  @override
  _EnableFaceIdWidgetState createState() => _EnableFaceIdWidgetState();
}

class _EnableFaceIdWidgetState extends State<EnableFaceIdWidget> {
  LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _authenticate() async {
    locator<ABSStateLocalStorage>().saveSecondaryState(
        SecondaryState.updateBiometrics(
            true,
            locator<ABSStateLocalStorage>()
                .getSecondaryState()));
    bool authenticated = false;
    try{
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: "Autheticate your koloplan account",
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
      if(_authorized.contains("Authorized")) {
        locator<ABSStateLocalStorage>().saveSecondaryState(
            SecondaryState.updateBiometrics(
                true,
                locator<ABSStateLocalStorage>()
                    .getSecondaryState()));
        widget.onNext(true);
      } else {
        locator<ABSStateLocalStorage>().saveSecondaryState(
            SecondaryState.updateBiometrics(
                false,
                locator<ABSStateLocalStorage>()
                    .getSecondaryState()));
        widget.onNext(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.kBlack,
                border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.1), width: 2),
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                YMargin(20),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.1), width: 1)),
                  child: Center(
                    child: SvgPicture.asset(Platform.isAndroid ? widget.androidFaceId && widget.androidFingerPrint == false ?
                    "assets/images/Android Face.svg" : widget.androidFingerPrint && widget.androidFaceId == false ?
                    "assets/images/fingerprint.svg" : "assets/images/Android Face.svg" : widget.iosFaceId && widget.iosFingerPrint == false ?
                    "assets/images/Face ID.svg" : widget.iosFingerPrint && widget.iosFaceId == false ?
                    "assets/images/fingerprint.svg" : "assets/images/Face ID.svg",
                      height: 50,
                      color: AppColors.kWhite,
                    ),
                  ),
                ),
                YMargin(27),
                Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(1.2, 0),
                      child: Text(Platform.isAndroid ? widget.androidFaceId && widget.androidFingerPrint == false ?
                      "Enable Face ID" : widget.androidFingerPrint && widget.androidFaceId == false ?
                      "Enable Fingerprint" : "Enable Authentication" : widget.iosFaceId && widget.iosFingerPrint == false ?
                      "Enable Face ID" : widget.iosFingerPrint && widget.iosFaceId == false ?
                      "Enable Fingerprint" : "Enable Authentication",
                          textScaleFactor: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: AppStrings.poppinsBold,
                              fontSize: 20.64,
                              color: AppColors.kPrimaryColor
                          )),
                    ),
                    Text(Platform.isAndroid ? widget.androidFaceId && widget.androidFingerPrint == false ?
                    "Enable Face ID" : widget.androidFingerPrint && widget.androidFaceId == false ?
                    "Enable Fingerprint" : "Enable Authentication" : widget.iosFaceId && widget.iosFingerPrint == false ?
                    "Enable Face ID" : widget.iosFingerPrint && widget.iosFaceId == false ?
                    "Enable Fingerprint" : "Enable Authentication",
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: AppStrings.poppinsBold,
                            fontSize: 20.64,
                            color: AppColors.kWhite
                        )),
                  ],
                ),
                YMargin(20),
                SizedBox(
                  width: 300,
                  child: Text(
                    "Enable ${Platform.isAndroid ? widget.androidFaceId && widget.androidFingerPrint == false ?
                    "Face ID" : widget.androidFingerPrint && widget.androidFaceId == false ?
                    "Fingerprint" : "Authentication" : widget.iosFaceId && widget.iosFingerPrint == false ?
                    "Face ID" : widget.iosFingerPrint && widget.iosFaceId == false ?
                    "Fingerprint" : "Authentication"} for easier authentication, "
                        "you can turn this off in the settings. ",
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: AppStrings.fontLight,
                        height: 1.6,
                        fontSize: 15,
                        color: AppColors.kWhite),
                  ),
                ),
                YMargin(30),
                PrimaryButtonNew(
                  onTap: () async {
                    await _authenticate();
                  },
                  title: "Yes",
                  width: 200,
                  textColor: AppColors.kSecondaryColor,
                  bg: AppColors.kBlack,
                  fontBold: true,
                  fontSizePrimary: 15,
                ),
                YMargin(10),
                PrimaryButtonNew(
                  onTap: () async {
                    locator<ABSStateLocalStorage>().saveSecondaryState(
                        SecondaryState.updateBiometrics(
                            false,
                            locator<ABSStateLocalStorage>()
                                .getSecondaryState()));
                    // Navigate to next page
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeControllerScreen()),
                            (Route<dynamic> route) => false);
                  },
                  title: "No",
                  width: 200,
                  textColor: AppColors.kGreyText,
                  bg: AppColors.kBlack,
                  // fontBold: true,
                  fontSizePrimary: 14,
                  height: 40,
                ),
                YMargin(20),
              ],
            ),
          )
        ],
      ),
    );
  }
}