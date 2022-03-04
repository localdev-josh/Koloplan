import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:koloplan/app_updates/models/app_update_config.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/buttons.dart';

class UpdateAppWidget extends StatelessWidget {
  final AppUpdateConfig appUpdateConfig;
  const UpdateAppWidget({Key key,@required this.appUpdateConfig}) : super(key: key);
  String get url => Platform.isIOS? appUpdateConfig.iOSLink:appUpdateConfig.androidLink;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return !appUpdateConfig.forceUpdate;
      },
      child: IntrinsicHeight(
        child: Container(
          constraints: BoxConstraints(
            minHeight: 300
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10,),
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
                        const SizedBox(height: 20),
                        Text(
                          "Update your Koloplan App 🎉",
                          textScaleFactor: 1,
                          style:
                          TextStyle(fontSize: 15, fontFamily: AppStrings.fontSemiBold,color: Color(0xff050826)),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("A new update is available. Update your Koloplan app now to enjoy the latest features.",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontSize: 13, height: 1.6, color: AppColors.kGreyText),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            if(!appUpdateConfig.forceUpdate)
                            Expanded(
                              child: PrimaryButtonNew(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                textColor: AppColors.kPrimaryColor,
                                bg: AppColors.kPrimaryColor.withOpacity(0.2),
                                title: "Update later",
                              ),
                            ),
                            if(!appUpdateConfig.forceUpdate)
                              const SizedBox(width: 20,),
                             Expanded(
                               child: PrimaryButtonNew(
                                title: "Update now",
                                onTap: () async {
                                  _launchURL(url);
                                },
                            ),
                             ),
                          ],
                        ),
                        const SizedBox(height: 30,),

                      ],
                    ),
                  )),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}

void _launchURL(String _url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';