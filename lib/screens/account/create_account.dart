import 'package:after_layout/after_layout.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/animator_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koloplan/data/view_models/dashboard_view_model.dart';
import 'package:koloplan/data/view_models/firebase_view_model.dart';
import 'package:koloplan/firebase_analytics/firebase_analytics_service.dart';
import 'package:koloplan/firebase_analytics/models/loggable_event.dart';
import 'package:koloplan/screens/account/widgets/enter_name_widget.dart';
import 'package:koloplan/screens/account/widgets/enter_phone_referral_widget.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/enums.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/splash_tap.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import '../../locator.dart';
import 'widgets/enter_email_password_widget.dart';
import 'package:koloplan/components/linear_progress_loader.dart' as ProgressIndicator;

class CreateAccountScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => CreateAccountScreen(),
        settings:
        RouteSettings(name: CreateAccountScreen().toStringShort()));
  }
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with AnimationMixin, AfterLayoutMixin<CreateAccountScreen> {
  ABSDashboardViewModel dashboardViewModel;
  Animation<double> size;
  double value = 0.111;
  // double value = 0.125;
  // 0.111;
  PageController pageController = PageController();
  ABSFirebaseViewModel _firebaseViewModel;
  int index = 0;
  final FirebaseAnalyticsService _firebaseAnalyticsService = locator<FirebaseAnalyticsService>();
  GlobalKey<AnimatorWidgetState> _animationKeyIn = GlobalKey<AnimatorWidgetState>();
  GlobalKey<AnimatorWidgetState> _animationKeyInSecond = GlobalKey<AnimatorWidgetState>();


  @override
  void afterFirstLayout(BuildContext context) {
    if(_animationKeyIn.currentState == null || _animationKeyInSecond.currentState == null) {
      return;
    } else {
      _animationKeyIn.currentState.forward();
      // Future.delayed(Duration(milliseconds: 600)).whenComplete(() {
      //   _animationKeyInSecond.currentState.forward();
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    controller.duration = Duration(milliseconds: 300);
    size = value.tweenTo(0.22).animatedBy(controller); // <-- connect tween and controller and apply to animation variable
    // size = value.tweenTo(0.25).animatedBy(controller); // <-- connect tween and controller and apply to animation variable
  }

  @override
  Widget build(BuildContext context) {
    _firebaseViewModel = Provider.of(context);
    dashboardViewModel = Provider.of(context);
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
                onTap: (){
                  // print("value is${size.value}");
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        child: Image.asset(
                          AppStrings.koloplanIllustrationFaint,
                          width: 220,
                        ),
                      ),
                    ),

                    SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // YMargin(10),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xff313030), width: 2),
                              ),
                              color: Colors.transparent
                            ),
                            height: 45,
                            child: Stack(
                              overflow: Overflow.visible,
                              children: [
                                Positioned(
                                  bottom: -2,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: LinearProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),
                                      backgroundColor: Colors.transparent,
                                      value: size.value,
                                      minHeight: 3.5,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      if(index != 0){
                                        goBack();
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
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
                                                        fontSize: 13.5
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
                                                      fontSize: 13.5
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          YMargin(35),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor: 1,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      decorationColor: AppColors.kWhite,
                                      fontSize: 21,
                                      height: 1.4,
                                      fontFamily: AppStrings.poppinsBold,
                                      color: Colors.white
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Create your '),
                                    TextSpan(
                                        text: 'account', style: TextStyle(color: AppColors.kPrimaryColor)),

                                  ]),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: PageView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: pageController,
                                children: [
                                  EnterNameWidget(
                                    onBack: () {
                                      if(index != 0){
                                        goBack();
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
                                    onNext: (first,last){
                                      setState(() {
                                        index = index +1;
                                        _firebaseViewModel.firstName = first;
                                        _firebaseViewModel.lastName = last;
                                        size = 0.111.tweenTo(0.22).animatedBy(controller);

                                        controller.reset();
                                      });
                                      controller.play();
                                      pageController.animateToPage(1,
                                          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                                      final analyticsEvent = UserEvent(
                                          "mobile_signup_enterFullName",
                                          userEvent: AppStrings.createAccountEvent,
                                          currentPage: "Create Account - Full Name",
                                          eventStatus: AnalyticsEventStatus.SUCCESSFUL
                                      );
                                      _firebaseAnalyticsService.logEvent(analyticsEvent);
                                    },
                                  ),

                                  EnterEmailPasswordWidget(
                                    onBack: () {
                                      _animationKeyIn.currentState.forward();
                                      if(index != 0){
                                        goBack();
                                      } else{
                                        Navigator.pop(context);
                                      }
                                    },
                                    onNext: (email, password){
                                      setState(() {
                                        index = index +1;
                                        _firebaseViewModel.email = email;
                                        _firebaseViewModel.password = password;
                                        size = 0.22.tweenTo(0.33).animatedBy(controller);
                                        controller.reset();
                                      });
                                      controller.play();
                                      pageController.animateToPage(2,
                                          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                                    },
                                  ),
                                  EnterPhoneReferralWidget(
                                    onBack: () {
                                      if(index != 0){
                                        goBack();
                                      } else{
                                        Navigator.pop(context);
                                      }
                                    },
                                    onNext: (referralCode, phoneNumber){
                                      setState(() {
                                        index = index +1;
                                        size = 0.33.tweenTo(0.44).animatedBy(controller);

                                        // size = 0.44.tweenTo(0.55).animatedBy(controller);
                                        // size = 0.5.tweenTo(0.625).animatedBy(controller);
                                        controller.reset();
                                      });
                                      controller.play();
                                      pageController.animateToPage(3,
                                          duration: Duration(milliseconds: 300), curve: Curves.easeIn);

                                      print("Got Number");
                                    }),
                                  // VerifCodeWidget(
                                  //     onNext: (){
                                  //       if(_animationKeyIn.currentState == null) {
                                  //         return;
                                  //       } else {
                                  //         _animationKeyIn.currentState.forward();
                                  //       }
                                  //       setState(() {
                                  //         index = index +1;
                                  //         size = 0.44.tweenTo(0.55).animatedBy(controller);
                                  //         // size = 0.88.tweenTo(1).animatedBy(controller);
                                  //         // size = 0.9.tweenTo(1.0).animatedBy(controller);
                                  //         controller.reset();
                                  //       });
                                  //       controller.play();
                                  //       pageController.animateToPage(4,
                                  //           duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                                  //     }
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    !dashboardViewModel.shouldReload ? Container() : Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: AppColors.kBlack,
                        padding: const EdgeInsets.only(top: 0),
                        child: ProgressIndicator.LinearProgressLoader(
                            key: Key("${dashboardViewModel.shouldReload}"),
                            value: dashboardViewModel.progressValue,
                            loopAround: dashboardViewModel.shouldReload,
                            showInCenter: dashboardViewModel.shouldReload,
                            backgroundColor: Colors.transparent,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA7453C))),
                      ),
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }

  bool goBack() {
    setState(() {
      var previousIndex = index;
      index = index -1;
      size = (0.125 * (previousIndex+1)).tweenTo(0.125 * (index+1)).animatedBy(controller);
      controller.reset();
    });
    controller.play();
    pageController.animateToPage( index.toInt(),
        duration: Duration(milliseconds: 500),curve: Curves.easeIn);
        return false;
  }


}


