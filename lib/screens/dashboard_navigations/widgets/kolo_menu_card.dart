import 'package:flutter/material.dart';
import 'package:koloplan/screens/koloplan_contacts/koloplan_contacts.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';

class KoloMenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isNewFeature;

  const KoloMenuCard({Key key, this.title, this.subtitle, this.isNewFeature = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 17),
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
                Row(
                  children: [
                    Text(
                      '$title',
                      textScaleFactor: 1,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        decorationColor: AppColors.kWhite.withOpacity(0.8),
                        color: AppColors.kWhite.withOpacity(0.8),
                        fontSize: 15.5,
                        // letterSpacing: -0.2,
                        fontFamily: AppStrings.poppinsBold,
                      ),
                    ),
                    XMargin(8),
                    isNewFeature ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff1A2C24),
                      ),
                      child: Row(
                        children: [
                          Text("New",
                              textScaleFactor: 1,
                              style: TextStyle(fontSize: 11,
                                  fontFamily: AppStrings.fontNormal,
                                  color: Color(0xff06B856),
                                  height: 1.6
                              )),
                          Transform.translate(
                            offset: Offset(0,-2),
                            child: Text(" 🎉",
                                textScaleFactor: 1,
                                style: TextStyle(fontSize: 12,
                                    fontFamily: AppStrings.fontNormal,
                                    color: Color(0xff06B856),
                                    height: 1.6
                                )),
                          ),
                        ],
                      ),
                    ) : Container(),
                  ],
                ),
                Text(
                  '$subtitle',
                  textScaleFactor: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xff757575),
                    fontSize: 12,
                    // letterSpacing: -0.4,
                    height: 1.65,
                    fontFamily: AppStrings.fontNormal,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactList()),
              );
            },
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(top: 5),
              child: Transform.translate(
                offset: Offset(0, 0),
                child: Text(
                  "Connect",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontFamily: AppStrings.poppinsExtraBold,
                      fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
