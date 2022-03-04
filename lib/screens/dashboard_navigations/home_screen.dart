import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koloplan/data/models/notification_activity.dart';
import 'package:koloplan/data/view_models/dashboard_view_model.dart';
import 'package:koloplan/data/view_models/notification_view_model.dart';
import 'package:intl/intl.dart';
import 'package:koloplan/screens/dashboard_navigations/widgets/kolo_menu_card.dart';
import 'package:koloplan/screens/dashboard_navigations/widgets/transaction_item.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/splash_tap.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        YMargin(10),
        GestureDetector(
          onTap: () {},
          child: Center(
            child: Text("Dashboard",
              textScaleFactor: 1,
              style: TextStyle(
                  fontFamily: AppStrings.poppinsBold,
                  fontSize: 16.5,
                  color: AppColors.kWhite
              ),
            ),
          ),
        ),
        YMargin(20),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                      color: Color(0xff1C1C1E),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                YMargin(10),
                KoloMenuCard(
                  title: "Friends on Koloplan",
                  subtitle: "Find your contacts on Koloplan.",
                  isNewFeature: true,
                ),
                YMargin(25),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: AppStrings.poppinsBold,
                            color: Color(0xffBBBBBB)
                        ),
                        child: Text(
                          "Transactions",
                          textScaleFactor: 1,
                        ),
                      ),
                      Splash(
                        onTap: () {},
                        splashColor: AppColors.kWhite1,
                        maxRadius: 35,
                        minRadius: 20,
                        child: Container(
                          color: Colors.transparent,
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: AppStrings.poppinsExtraBold,
                                color: AppColors.kSecondaryColor),
                            child: Text(
                              "View all",
                              textScaleFactor: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                YMargin(20),
                TransactionItemWidget(
                  trans: 3,
                  topUp: true,
                  margTop: 0,
                  symbol: AppStrings.nairaSymbol,
                  amount: 10500,
                  date: "2nd May 2020",
                  // date: getTransactionFilter("Credit")[index].date,
                  narration: "Wallet Funding",
                ),
                TransactionItemWidget(
                  trans: 1,
                  topUp: false,
                  margTop: 0,
                  symbol: AppStrings.nairaSymbol,
                  amount: 10500,
                  date: "2nd May 2020",
                  // date: getTransactionFilter("Credit")[index].date,
                  narration: "Wallet Withdrawal",
                ),
                TransactionItemWidget(
                  trans: 1,
                  topUp: false,
                  margTop: 0,
                  symbol: AppStrings.nairaSymbol,
                  amount: 10500,
                  date: "2nd May 2020",
                  // date: getTransactionFilter("Credit")[index].date,
                  narration: "Wallet Withdrawal",
                ),
                TransactionItemWidget(
                  trans: 3,
                  topUp: true,
                  margTop: 0,
                  symbol: AppStrings.nairaSymbol,
                  amount: 10500,
                  date: "2nd May 2020",
                  // date: getTransactionFilter("Credit")[index].date,
                  narration: "Wallet Funding",
                ),
              ],
            ),
          ),
        )
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    color: Color(0xff1C1C1E),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    color: Color(0xff1C1C1E),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enable biometrics',
                            textScaleFactor: 1,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              decorationColor: AppColors.kWhite.withOpacity(0.8),
                              color: AppColors.kWhite.withOpacity(0.8),
                              fontSize: 16,
                              letterSpacing: -0.2,
                              fontFamily: AppStrings.fontExtraBold,
                            ),
                          ),
                          // Text(
                          //   '${AppStrings.enableNotification}',
                          //   textScaleFactor: 1,
                          //   textAlign: TextAlign.start,
                          //   style: TextStyle(
                          //     color: Color(0xff858282).withOpacity(0.82),
                          //     fontSize: 14.1,
                          //     letterSpacing: -0.4,
                          //     height: 1.65,
                          //     fontFamily: AppStrings.fontNormal,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    XMargin(50),
                    Text(
                      "Connect",
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontFamily: AppStrings.poppinsExtraBold,
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
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