import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koloplan/data/models/notification_activity.dart';
import 'package:koloplan/data/view_models/dashboard_view_model.dart';
import 'package:koloplan/data/view_models/notification_view_model.dart';
import 'package:intl/intl.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:provider/provider.dart';


class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    ABSNotificationViewModel notificationViewModel = Provider.of(context);

    List<NotificationItemModel> notificationItems;

    return Container(
      color: AppColors.kBlack,
      child: StreamBuilder(
        stream: notificationViewModel.listStream,
        builder: (context, snapshot) {
          print("Snapshot data became ${snapshot.data}");
          if (snapshot.data != null) {
            notificationItems = snapshot.data;
            return CartBody(notificationItems);
          }
          else {
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                YMargin(10),
                GestureDetector(
                  onTap: () {},
                  child: Text("Hello",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontFamily: AppStrings.poppinsBold,
                        fontSize: 14,
                        color: AppColors.kPrimaryColor
                    ),
                  ),
                ),
                YMargin(11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Text("All notifications",
                            textScaleFactor: 1,
                            style: TextStyle(
                              fontFamily: AppStrings.fontExtraBold,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff161616),
                              letterSpacing: -0.2,
                              fontSize: 16.5,
                            )
                        ),
                      ),
                    ),
                    XMargin(5),
                    Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.kBlack, size: 20,)
                  ],
                ),
                YMargin(20),
                Expanded(child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.only(bottom: 25,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: 90,
                                    height: 100,
                                    color: Color(0xffF1F1F1),
                                    // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                  )
                              ),
                              XMargin(20),
                              Expanded(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      color: Colors.transparent,
                                      constraints: BoxConstraints(
                                          minHeight: 100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 160,
                                            height: 20,
                                            color: Color(0xffF1F1F1),
                                            // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                          ),
                                          YMargin(10),
                                          Container(
                                            width: 90,
                                            height: 20,
                                            color: Color(0xffF1F1F1),
                                            // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: IntrinsicWidth(
                                                child: Container(
                                                  width: 90,
                                                  height: 20,
                                                  color: Color(0xffF1F1F1),
                                                  // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                                ),
                                              ),
                                            ),
                                          )
                                          // Spacer(),
                                        ],
                                      ),
                                    ),
                                  )),
                              XMargin(14),
                              Container(
                                height: 20,
                                width: 20,
                                color: Colors.transparent,
                                child: Icon(Icons.favorite_outline_sharp,
                                  size: 17,),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.only(bottom: 25,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: 90,
                                    height: 100,
                                    color: Color(0xffF1F1F1),
                                    // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                  )
                              ),
                              XMargin(20),
                              Expanded(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      color: Colors.transparent,
                                      constraints: BoxConstraints(
                                          minHeight: 100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 160,
                                            height: 20,
                                            color: Color(0xffF1F1F1),
                                            // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                          ),
                                          YMargin(10),
                                          Container(
                                            width: 90,
                                            height: 20,
                                            color: Color(0xffF1F1F1),
                                            // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: IntrinsicWidth(
                                                child: Container(
                                                  width: 90,
                                                  height: 20,
                                                  color: Color(0xffF1F1F1),
                                                  // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                                ),
                                              ),
                                            ),
                                          )
                                          // Spacer(),
                                        ],
                                      ),
                                    ),
                                  )),
                              XMargin(14),
                              Container(
                                height: 20,
                                width: 20,
                                color: Colors.transparent,
                                child: Icon(Icons.favorite_outline_sharp,
                                  size: 17,),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.only(bottom: 25,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: 90,
                                    height: 100,
                                    color: Color(0xffF1F1F1),
                                    // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                  )
                              ),
                              XMargin(20),
                              Expanded(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      color: Colors.transparent,
                                      constraints: BoxConstraints(
                                          minHeight: 100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 160,
                                            height: 20,
                                            color: Color(0xffF1F1F1),
                                            // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                          ),
                                          YMargin(10),
                                          Container(
                                            width: 90,
                                            height: 20,
                                            color: Color(0xffF1F1F1),
                                            // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: IntrinsicWidth(
                                                child: Container(
                                                  width: 90,
                                                  height: 20,
                                                  color: Color(0xffF1F1F1),
                                                  // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                                ),
                                              ),
                                            ),
                                          )
                                          // Spacer(),
                                        ],
                                      ),
                                    ),
                                  )),
                              XMargin(14),
                              Container(
                                height: 20,
                                width: 20,
                                color: Colors.transparent,
                                child: Icon(Icons.favorite_outline_sharp,
                                    size: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.only(bottom: 25,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: 90,
                                    height: 100,
                                    color: Color(0xffF1F1F1),
                                    // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                  )
                              ),
                              XMargin(20),
                              Expanded(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      color: Colors.transparent,
                                      constraints: BoxConstraints(
                                          minHeight: 100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 160,
                                            height: 20,
                                            color: Color(0xffF1F1F1),
                                            // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                          ),
                                          YMargin(10),
                                          Container(
                                            width: 90,
                                            height: 20,
                                            color: Color(0xffF1F1F1),
                                            // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: IntrinsicWidth(
                                                child: Container(
                                                  width: 90,
                                                  height: 20,
                                                  color: Color(0xffF1F1F1),
                                                  // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                                ),
                                              ),
                                            ),
                                          )
                                          // Spacer(),
                                        ],
                                      ),
                                    ),
                                  )),
                              XMargin(14),
                              Container(
                                height: 20,
                                width: 20,
                                color: Colors.transparent,
                                child: Icon(Icons.favorite_outline_sharp,
                                  size: 17,),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.only(bottom: 25,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: 90,
                                    height: 100,
                                    color: Color(0xffF1F1F1),
                                    // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                  )
                              ),
                              XMargin(20),
                              Expanded(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      color: Colors.transparent,
                                      constraints: BoxConstraints(
                                          minHeight: 100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 160,
                                            height: 20,
                                            color: Color(0xffF1F1F1),
                                            // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                          ),
                                          YMargin(10),
                                          Container(
                                            width: 90,
                                            height: 20,
                                            color: Color(0xffF1F1F1),
                                            // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: IntrinsicWidth(
                                                child: Container(
                                                  width: 90,
                                                  height: 20,
                                                  color: Color(0xffF1F1F1),
                                                  // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                                ),
                                              ),
                                            ),
                                          )
                                          // Spacer(),
                                        ],
                                      ),
                                    ),
                                  )),
                              XMargin(14),
                              Container(
                                height: 20,
                                width: 20,
                                color: Colors.transparent,
                                child: Icon(Icons.favorite_outline_sharp,
                                  size: 17,),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          margin: EdgeInsets.only(bottom: 25,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    width: 90,
                                    height: 100,
                                    color: Color(0xffF1F1F1),
                                    // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                  )
                              ),
                              XMargin(20),
                              Expanded(
                                  child: IntrinsicHeight(
                                    child: Container(
                                      color: Colors.transparent,
                                      constraints: BoxConstraints(
                                          minHeight: 100
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 160,
                                            height: 20,
                                            color: Color(0xffF1F1F1),
                                            // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                          ),
                                          YMargin(10),
                                          Container(
                                            width: 90,
                                            height: 20,
                                            color: Color(0xffF1F1F1),
                                            // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: IntrinsicWidth(
                                                child: Container(
                                                  width: 90,
                                                  height: 20,
                                                  color: Color(0xffF1F1F1),
                                                  // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
                                                ),
                                              ),
                                            ),
                                          )
                                          // Spacer(),
                                        ],
                                      ),
                                    ),
                                  )),
                              XMargin(14),
                              Container(
                                height: 20,
                                width: 20,
                                color: Colors.transparent,
                                child: Icon(Icons.favorite_outline_sharp,
                                  size: 17,),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            );
          }
        },
      ),
    );
  }
}


class CartBody extends StatefulWidget {
  final List<NotificationItemModel> orderItems;

  const CartBody(this.orderItems);

  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  var thousandFormatter = NumberFormat("#,##0.00", "en_US");
  ABSDashboardViewModel dashboardViewModel;
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    ABSNotificationViewModel notificationViewModel = Provider.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        YMargin(10),
        GestureDetector(
          onTap: () {},
          child: Center(
            child: Text("Portfolio",
              textScaleFactor: 1,
              style: TextStyle(
                  fontFamily: AppStrings.poppinsBold,
                  fontSize: 16.5,
                  color: AppColors.kWhite
              ),
            ),
          ),
        ),
        noItemContainer(context),
      ],
    );
  }

  Widget noItemContainer(BuildContext context) {
    dashboardViewModel = Provider.of(context);
    return IntrinsicHeight(
      child: Container(
        constraints: BoxConstraints(
            minHeight: 400
        ),
        padding: EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              YMargin(40),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Empty screen",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Color(0xff777777),
                      fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}