import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/utils/app_utils.dart';

class TransactionItemWidget extends StatelessWidget {
  const TransactionItemWidget({
    Key key,
    this.onTap,
    this.narration,
    this.date,
    this.amount,
    this.symbol,
    this.topUp = true,
    this.margTop = 25,
    this.trans = 1,
  }) : super(key: key);

  final VoidCallback onTap;
  final String narration;
  final String date;
  final num amount;
  final String symbol;
  final bool topUp;
  final double margTop;
  final int trans;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: margTop),
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
            color: Colors.transparent,
            child: Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                      color: topUp ? Color(0xff0F2B06) : Color(0xff2B0F06), shape: BoxShape.circle),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/${topUp ? 'top_up' : 'withdraw'}.svg",
                      color: topUp ? Color(0xff4ED71E) : Color(0xffD74A1E),
                    ),
                  ),
                ),
                XMargin(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Text(
                          narration,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textScaleFactor: 1,
                          style: TextStyle(
                            fontFamily: AppStrings.poppinsBold,
                              color: AppColors.kWhite1,
                              fontSize: 12),
                        ),
                      ),
                      YMargin(6),
                      Text(
                        date,
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 11,
                            color: Color(0xffBABABA),
                            fontFamily: AppStrings.fontNormal),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Transform.translate(
                          offset: Offset(0, -1),
                          child: Text("${AppStrings.nairaSymbol}",
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontFamily: AppStrings.fontSemiBold,
                                color: AppColors.kWhite1,
                                fontSize: 12),),
                        ),
                        Text(
                          "$amount".split(".").first.convertWithComma(),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontFamily: AppStrings.poppinsBold,
                              color: AppColors.kWhite1,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    YMargin(5),
                    Text(
                      trans == 3 ? "Successful" : 'Failed',
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: trans == 3
                              ? AppColors.kPrimaryColor
                              : Color(0xffE25D5D),
                          fontSize: 12,
                        fontFamily: AppStrings.fontSemiBold
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Divider(
              color: Color(0xff161616),
            ),
          )
        ],
      ),
    );
  }
}
