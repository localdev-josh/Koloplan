import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/styles/styles.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/spinkit/flutter_spinkit.dart';

class NetworkErrorAnimation extends StatefulWidget {
  final VoidCallback onNext;

  const NetworkErrorAnimation({Key key, this.onNext}) : super(key: key);
  @override
  _NetworkErrorAnimationState createState() => _NetworkErrorAnimationState();
}

class _NetworkErrorAnimationState extends State<NetworkErrorAnimation> {

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: 5.0,
        sigmaY: 5.0,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black26,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: IntrinsicHeight(
                child: Container(
                  // constraints: BoxConstraints(
                  //   minHeight: 200
                  // ),
                  color: AppColors.kWhite,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 0),
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kGrey.withOpacity(0.8)
                        ),
                        child: IntrinsicWidth(
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                            child: InkWell(
                              onTap: () {
                                widget.onNext();
                              },
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                                height: 30,
                                width: 30,
                                child: Icon(Icons.close, color: AppColors.kPrimaryColor,size: 25,),
                              ),
                            ),
                          ),
                        ),
                      ),
                      YMargin(22),
                      Text("You seem to be offline",
                      textScaleFactor: 1, style: AppStyles.questionTitleStyle.copyWith(fontSize: 16)),
                      YMargin(12),
                      Text("Please check your Wifi network or data service and try again.",
                        textScaleFactor: 1,
                        style: AppStyles.questionSubtitleStyle.copyWith(fontSize: 13.5, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SafeArea(
                child: Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SpinKitRipple(
                          size: 65,
                          color: Colors.red,
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(FeatherIcons.wifiOff, color: Colors.black54, size: 14,))
                        // color: Colors.black54, size: 15,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class GoToTempLogin extends StatefulWidget {
  final VoidCallback onNext;

  const GoToTempLogin({Key key, this.onNext}) : super(key: key);
  @override
  _GoToTempLoginState createState() => _GoToTempLoginState();
}

class _GoToTempLoginState extends State<GoToTempLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black26,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: IntrinsicHeight(
              child: Container(
                // constraints: BoxConstraints(
                //   minHeight: 200
                // ),
                color: AppColors.kWhite,
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 0),
                      decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kGrey.withOpacity(0.8)
                      ),
                      child: IntrinsicWidth(
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100),
                          child: InkWell(
                            onTap: () {
                              widget.onNext();
                            },
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              height: 30,
                              width: 30,
                              child: Icon(Icons.close, color: AppColors.kPrimaryColor,size: 25,),
                            ),
                          ),
                        ),
                      ),
                    ),
                    YMargin(22),
                    Text("Session timeout",
                        textScaleFactor: 1, style: AppStyles.questionTitleStyle.copyWith(fontSize: 16)),
                    YMargin(12),
                    Text("Your session has expired. Please login to continue",
                      textScaleFactor: 1,
                      style: AppStyles.questionSubtitleStyle.copyWith(fontSize: 13.5, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class NetworkErrorWidget extends StatefulWidget {
  final VoidCallback onNext;
  final bool isSignup;

  const NetworkErrorWidget({Key key, this.onNext, this.isSignup}) : super(key: key);
  @override
  _NetworkErrorWidgetState createState() => _NetworkErrorWidgetState();
}

class _NetworkErrorWidgetState extends State<NetworkErrorWidget> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: widget.isSignup ? false : true,
      bottom: widget.isSignup ? true : false,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: widget.isSignup ? MediaQuery.of(context).size.height : null,
          padding: EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: widget.isSignup ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: widget.isSignup ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      margin: widget.isSignup ? EdgeInsets.only(left: 17) : EdgeInsets.only(right: 20),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SpinKitRipple(
                              size: 65,
                              color: Colors.red,
                            ),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Icon(FeatherIcons.wifiOff, color: Colors.black54, size: 14,))
                            // color: Colors.black54, size: 15,
                          )
                        ],
                      )
                  ),
                ],
              )
            ],
          )
        // child: Container(
        //   height: 20,
        //   width: 20,
        //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        //   decoration: BoxDecoration(
        //       color: Colors.red,
        //       shape: BoxShape.circle
        //   ),
        // ),
      ),
    );
  }
}


// Dialog(
// insetPadding: const EdgeInsets.all(0.0),
// backgroundColor: Colors.white.withOpacity(0.1),
// child: Container(
// height: MediaQuery.of(context).size.height,
// child: Lottie.asset('animations/network_error.json'),
// ),
// ),