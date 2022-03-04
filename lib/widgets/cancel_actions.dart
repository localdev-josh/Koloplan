import 'package:flutter/material.dart';
import 'package:koloplan/screens/dashboard_controller/home_controller_screen.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/buttons.dart';

class CancelAction extends StatelessWidget {
  final bool goToTab;
  final Widget routePage;

  CancelAction({Key key, this.goToTab = true, this.routePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidth = (MediaQuery.of(context).size.width - 110) / 2;
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          YMargin(10),
          Center(
            child: Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          ),
          YMargin(20),
          Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YMargin(20),
                    Text(
                      "Cancel",
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: AppStrings.fontSemiBold,
                      ),
                    ),
                    YMargin(25),
                    Text(
                      "Are you sure you want to cancel this operation",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: AppColors.kGreyText,
                          fontFamily: AppStrings.fontNormal),
                    ),
                    YMargin(45),
                    Row(
                      children: [
                        PrimaryButtonNew(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          textColor: AppColors.kPrimaryColor,
                          bg: AppColors.kPrimaryColor.withOpacity(0.2),
                          width: buttonWidth,
                          title: "No",
                        ),
                        XMargin(
                          20,
                        ),
                        PrimaryButtonNew(
                          width: buttonWidth,
                          title: "Yes",
                          onTap: () async {
                            if (goToTab) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeControllerScreen()),
                                      (Route<dynamic> route) => false);
                              Future.delayed(Duration(seconds: 1)).then((value) {
                                /// Delete cached data
                              });
                            } else {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => routePage),
                                      (Route<dynamic> route) => false);
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )),
          YMargin(30)
        ],
      ),
    );
  }
}
