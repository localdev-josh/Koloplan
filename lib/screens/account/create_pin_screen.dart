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
import 'package:koloplan/screens/account/widgets/create_pin_widget.dart';
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

class CreatePinScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => CreatePinScreen(),
        settings:
        RouteSettings(name: CreatePinScreen().toStringShort()));
  }
  @override
  _CreatePinScreenState createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen>
    with AnimationMixin, AfterLayoutMixin<CreatePinScreen> {
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
                            height: 40,
                          ),
                          YMargin(35),
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
                                      height: 1.5,
                                      fontFamily: AppStrings.poppinsBold,
                                      color: Colors.white
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Create your\n'),
                                    TextSpan(
                                        text: 'Secret pin', style: TextStyle(color: AppColors.kPrimaryColor)),

                                  ]),
                            ),
                          ),
                          YMargin(15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text("Initiate transactions with your secret pin.\nPlease do not share with anyone.",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontFamily: AppStrings.fontNormal,
                                  height: 1.5,
                                  fontSize: 13.8,
                                  color: AppColors.kGreyText1)),
                          ),
                          Expanded(
                            child: Container(
                              child: CreatePinWidget()
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


