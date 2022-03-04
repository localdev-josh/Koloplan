import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';

import 'buttons.dart';

class FloatingModalWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const FloatingModalWidget({Key key, this.onTap, this.title = "", this.subtitle = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        // height: 300,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Column(
              children: [
                Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)
                        // borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(25),
                        //     topRight: Radius.circular(25))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            YMargin(20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: EdgeInsets.only(left: 0),
                                decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.kRed4
                                ),
                                child: IntrinsicWidth(
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(100),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Colors.transparent,
                                        ),
                                        height: 29,
                                        width: 29,
                                        padding: EdgeInsets.all(7),
                                        child: SvgPicture.asset("assets/images/Clear.svg", width: 10, height: 10,),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    Transform.translate(
                                      offset: Offset(1, -7),
                                      child: Text("$title",
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontFamily: AppStrings.poppinsExtraBold,
                                              fontSize: 20.64,
                                              color: AppColors.kPrimaryColor
                                          )),
                                    ),
                                    Transform.translate(
                                      offset: Offset(0, -7),
                                      child: Text("$title",
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontFamily: AppStrings.poppinsExtraBold,
                                              fontSize: 20.64,
                                              color: AppColors.kBlack
                                          )),
                                    ),
                                  ],
                                )
                            ),
                            YMargin(6),
                            RichText(
                              textScaleFactor: 1,
                              text: TextSpan(
                                style: TextStyle(
                                    fontFamily: AppStrings.fontLight,
                                    height: 1.6,
                                    fontSize: 14.5,
                                    color: AppColors.kBlack),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "$subtitle",
                                  ),
                                ],
                              ),
                            ),
                            YMargin(28),
                            PrimaryButtonNew(
                              textColor: AppColors.kWhite,
                              bg: AppColors.kSecondaryColor,
                              fontBold: true,
                              fontSizePrimary: 14,
                              width: MediaQuery.of(context).size.width,
                              title: "Create Account",
                              onTap: () {
                                Navigator.of(context).pop();
                                onTap();
                              },
                            ),
                            YMargin(20),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            Positioned(  top: -25, left: 20,
                child: Image.asset("assets/images/terms-and-conditions.png", width: 50, height: 60,)),
          ],
        )
      ),
    );
  }
}