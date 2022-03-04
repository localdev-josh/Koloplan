import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koloplan/components/animated_switch.dart';
import 'package:koloplan/data/local_database/user_local.dart';
import 'package:koloplan/data/models/individual/secondary_state.dart';
import 'package:koloplan/data/models/menu_activity.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/app_toast.dart';
import 'package:koloplan/widgets/hero_dialog.dart';
import 'package:koloplan/widgets/log_out.dart';
import 'package:koloplan/widgets/splash_tap.dart';
import 'package:koloplan/utils/app_utils.dart';
import 'package:local_auth/local_auth.dart';
import '../../locator.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  final LocalAuthentication auth = LocalAuthentication();
  static double avatarMaximumRadius = 40.0;
  static double avatarMinimumRadius = 10.0;
  double avatarRadius = avatarMaximumRadius;
  double expandedHeader = 130.0;
  double translate = -avatarMaximumRadius;
  bool isExpanded = true;
  double offset = 0.0;
  Rect region;
  bool notificationIsSelected = false;
  bool _canCheckBiometrics = false;
  var faceId = false;


  @override
  void initState() {
    super.initState();
    _checkBiometrics();
    faceId = _localStorage.getSecondaryState().biometricsEnabled == null ? false :_localStorage.getSecondaryState().biometricsEnabled;
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
    print("biometrics is $_canCheckBiometrics");
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (scrollNotification) {
        final pixels = scrollNotification.metrics.pixels;

        // check if scroll is vertical ( left to right OR right to left)
        final scrollTabs = (scrollNotification.metrics.axisDirection ==
            AxisDirection.right ||
            scrollNotification.metrics.axisDirection == AxisDirection.left);

        if (!scrollTabs) {
          // and here prevents animation of avatar when you scroll tabs
          if (expandedHeader - pixels <= (kToolbarHeight)) {
            if (isExpanded) {
              translate = 0.0;
              setState(() {
                isExpanded = false;
              });
            }
          } else {
            translate = -avatarMaximumRadius + pixels;
            if (translate > 0) {
              translate = 0.0;
            }
            if (!isExpanded) {
              setState(() {
                isExpanded = true;
              });
            }
          }

          offset = pixels * 0.4;

          final newSize = (avatarMaximumRadius - offset);

          setState(() {
            if (newSize < avatarMinimumRadius) {
              avatarRadius = avatarMinimumRadius;
            } else if (newSize > avatarMaximumRadius) {
              avatarRadius = avatarMaximumRadius;
            } else {
              avatarRadius = newSize;
            }
          });
        }
        return false;
      },
      child: Container(
        color: AppColors.kBlack,
        child: CustomScrollView(
          // physics: ClampingScrollPhysics(),
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: expandedHeader,
              backgroundColor: Colors.transparent,
              brightness: Brightness.light,
              collapsedHeight: 35,
              toolbarHeight: 30,
              pinned: true,
              elevation: 0,
              forceElevated: true,
              flexibleSpace: Container(
                  decoration: BoxDecoration(
                    color: isExpanded ? Colors.transparent : AppColors.kBlack300,
                    // image: DecorationImage(image: NetworkImage("https://i.ibb.co/cLF6D0D/profile-cover.png"), fit: BoxFit.cover)
                  ),
                  child: Stack(
                    children: [
                      isExpanded ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: AppColors.kBlack300,
                      ) : Container(),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: isExpanded
                            ? Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, avatarMaximumRadius),
                          child: MyAvatar(
                            size: avatarRadius,
                          ),
                        )
                            : SizedBox.shrink(),
                      )
                    ],
                  )
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        isExpanded
                            ? SizedBox(
                          height: avatarMinimumRadius * 2,
                        )
                            : MyAvatar(
                          size: avatarMinimumRadius,
                        ),
                      ],
                    ),
                    ProfileHeader(),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                  [
                    ...List.generate(menuItemList.menuItems.length, (index) {
                      return MenuItem(
                        title: menuItemList.menuItems[index].title,
                        icon: menuItemList.menuItems[index].icon,
                      );
                    }),
                    YMargin(5),
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
                          AnimatedSwitch(
                            title: "Enable Biometric log-in",
                            toggle: (value){
                              setState(() {
                                faceId = value;
                              });
                              locator<ABSStateLocalStorage>().saveSecondaryState(
                                  SecondaryState.updateBiometrics(
                                      faceId,
                                      locator<ABSStateLocalStorage>()
                                          .getSecondaryState()));
                              if(faceId) {
                                successToastBar(context, message: "Biometrics is enabled",
                                    title: "Biometrics", alignToast: Alignment.topRight);
                              }
                            },
                            status: faceId,
                          ),
                        ],
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
                                  'Transaction Pin',
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
                              ],
                            ),
                          ),
                          XMargin(50),
                          Transform.rotate(
                              angle: 3.14,
                              child: Transform.translate(
                                offset: Offset(0, -4),
                                child: SvgPicture.asset("assets/icons/arrow_right.svg", height: 12,
                                  color: AppColors.kWhite.withOpacity(0.5),),
                              ))
                        ],
                      ),
                    ),
                    YMargin(60),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Splash(
                        onTap: () {
                          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                            return LogoutApp();
                          }));
                        },
                        splashColor: AppColors.kGreyText2,
                        maxRadius: 25,
                        minRadius: 15,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: AppColors.kBlack300,
                              border: Border.all(color: Colors.grey.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      IntrinsicWidth(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Hero(tag: 'logout', child: SvgPicture.asset("assets/icons/logout.svg", width: 16, height: 16, color: AppColors.kRed,)),
                                              XMargin(15),
                                              Text("Logout",
                                                textScaleFactor: 1,
                                                style: TextStyle(
                                                    fontFamily: AppStrings.fontBold,
                                                    fontSize: 15,
                                                    letterSpacing: -0.1,
                                                    color: AppColors.kWhite1
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Expanded(child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.keyboard_arrow_right, color: AppColors.kGreyText2, size: 18,)
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    YMargin(30),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatefulWidget {
  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  String name = "";

  @override
  void initState() {
    super.initState();
    // name = "Joshua";
    name = _localStorage.getUser().firstName.capitalize() +' '+ _localStorage.getUser().lastName.capitalize();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BorderedText(
              strokeWidth: 0.1,
              strokeColor: AppColors.kWhite.withOpacity(0.8),
              child: Text(
                '$name',
                textScaleFactor: 1,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  decorationColor: AppColors.kWhite.withOpacity(0.8),
                  color: AppColors.kWhite.withOpacity(0.8),
                  fontSize: 22,
                  letterSpacing: -0.6,
                  fontFamily: AppStrings.fontExtraBold,
                ),
              )),
          YMargin(20)
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String icon;
  final String title;

  const MenuItem({Key key, this.icon, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
              offset: Offset(0, 1),
              child: Container(
                  color: Colors.transparent,
                  width: 17,
                  height: 17,
                  child: SvgPicture.asset("assets/icons/$icon.svg",
                    color: AppColors.kWhite.withOpacity(0.5),
                  ))),
          // Image(image: AssetImage("assets/images/$icon.png")),
          Expanded(
              child: IntrinsicWidth(
                child: Container(
                  margin: EdgeInsets.only(left: 14),
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '$title',
                              textScaleFactor: 1,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.kWhite1.withOpacity(0.95),
                                fontSize: 14.5,
                                fontFamily: AppStrings.fontNormal,
                              ),
                            ),
                            Expanded(child: Align(alignment: Alignment.centerRight,
                                child: Transform.rotate(
                                  angle: 3.14,
                                    child: SvgPicture.asset("assets/icons/arrow_right.svg", height: 10,
                                    color: AppColors.kWhite.withOpacity(0.5),))))
                          ],
                        ),
                        icon == "invite_friend" ? YMargin(20) : YMargin(11),
                        icon == "invite_friend" ? Container() : Transform.translate(
                            offset: Offset(0, -1),
                            child: Divider(color: AppColors.kGreyText3.withOpacity(0.5),
                              thickness: 1,))
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // print("Size is $size");
    return Container(
      padding: const EdgeInsets.only(left: 25.0),
      // height: size + 70,
      // width: size + 98,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[800].withOpacity(0.5),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: CachedNetworkImage(
          imageUrl: "https://i.ibb.co/MNrv4cL/sigmund-n-Hq5a-Xb-IZ0-unsplash.jpg",
          placeholder: (context, url) => Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(8),
                color: Color(0xffF1F1F1),
                // child: Opacity( opacity: 0.9,child: Image.asset(AppStrings.appLogoWhite))
              )
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MyAvatar extends StatelessWidget {
  final double size;

  const MyAvatar({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("Size is $size");
    return Container(
      padding: const EdgeInsets.only(left: 25.0),
      height: size + 70,
      width: size + 98,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[800].withOpacity(0.5),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            imageUrl: "https://i.ibb.co/59PYnQR/profile-photo.png",
            placeholder: (context, url) => Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(8),
                  color: Color(0xffF1F1F1),
                )
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
