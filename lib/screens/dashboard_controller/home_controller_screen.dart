import 'dart:io';
import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koloplan/data/view_models/dashboard_view_model.dart';
import 'package:koloplan/screens/dashboard_controller/widgets/bottom_nav.dart';
import 'package:koloplan/components/linear_progress_loader.dart' as ProgressIndicator;
import 'package:koloplan/screens/dashboard_navigations/home_screen.dart';
import 'package:koloplan/screens/dashboard_navigations/portfolio_screen.dart';
import 'package:koloplan/screens/dashboard_navigations/notifications_screen.dart';
import 'package:koloplan/screens/dashboard_navigations/profile_screen.dart';
import 'package:koloplan/screens/dashboard_navigations/track_screen.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/widgets/app_toast.dart';
import 'package:provider/provider.dart';

class HomeControllerScreen extends StatefulWidget {
  final int tab;
  const HomeControllerScreen({
    Key key,
    this.tab = 0}) : super(key: key);
  static Route<dynamic> route(
      {bool newSignUp = false, Function handleMoreClicked, int tab = 0}) {
    return MaterialPageRoute(
      builder: (_) => HomeControllerScreen(tab: tab),
      settings: RouteSettings(
        name: HomeControllerScreen().toStringShort(),
      ),
    );
  }

  @override
  _HomeControllerScreenState createState() => _HomeControllerScreenState();

}

