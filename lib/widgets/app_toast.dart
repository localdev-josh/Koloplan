import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';
import 'package:koloplan/styles/colors.dart';

dynamic successToastBar(BuildContext context,
{AlignmentGeometry alignToast = Alignment.topCenter, String title = "Success",
  String message = ""}) {
  return AchievementView(
    context,
    title: "$title",
    subTitle: "$message",
    alignment: alignToast,
    color: AppColors.kGreen3,
    duration: Duration(milliseconds: 1000),
    isCircle: false,
    listener: (status) {
      print(status);
    },
  )..show();
}

dynamic errorToastBar(BuildContext context,
    {AlignmentGeometry alignToast = Alignment.topCenter, String title = "Error",
      String message = ""}) {
  return AchievementView(
    context,
    title: "$title",
    subTitle: "$message",
    alignment: alignToast,
    color: AppColors.kRed,
    icon: Icon(Icons.error, color: AppColors.kWhite),
    isCircle: false,
    listener: (status) {
      print(status);
    },
  )..show();
}