import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:koloplan/data/view_models/dashboard_view_model.dart';
import 'package:koloplan/data/view_models/firebase_view_model.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';
import 'package:koloplan/widgets/buttons.dart';
import 'package:provider/provider.dart';

class EnterNameWidget extends StatefulWidget {
  const EnterNameWidget({
    Key key,
    this.onNext,
    this.onBack,
  }) : super(key: key);
  final Function onNext;
  final Function onBack;

  @override
  _EnterNameWidgetState createState() => _EnterNameWidgetState();
}

class _EnterNameWidgetState extends State<EnterNameWidget> with AfterLayoutMixin<EnterNameWidget> {
  String firstName = "";
  String lastName = "";
  bool autoValidate = false;
  ABSDashboardViewModel dashboardViewModel;
  ABSFirebaseViewModel firebaseViewModel;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  @override
  void afterFirstLayout(BuildContext context) {
    if(firebaseViewModel.firstName.isNotEmpty && firebaseViewModel.lastName.isNotEmpty) {
      setState(() {
        firstNameController.text = firebaseViewModel.firstName;
        lastNameController.text = firebaseViewModel.lastName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    firebaseViewModel = Provider.of(context);
    dashboardViewModel = Provider.of(context);
    return GestureDetector(
      onTap: () {
        _nodeText1.unfocus();
        _nodeText2.unfocus();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(40),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12)),
                child: Transform.translate(
                  offset: Offset(0, 5),
                  child: TextField(
                    controller: firstNameController,
                    onChanged: (value) {
                      setState(() {
                        firstName = value;
                      });
                    },
                    focusNode: _nodeText1,
                    style: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 15),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.kInputFieldBg,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xff1B2D58), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: AppColors.kPrimaryColorLight.withOpacity(0.6), width: 1.5),
                        ),
                        labelText: 'First name',
                        labelStyle: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 14),
                        hintText: 'Enter your first name',
                        hintStyle: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 14)
                      // counterText: 'counter',
                    ),
                  ),
                ),
              ),
              if (autoValidate == false ? false : firstNameController.text.length < 2)
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 8),
                  child: Text(
                    "First name must be at least 2 characters",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 12, color: AppColors.kRed, fontFamily: AppStrings.fontNormal, letterSpacing: -0.2),
                  ),
                )
              else
                SizedBox(),
              YMargin(25),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12)),
                child: Transform.translate(
                  offset: Offset(0, 5),
                  child: TextField(
                    controller: lastNameController,
                    focusNode: _nodeText2,
                    onChanged: (value) {
                      setState(() {
                        lastName = value;
                      });
                    },
                    style: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 15),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.kInputFieldBg,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xff1B2D58), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: AppColors.kPrimaryColorLight.withOpacity(0.6), width: 1.5),
                        ),
                        labelText: 'Last name',
                        labelStyle: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 14),
                        hintText: 'Enter your last name',
                        hintStyle: TextStyle(fontFamily: AppStrings.fontSemiBold, color: AppColors.kInputFieldTextColor, fontSize: 14)
                      // counterText: 'counter',
                    ),
                  ),
                ),
              ),
              if (autoValidate == false ? false : lastNameController.text.length < 2)
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 8),
                  child: Text(
                    "Last name must be at least 2 characters",
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: 12, color: AppColors.kRed, fontFamily: AppStrings.fontNormal, letterSpacing: -0.2),
                  ),
                )
              else
                SizedBox(),
              YMargin(37),
              PrimaryButtonNew(
                onTap: () async {
                  setState(() {
                    autoValidate = true;
                  });
                  if (firstNameController.text.length < 2 || lastNameController.text.length < 2) {
                    return;
                  }
                  if(_nodeText1.hasFocus || _nodeText2.hasFocus) {
                    _nodeText1.unfocus();
                    _nodeText2.unfocus();
                    await Future.delayed(Duration(milliseconds: 500));
                  }
                  widget.onNext(firstNameController.text, lastNameController.text);
                },
                title: "Next",
                width: MediaQuery.of(context).size.width,
                fontBold: true,
                fontSizePrimary: 15,
                bg: AppColors.kWhite,
                textColor: AppColors.kSecondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