class _HomeControllerScreenState extends State<HomeControllerScreen> with AfterLayoutMixin<HomeControllerScreen>, SingleTickerProviderStateMixin {
  ABSDashboardViewModel dashboardViewModel;
  bool isLoading = false;
  int taps = 1;
  List<Widget> _screenWidgetList = [
    HomeScreen(),
    TrackFinanceScreen(),
    PortfolioScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: AppColors.kBlack,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
              systemNavigationBarColor: AppColors.kBlack300,
              systemNavigationBarIconBrightness: Brightness.light));
    }
  }

  void startProgressAnimation() {
    dashboardViewModel.setProgressLoader = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    dashboardViewModel.progressController.addListener(() {
      setState(() {
        dashboardViewModel.setProgressValue = dashboardViewModel.progressController.value;
      });
    });
  }



  @override
  void afterFirstLayout(BuildContext context) async {
    taps = 0;
  }

  @override
  Widget build(BuildContext context) {
    dashboardViewModel = Provider.of(context);
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColors.kBlack300,
          brightness: Brightness.dark,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      PageTransitionSwitcher(
                        duration: Duration(milliseconds: 500),
                        transitionBuilder:
                            (child, primaryAnimation, secondaryAnimation) =>
                            SharedAxisTransition(
                              animation: primaryAnimation,
                              secondaryAnimation: secondaryAnimation,
                              transitionType: SharedAxisTransitionType.horizontal,
                              child: child,
                              fillColor: AppColors.kBlack,
                            ),
                        child: _screenWidgetList[dashboardViewModel.selectedIndex],
                      ),
                      !dashboardViewModel.shouldReload ? Container() : Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: dashboardViewModel.screenInHome == true ? AppColors.kBlack.withOpacity(0.7) : Colors.grey.withOpacity(0.2),
                          padding: const EdgeInsets.only(top: 0),
                          child: ProgressIndicator.LinearProgressLoader(
                              key: Key("${dashboardViewModel.shouldReload}"),
                              value: dashboardViewModel.progressValue,
                              loopAround: dashboardViewModel.shouldReload,
                              showInCenter: dashboardViewModel.shouldReload,
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor)),
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Material(
                    elevation: 2,
                    color: AppColors.kBlack,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.kBlack300,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)
                            )
                          ),
                          // color: dashboardViewModel.selectedIndex == 0 ? AppColors.kBlack : AppColors.kSecondaryColor2,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: BottomNavEntry(
                                  onTap: () {
                                    if (Platform.isAndroid) {
                                      SystemChrome.setSystemUIOverlayStyle(
                                          SystemUiOverlayStyle(
                                              statusBarColor: AppColors.kBlack,
                                              statusBarIconBrightness: Brightness.light,
                                              statusBarBrightness: Brightness.light,
                                              systemNavigationBarColor: AppColors.kBlack300,
                                              systemNavigationBarIconBrightness: Brightness.light));
                                    }
                                    setState(() {
                                      dashboardViewModel.setShouldReload = false;
                                      dashboardViewModel.setScreenInHome = true;
                                      dashboardViewModel.setSelectedIndex = 0;
                                      if(dashboardViewModel.taps == 0 || dashboardViewModel.taps == 1) {
                                        taps++;
                                        dashboardViewModel.setTap =  taps;
                                      }
                                      // print("Widget double tap ${dashboardViewModel.taps}");
                                      if(dashboardViewModel.taps == 2) {
                                        dashboardViewModel.setShouldReload = !dashboardViewModel.shouldReload;
                                        dashboardViewModel.setProgressValue = dashboardViewModel.shouldReload ? null : 0;
                                      }
                                    });
                                  },
                                  animationDone: (bool onFinish) {
                                    if(!onFinish) {
                                      setState(() {
                                        taps = 1;
                                        dashboardViewModel.setTap =  1;
                                      });
                                    }
                                  },
                                  title: 'Home',
                                  image: dashboardViewModel.selectedIndex == 0 ? "Home_selected" : "Home",
                                  screenInHome: dashboardViewModel.screenInHome,
                                  isSelected: dashboardViewModel.selectedIndex == 0 ? true : false,
                                  homeDoubleTap: dashboardViewModel.taps == 2,
                                ),
                              ),
                              Expanded(
                                child: BottomNavEntry(
                                  onTap: () {
                                    if (Platform.isAndroid) {
                                      SystemChrome.setSystemUIOverlayStyle(
                                          SystemUiOverlayStyle(
                                              statusBarColor: AppColors.kBlack,
                                              statusBarIconBrightness: Brightness.light,
                                              statusBarBrightness: Brightness.light,
                                              systemNavigationBarColor: AppColors.kBlack300,
                                              systemNavigationBarIconBrightness: Brightness.light));
                                    }
                                    setState(() {
                                      dashboardViewModel.setShouldReload = false;
                                      dashboardViewModel.setScreenInHome = false;
                                      dashboardViewModel.setSelectedIndex = 1;
                                      taps = 0;
                                      dashboardViewModel.setTap =  0;
                                    });
                                  },
                                  title: 'Track',
                                  image: dashboardViewModel.selectedIndex == 1 ? "Track_selected" : "Track",
                                  screenInHome: dashboardViewModel.screenInHome,
                                  isSelected: dashboardViewModel.selectedIndex == 1 ? true : false,

                                  homeDoubleTap: false,
                                ),
                              ),
                              Expanded(
                                child: BottomNavEntry(
                                  onTap: () {
                                    if (Platform.isAndroid) {
                                      SystemChrome.setSystemUIOverlayStyle(
                                          SystemUiOverlayStyle(
                                              statusBarColor: AppColors.kBlack,
                                              statusBarIconBrightness: Brightness.light,
                                              statusBarBrightness: Brightness.light,
                                              systemNavigationBarColor: AppColors.kBlack300,
                                              systemNavigationBarIconBrightness: Brightness.light));
                                    }
                                    setState(() {
                                      dashboardViewModel.setShouldReload = false;
                                      dashboardViewModel.setScreenInHome = false;
                                      dashboardViewModel.setSelectedIndex = 2;
                                      taps = 0;
                                      dashboardViewModel.setTap =  0;
                                    });
                                  },
                                  title: 'Portfolio',
                                  image: "Market",
                                  screenInHome: dashboardViewModel.screenInHome,
                                  isSelected: dashboardViewModel.selectedIndex == 2 ? true : false,
                                  homeDoubleTap: false,
                                ),
                              ),
                              Expanded(
                                child: BottomNavEntry(
                                  onTap: () {
                                    if (Platform.isAndroid) {
                                      SystemChrome.setSystemUIOverlayStyle(
                                          SystemUiOverlayStyle(
                                              statusBarColor: AppColors.kBlack,
                                              statusBarIconBrightness: Brightness.light,
                                              statusBarBrightness: Brightness.light,
                                              systemNavigationBarColor: AppColors.kBlack300,
                                              systemNavigationBarIconBrightness: Brightness.light));
                                    }
                                    setState(() {
                                      dashboardViewModel.setShouldReload = false;
                                      dashboardViewModel.setScreenInHome = false;
                                      dashboardViewModel.setSelectedIndex = 3;
                                      taps = 0;
                                      dashboardViewModel.setTap =  0;
                                    });
                                  },
                                  title: 'Inbox',
                                  image: dashboardViewModel.selectedIndex == 3 ? "Notification_selected" : "Notification",
                                  screenInHome: dashboardViewModel.screenInHome,
                                  isSelected: dashboardViewModel.selectedIndex == 3 ? true : false,
                                  homeDoubleTap: false,
                                ),
                              ),
                              Expanded(
                                child: BottomNavEntry(
                                  onTap: () {
                                    if (Platform.isAndroid) {
                                      SystemChrome.setSystemUIOverlayStyle(
                                          SystemUiOverlayStyle(
                                              statusBarColor: AppColors.kBlack,
                                              statusBarIconBrightness: Brightness.light,
                                              statusBarBrightness: Brightness.light,
                                              systemNavigationBarColor: AppColors.kBlack300,
                                              systemNavigationBarIconBrightness: Brightness.light));
                                    }
                                    setState(() {
                                      dashboardViewModel.setShouldReload = false;
                                      dashboardViewModel.setScreenInHome = false;
                                      dashboardViewModel.setSelectedIndex = 4;
                                      taps = 0;
                                      dashboardViewModel.setTap =  0;
                                    });
                                  },
                                  title: 'Me',
                                  image: dashboardViewModel.selectedIndex == 4 ? "Profile_selected" : "Profile",
                                  screenInHome: dashboardViewModel.screenInHome,
                                  isSelected: dashboardViewModel.selectedIndex == 4 ? true : false,
                                  homeDoubleTap: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
