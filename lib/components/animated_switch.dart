import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/strings.dart';

class AnimatedSwitch extends StatelessWidget {
  final bool status;
  final String title;

  final Function toggle;

  const AnimatedSwitch({Key key, this.status = false, this.toggle, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggle(!status);
      },
      child: Transform.translate(
        offset: Offset(0,0),
        child: Container(
          color: Colors.transparent,
          // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: FlutterSwitch(
            width: 40.0,
            height: 22.0,
            toggleSize: 15.0,
            value: status,
            borderRadius: 30.0,
            padding: 2.0,
            activeToggleColor: AppColors.kWhite,
            inactiveToggleColor: AppColors.kPrimaryColor,
            activeSwitchBorder: Border.all(
              color: Color(0xFF3C1E70),
              width: 0.0,
            ),
            inactiveSwitchBorder: Border.all(
              color: Color(0xFFD1D5DA),
              width: 0.0,
            ),
            activeColor: AppColors.kPrimaryColor,
            inactiveColor: AppColors.kGrey,
            activeIcon: Icon(
              Icons.check,
              color: AppColors.kPrimaryColor,
              size: 11,
            ),
            inactiveIcon: Icon(
              Icons.clear,
              color: Colors.white,
              size: 11,
            ),
            onToggle: (val) {
              toggle(val);
            },
          ),
        ),
      ),
    );
  }
}