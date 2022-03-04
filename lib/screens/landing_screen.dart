import 'dart:async';
import 'dart:io';
import 'package:after_layout/after_layout.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koloplan/data/view_models/firebase_view_model.dart';
import 'package:provider/provider.dart';
import 'package:koloplan/data/view_models/dashboard_view_model.dart';
import 'package:koloplan/firebase_analytics/firebase_analytics_service.dart';
import 'package:koloplan/firebase_analytics/models/loggable_event.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/buttons.dart';
import 'package:koloplan/widgets/splash_tap.dart';
import '../locator.dart';
import 'account/create_account.dart';
import 'account/login_screen.dart';

class LandingScreen extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const LandingScreen({Key key, this.screenWidth, this.screenHeight}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin, AfterLayoutMixin<LandingScreen> {
  final FirebaseAnalyticsService _firebaseAnalyticsService = locator<FirebaseAnalyticsService>();
  ABSFirebaseViewModel _firebaseViewModel;
  ABSDashboardViewModel dashboardViewModel;
  AnimationController controller;
  Animation<double> heartbeatAnimation;
  bool drawLogo = false;
  Timer _animationTimer;

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void initState() {
    super.initState();

    drawLogo = true;
    if(Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          // statusBarColor: AppColors.kWhite,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.kBlack,
          systemNavigationBarIconBrightness: Brightness.light));
    }
    /// Translate koloplan background image(offset)
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 6000));
    heartbeatAnimation = Tween<double>(begin: 1, end: 5).animate(controller);
    setState(() {
      controller.forward();
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse().whenComplete(() {
            Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
              controller.forward();
            });
          });
        }
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _firebaseViewModel = Provider.of(context);
    dashboardViewModel = Provider.of(context);
    final height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
        animation: heartbeatAnimation,
        builder: (context, widget) {
      return Scaffold(
        backgroundColor: AppColors.kBlack,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(top: 220),
                child: Transform.translate(
                  offset: Offset(0, heartbeatAnimation.value),
                  child: Image.asset(
                    AppStrings.koloplanIllustration,
                    fit: BoxFit.cover,
                    width: 220,
                    // height: 250,
                  ),
                ),
              ),
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [
                      AppColors.kBlack,
                      Colors.transparent,
                    ],
                    stops: [0.0,  0.8],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    // tileMode: TileMode.repeated
                  )
              ),
            ),
            //
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 60),
                child: Image.asset(AppStrings.koloplanLogo, width: 102),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: height * 0.78,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.red,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // SvgPicture.asset("images/new/zed.svg", height: 45),
                          YMargin(46),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            textScaleFactor: 1,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    decorationColor: AppColors.kWhite,
                                    fontSize: 21,
                                    height: 1.43,
                                    fontFamily: AppStrings.poppinsExtraBold,
                                    color: Colors.white
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Leap into the world of\n'),
                                  TextSpan(
                                      text: 'Finance management', style: TextStyle(color: AppColors.kPrimaryColor)),

                                ]),
                          ),
                          YMargin(15)
                        ],
                      ),
                    ),
                  ),
                ),
                YMargin(30),
                PrimaryButtonNew(
                  onTap: () {
                    _firebaseViewModel.email = "";
                    _firebaseViewModel.password = "";
                    _firebaseViewModel.firstName = "";
                    _firebaseViewModel.lastName = "";
                    _firebaseViewModel.phoneNumber = "";
                    final analyticsEvent = UserEvent(
                        "mobile_initializeSignUp",
                        userEvent: AppStrings.trackPageEvent,
                        currentPage: "Initialize Create Account Screen");
                    _firebaseAnalyticsService.logEvent(analyticsEvent);
                    HapticFeedback.lightImpact();
                    Navigator.of(context).push(CreateAccountScreen.route());
                  },
                  title: "Start",
                  width: MediaQuery.of(context).size.width - 50,
                  fontBold: true,
                  fontSizePrimary: 15,
                  bg: AppColors.kSecondaryColor,
                  textColor: AppColors.kWhite,
                ),
                Expanded(
                  child: Column(
                    children: [
                      YMargin(15),
                      Splash(
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
                                      fontFamily: AppStrings.poppinsBold,
                                      color: AppColors.kWhite1,
                                      fontSize: 13
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Have an Account? '),
                                    TextSpan(
                                        text: 'Sign In', style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 14)),

                                  ]),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
