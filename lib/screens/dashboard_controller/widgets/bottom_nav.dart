import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koloplan/data/view_models/dashboard_view_model.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/splash_tap.dart';
import 'package:provider/provider.dart';

typedef animationCallback = Function(bool onFinish);
class BottomNavEntry extends StatefulWidget {
  /// [title] of the nav entry
  final String title;
  /// icon [image]
  final String image;
  /// [onTap] functionality
  final Function onTap;
  /// if the entry [isSelected] or not
  final bool isSelected;
  /// if the screen is on the homepage
  final bool screenInHome;
  /// reloads home after double tap
  final bool homeDoubleTap;
  final animationCallback animationDone;


  BottomNavEntry({
    this.onTap,
    this.title,
    this.image,
    this.isSelected,
    this.screenInHome = false,
    this.homeDoubleTap = false,
    this.animationDone
  });

  @override
  _BottomNavEntryState createState() => _BottomNavEntryState();
}

class _BottomNavEntryState extends State<BottomNavEntry> with TickerProviderStateMixin {
  ABSDashboardViewModel dashboardViewModel;
  Animation<Size> _animationFirst;
  AnimationController _animationControllerFirst;
  AnimationController controller;
  Animation<double> _animationScale;
  double value;
  bool isLoading = false;
  Animation<Size> animation;
  bool pulse = false;
  int taps = 0;

  _startAnimation() {
      controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
      controller.repeat(reverse: true);
      widget.animationDone(true);
      animation = SizeTween(begin: Size(0.2, 0.2), end: Size(4, 4)).animate(controller)
        ..addListener(() {
          Future.delayed(Duration(milliseconds: 600)).whenComplete(() {
            controller.dispose();
            widget.animationDone(false);
          });
        });

  }

  @override
  void initState() {
    super.initState();
    _animationControllerFirst = AnimationController(
        duration: Duration(milliseconds: 100), vsync: this);
    // _animationScale = Tween<double>(begin: 1.008, end: 1.0).animate(_controller);
    _animationFirst = SizeTween(begin: Size(26,26), end: Size(29,29)).animate(CurvedAnimation(
        parent: _animationControllerFirst, curve: Curves.decelerate));
    _animationControllerFirst.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationControllerFirst.reverse();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationControllerFirst.dispose();
  }


  @override
  Widget build(BuildContext context) {
    dashboardViewModel = Provider.of(context);
    if(widget.homeDoubleTap) {
      _startAnimation();
    }
    return Splash(
      onTap: () {
        // HapticFeedback.lightImpact();
        _animationControllerFirst.forward();
        widget.onTap();
      },
      // widget.screenInHome ?
      splashColor: Colors.transparent,
      maxRadius: 30,
      minRadius: 20,
      child: AnimatedContainer(
        color: Colors.transparent,
        alignment: Alignment.center,
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 29,
              width: 29,
              color: Colors.transparent,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  widget.homeDoubleTap ?
                  AnimatedBuilder(
                    animation: controller,
                    builder: (BuildContext context, Widget child) {
                      return Transform.rotate(
                        angle: animation.value.width,
                        child: SvgPicture.asset("assets/images/reloading.svg", width: 24, height: 24,
                        ));
                    }
                  ) :
                  Center(
                    child: SvgPicture.asset("assets/icons/${widget.image}.svg",
                      color: widget.isSelected ? AppColors.kWhite : AppColors.kGreyText2),
                  ),
                ],
              ),
            ),
            YMargin(5),
            AnimatedDefaultTextStyle(
                child: Text(widget.title),
                style: TextStyle(
                  color: widget.isSelected ? AppColors.kWhite : AppColors.kGreyText2,
                  fontFamily: AppStrings.fontNormal,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  fontSize: 11,
                ),
                duration: Duration(milliseconds: 200)),
          ],
        ),
      ),
    );
  }
}



// setState(() {
// dashboardViewModel.setShouldReload = !dashboardViewModel.shouldReload;
// dashboardViewModel.setProgressValue = dashboardViewModel.shouldReload ? null : 0;
// if (dashboardViewModel.shouldReload) {
// dashboardViewModel.progressController.stop(canceled: false);
// } else {
// dashboardViewModel.progressController.reset();
// dashboardViewModel.progressController.forward();
// }
// });