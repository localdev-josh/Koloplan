import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:koloplan/data/local_database/user_local.dart';
import 'package:koloplan/data/models/individual/secondary_state.dart';
import 'package:koloplan/data/view_models/dashboard_view_model.dart';
import 'package:koloplan/screens/account/login_screen.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/splash_tap.dart';
import 'package:provider/provider.dart';
import '../locator.dart';
import 'custom_rect_tween.dart';

class LogoutApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ABSDashboardViewModel dashboardViewModel = Provider.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: 'logout',
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              color: AppColors.kBlack,
              border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.3))
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    YMargin(25),
                    BorderedText(
                        strokeWidth: 0.1,
                        strokeColor: AppColors.kBlack.withOpacity(0.8),
                        child: Text(
                          'Logout',
                          textScaleFactor: 1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            decorationColor: AppColors.kBlack.withOpacity(0.8),
                            color: AppColors.kWhite.withOpacity(0.8),
                            fontSize: 18,
                            letterSpacing: -0.6,
                            fontFamily: AppStrings.poppinsBold,
                          ),
                        )),
                    YMargin(13),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Are you sure you want to logout?',
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.kWhite1,
                          fontSize: 14.1,
                          letterSpacing: -0.4,
                          height: 1.65,
                          fontFamily: AppStrings.fontLight,
                        ),
                      ),
                    ),
                    YMargin(25),
                    Container(
                      height: 1.5,
                        color: AppColors.kGreyText3.withOpacity(0.5)
                    ),
                    Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Splash(
                              onTap: () => Navigator.pop(context),
                              splashColor: AppColors.kGreyText2,
                              maxRadius: 25,
                              minRadius: 15,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border(
                                    right: BorderSide(color: AppColors.kGreyText3.withOpacity(0.5), width: 1.5)
                                  )
                                ),
                                child: Transform.translate(
                                  offset: Offset(0, -3),
                                  child: Center(
                                    child: Text(
                                      'No',
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xff858282),
                                        fontSize: 14.1,
                                        letterSpacing: -0.4,
                                        height: 1.65,
                                        fontFamily: AppStrings.fontNormal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Splash(
                              onTap: () {
                                _logout(context);
                                dashboardViewModel.setTap =  0;
                                dashboardViewModel.setShouldReload = false;
                                dashboardViewModel.setScreenInHome = true;
                                dashboardViewModel.setSelectedIndex = 0;
                              },
                              splashColor: AppColors.kGreyText2,
                              maxRadius: 25,
                              minRadius: 15,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                ),
                                child: Transform.translate(
                                  offset: Offset(0, -3),
                                  child: Center(
                                    child: Text(
                                      'Yes',
                                      textScaleFactor: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.kRed,
                                        fontSize: 14.5,
                                        letterSpacing: -0.4,
                                        height: 1.65,
                                        fontFamily: AppStrings.fontBold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    final box = Hive.box(AppStrings.state);
    final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
    box.put("user", null);
    SecondaryState state = SecondaryState(
        isLoggedIn: false,
        email: _localStorage.getSecondaryState().email,
        password: _localStorage.getSecondaryState().password);
    box.put("state", state);
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen(
              isLanding: false,
            )),
            (Route<dynamic> route) => false);
  }
}