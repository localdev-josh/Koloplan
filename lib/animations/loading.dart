import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koloplan/styles/colors.dart';

class LoadingWIdget extends StatefulWidget {
  const LoadingWIdget({
    Key key, this.secondaryColor = true, this.iconSize = 70,
    this.loaderOpacity = 1.0
  }) : super(key: key);

  final bool secondaryColor;
  final double iconSize;
  final double loaderOpacity;


  @override
  _LoadingWIdgetState createState() => _LoadingWIdgetState();
}

class _LoadingWIdgetState extends State<LoadingWIdget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.repeat(reverse: true);
    animation = Tween(begin: 0.2, end: 0.5).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  void _startAnimation() {
    controller.stop();
    controller.reset();
    controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: widget.secondaryColor ? AppColors.kInputFieldBgLight : AppColors.kBottomNav,
          borderRadius: BorderRadius.circular(7)),
      child: Center(
        child: Stack(
          children: [
            SizedBox(
              height: widget.iconSize,
              width: widget.iconSize,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),

              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Transform.scale(
                  scale: animation.value,
                  child: SvgPicture.asset("assets/logos/kolo_icon.svg")),
            )
          ],
        ),
      ),
    );
  }
}

class LoadingWIdgetOpacity extends StatefulWidget {
  const LoadingWIdgetOpacity({
    Key key, this.secondaryColor = true, this.iconSize = 70,
    this.loaderOpacity = 1.0
  }) : super(key: key);

  final bool secondaryColor;
  final double iconSize;
  final double loaderOpacity;


  @override
  _LoadingWIdgetOpacityState createState() => _LoadingWIdgetOpacityState();
}

class _LoadingWIdgetOpacityState extends State<LoadingWIdgetOpacity>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.repeat(reverse: true);
    animation = Tween(begin: 0.2, end: 0.5).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  void _startAnimation() {
    controller.stop();
    controller.reset();
    controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: widget.secondaryColor ? AppColors.kSecondaryColor : AppColors.kBottomNav,
            borderRadius: BorderRadius.circular(7)),
        child: Center(
          child: Stack(
            children: [
              SizedBox(
                height: widget.iconSize,
                width: widget.iconSize,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),

                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Transform.scale(
                    scale: animation.value,
                    child: SvgPicture.asset("assets/logos/kolo_icon.svg")),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class LoadingWIdgetSmall extends StatefulWidget {
  const LoadingWIdgetSmall({
    Key key, this.secondaryColor = true, this.iconSize = 70,
    this.loaderOpacity = 1.0
  }) : super(key: key);

  final bool secondaryColor;
  final double iconSize;
  final double loaderOpacity;


  @override
  _LoadingWIdgetSmallState createState() => _LoadingWIdgetSmallState();
}

class _LoadingWIdgetSmallState extends State<LoadingWIdgetSmall>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.repeat(reverse: true);
    animation = Tween(begin: 0.5, end: 0.2).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  void _startAnimation() {
    controller.stop();
    controller.reset();
    controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(7)),
      child: Center(
        child: Stack(
          children: [
            SizedBox(
              height: 45,
              width: 45,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.kSecondaryColorFaded),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Transform.scale(
                  scale: animation.value,
                  child: SvgPicture.asset("assets/logos/kolo_icon.svg")),
            )
          ],
        ),
      ),
    );
  }
}


