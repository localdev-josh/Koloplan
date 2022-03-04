import 'package:flutter/material.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/strings.dart';

class AppStyles {
  static TextStyle menuFlatStyle =
      TextStyle(fontSize: 12, color: AppColors.kLightTitleText);
  static TextStyle sectionHeader = TextStyle(
      fontSize: 16,
      fontFamily: "Caros-Bold",
      color: AppColors.kAccountTextColor);
  static TextStyle sectionContent =
      TextStyle(fontSize: 10, height: 1.7, color: AppColors.kAccountTextColor);
  static TextStyle tinyTitle = TextStyle(
      color: AppColors.kLightText, fontSize: 10, letterSpacing: -0.08);

  static BorderSide menuBorder =
      BorderSide(color: Color(0xFF324d53), width: 0.3);

  static double questionTitleSize = 18;

  static TextStyle questionTitleStyle = TextStyle(
      fontFamily: AppStrings.fontSemiBold,
      color: AppColors.kTextColor,
      fontSize: AppStyles.questionTitleSize);

  static TextStyle questionSubtitleStyle = TextStyle(
      fontSize: 13,
      color: AppColors.kTextColor,
      fontFamily: AppStrings.fontNormal);

  static TextStyle linkTextStyle = TextStyle(
      fontSize: 13.5,
      color: AppColors.kPrimaryBlueFaded,
      fontFamily: AppStrings.fontNormal);

  static TextStyle pageTitleStyle = TextStyle(
    fontFamily: AppStrings.fontSemiBold,
    letterSpacing: 0,
    fontSize: 24,
    color: AppColors.kWhite,
  );
}
