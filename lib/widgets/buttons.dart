import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/enums.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/margins.dart';
import 'package:koloplan/utils/strings.dart';

class PrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color color;
  final Color textColor;
  final bool loading;
  final double horizontalMargin;

  const PrimaryButton(
      {Key key,
        @required this.onPressed,
        @required this.title,
        this.color = AppColors.kAccentColor,
        this.loading = false, this.horizontalMargin = 0, this.textColor = AppColors.kWhite})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: ButtonTheme(
          minWidth: double.infinity,
          buttonColor: color,
          height: 55,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
            ),
            onPressed: onPressed,
            child: loading == true
                ? SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Text(
              title,
              style: TextStyle(
                fontSize: 14,
                  color: textColor, fontFamily: "Caros-Bold"),
            ),
          )),
    );
  }
}
class OutlinePrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final bool loading;
  final double horizontalMargin;

  const OutlinePrimaryButton(
      {Key key,
        @required this.onPressed,
        @required this.title,
        this.color = AppColors.kWhite,
        this.loading = false,
        this.horizontalMargin = 0,
        this.textColor = AppColors.kAccentColor,
        this.borderColor = AppColors.kAccentColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: ButtonTheme(
          minWidth: double.infinity,
          buttonColor: color,
          height: 55,
          child: RaisedButton(
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: borderColor,width: .8)
            ),
            onPressed: onPressed,
            child: loading == true
                ? SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Text(
              title,
              style: TextStyle(
                fontSize: 14,
                  color: textColor, fontFamily: "Caros-Bold"),
            ),
          )),
    );
  }
}

class PrimaryButtonIntrinsic extends StatelessWidget {
  const PrimaryButtonIntrinsic({
    Key key, this.onTap, this.height = 47, this.title = "Play now", this.fontSize = 15.2,
    this.bg = AppColors.kSecondaryColor, this.textColor = AppColors.kWhite,
  }) : super(key: key);

  final VoidCallback onTap;
  final Color bg;
  final Color textColor;
  final double height;
  final double fontSize;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 50),
        child: Card(
          color: bg,
          child: IntrinsicWidth(
            child: Container(
              height: height,
              // width: 290,
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Text("$title".toUpperCase(),
                textScaleFactor: 1,
                style: TextStyle(
                    fontFamily: AppStrings.fontSemiBold,
                    fontSize: fontSize,
                    letterSpacing: -0.1,
                    color: textColor
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryButtonNew extends StatelessWidget {
  const PrimaryButtonNew({
    Key key, this.onTap, this.width = 200, this.height = 50, this.title,
    this.bg = AppColors.kWhite, this.textColor = AppColors.kSecondaryColor, this.loading = false, this.useIllustrations = false,
    this.illustration = "", this.fontBold = false, this.fontSizePrimary = 13
  }) : super(key: key);

  final VoidCallback onTap;
  final double width;
  final Color bg;
  final Color textColor;
  final double height;
  final String title;
  final bool loading;
  final bool useIllustrations;
  final String illustration;
  final bool fontBold;
  final double fontSizePrimary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: Container(
          height: height,
          constraints: BoxConstraints(
            minWidth: width,
          ),
          decoration: BoxDecoration(
              color: onTap == null ? Color(0xffC1C1C1) : bg,
              borderRadius: BorderRadius.circular(8)
          ),
          child: Center(child: loading ? Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.black),
            child: new CircularProgressIndicator(backgroundColor: Colors.white54,),
          ) :
          useIllustrations ?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                textScaleFactor: 1,
                style: TextStyle(color: textColor,fontSize: 15, fontFamily: AppStrings.fontNormal)),
              XMargin(8),
              SvgPicture.asset("$illustration")
            ],
          ) : Text(title,
              textScaleFactor: 1,
              style: TextStyle(color: textColor,
                  fontSize: fontBold ? fontSizePrimary : 14.5,
                  fontFamily: fontBold ? AppStrings.poppinsBold : AppStrings.fontSemiBold))),
        ),
      ),
    );
  }
}

// CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)

class RoundedNextButton extends StatelessWidget {
  const RoundedNextButton({
    Key key, this.onTap,
    this.loading = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 74,
          height: 74,
          child: Stack(
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.kPrimaryColorLight
                ),

              ),
              Positioned(
                left: 0,
                right: 0,
                top: 7,

                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: onTap == null ? AppColors.kPrimaryColor.withOpacity(0.5) : AppColors.kPrimaryColor
                  ),
                  child: Center(child: loading ?
                  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),): Icon(Icons.navigate_next,color: Colors.white,),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentSourceButton extends StatefulWidget {
  final Function onTap;
  final String image;
  final String paymentsource;
  final String amount;
  final Color color;

  const PaymentSourceButton(
      {Key key,
        @required this.onTap,
        @required this.image,
        @required this.paymentsource,
        this.amount = "", this.color = AppColors.kPrimaryColor})
      : super(key: key);

  @override
  _PaymentSourceButtonState createState() => _PaymentSourceButtonState();
}

class _PaymentSourceButtonState extends State<PaymentSourceButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          padding: EdgeInsets.only(left: 19.0, right: 15),
          height: screenHeight(context) / 14,
          width: screenWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.kWhite,
                    child: Image.asset("images/${widget.image}.png"),
                  ),
                  XMargin(10),
                  Text(
                    widget.paymentsource,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppStrings.fontNormal,
                      color: AppColors.kWhite,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    widget.amount,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppStrings.fontNormal,
                      color: AppColors.kWhite,
                    ),
                  ),
                  XMargin(10),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.kWhite,
                    size: 15,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
class PaymentSourceButtonSpecial extends StatefulWidget {
  final Function onTap;
  final String image;
  final String paymentsource;
  final String amount;
  final Color color;
  final Color textColor;
  final Color iconColor;
  final bool isRexel;

  const PaymentSourceButtonSpecial(
      {Key key,
        @required this.onTap,
        this.image,
        @required this.paymentsource,
        this.amount = "",
        this.isRexel = false,
        this.color = AppColors.kPrimaryColor, this.textColor = AppColors.kWhite, this.iconColor = AppColors.kWhite})
      : super(key: key);

  @override
  _PaymentSourceButtonSpecialState createState() =>
      _PaymentSourceButtonSpecialState();
}

class _PaymentSourceButtonSpecialState
    extends State<PaymentSourceButtonSpecial> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          padding: EdgeInsets.only(left: 19.0, right: 15),
          height: screenHeight(context) / 14,
          width: screenWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.paymentsource,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: AppStrings.fontSemiBold,
                  color: widget.textColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.amount,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppStrings.fontNormal,
                      color: AppColors.kWhite,
                    ),
                  ),
                  XMargin(10),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: widget.iconColor,
                    size: 19,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}