import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/animator_widget.dart';
import 'package:flutter_animator/widgets/attention_seekers/bounce.dart';
import 'package:flutter_animator/widgets/attention_seekers/heart_beat.dart';
import 'package:flutter_animator/widgets/attention_seekers/swing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/splash_tap.dart';

class BottomNavEntry extends StatefulWidget {
  // title of the nav entry
  final String title;
  // icon image
  final String image;
  // onTap functionality
  final Function onTap;
  // if the entry is selected or not
  final bool isSelected;

  BottomNavEntry({
    this.onTap,
    this.title,
    this.image,
    this.isSelected,
  });

  @override
  _BottomNavEntryState createState() => _BottomNavEntryState();
}

class _BottomNavEntryState extends State<BottomNavEntry> {
  GlobalKey<AnimatorWidgetState> _animationKeyIn = GlobalKey<AnimatorWidgetState>();

  // @override
  // void initState() {
  //   super.initState();
  //   if(_animationKeyIn.currentState == null) {
  //     return;
  //   } else {
  //     _animationKeyIn.currentState.forward();
  //   }
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _animationKeyIn.currentState.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Splash(
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onTap();
          if(_animationKeyIn.currentState == null) {
            return;
          } else {
            _animationKeyIn.currentState.forward();
          }
        },
        splashColor: Colors.transparent,
        maxRadius: 35,
        minRadius: 20,
        child: AnimatedContainer(
          color: Colors.white,
          alignment: Alignment.center,
          duration: Duration(milliseconds: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HeartBeat(key: _animationKeyIn,
                  preferences: AnimationPreferences(
                      magnitude: 0.5
                  ),
                  child: SvgPicture.asset("assets/icons/${widget.image}.svg",
                      width: 27,
                      color: widget.isSelected ? AppColors.kWhite :
                      AppColors.kLightTitleText2
                  )),
              YMargin(7),
              AnimatedDefaultTextStyle(child: Text(widget.title,
                    textScaleFactor: 1,
                  ),
                  style: TextStyle(
                  color: widget.isSelected ? AppColors.kWhite: AppColors.kLightTitleText,
                  fontFamily: AppStrings.fontNormal,
                  fontSize: 11.3,
              ),
                  duration: Duration(milliseconds: 500))

            ],
          ),
        ),
      ),
    );
  }
}
