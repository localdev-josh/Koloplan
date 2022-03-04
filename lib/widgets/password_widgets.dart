import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';

class PasswordCheck extends StatelessWidget {
  const PasswordCheck({
    Key key,
    this.title,
    this.flex = 2,
    this.marginTop,
  }) : super(key: key);
  final String title;
  final int flex;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.only(right: 12, bottom: 12, top: marginTop ?? 0),
          decoration: BoxDecoration(
              color: AppColors.kGreen4.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              SvgPicture.asset("assets/images/p_check.svg"),
              XMargin(5),
              Text(
                title,
                textScaleFactor: 1,
                style: TextStyle(fontSize: 9, fontFamily: AppStrings.fontNormal, color: AppColors.kWhite),
              ),
            ],
          )),
    );
  }
}

class PasswordError extends StatelessWidget {
  const PasswordError({
    Key key,
    this.title,
    this.errorColor,
    this.textColor,
    this.marginTop,
  }) : super(key: key);
  final String title;
  final Color errorColor;
  final Color textColor;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.only(right: 12, bottom: 12, top: marginTop ?? 0),
          decoration: BoxDecoration(
              color: errorColor ?? AppColors.kRed5.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              SvgPicture.asset("assets/images/p_error.svg"),
              XMargin(5),
              Text(
                title,
                textScaleFactor: 1,
                style: TextStyle(fontSize: 9, fontFamily: AppStrings.fontNormal, color: textColor ?? AppColors.kPrimaryBlueFaded),
              ),
            ],
          )),
    );
  }
}