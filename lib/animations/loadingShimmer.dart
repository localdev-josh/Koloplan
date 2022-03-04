import 'package:flutter/material.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/margins.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20, top: 15),
          width: screenWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child:
                    SkeletonAnimation(
                      shimmerColor:
                      Color(0xffEEF1F1),
                      gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                      child:
                      Container(
                        height: 25,
                        width: 100,
                        decoration:
                        BoxDecoration(
                          color: Color(0xffEEF1F1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                    SkeletonAnimation(
                      shimmerColor:
                      Color(0xffEEF1F1),
                      gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                      child:
                      Container(
                        height: 25,
                        width: 150,
                        decoration:
                        BoxDecoration(
                          color: Color(0xffEEF1F1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              YMargin(30),
              IntrinsicHeight(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  constraints: BoxConstraints(
                      minHeight: 140),
                  width: double.infinity,
                  decoration:
                  BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 1),
                          color: Color(0xFF000000).withOpacity(0.08),
                          blurRadius: 24)
                    ],
                    color: AppColors.kWhite,
                    borderRadius:
                    BorderRadius.circular(7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets
                            .symmetric(
                            horizontal:
                            20),
                        child:
                        SkeletonAnimation(
                          shimmerColor: Color(0xffEEF1F1),
                          gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                          child:
                          Container(
                            height: 25,
                            width: 200,
                            decoration:
                            BoxDecoration(
                              color: Color(0xffEEF1F1),
                            ),
                          ),
                        ),
                      ),
                      YMargin(17),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:
                        SkeletonAnimation(
                          shimmerColor:
                          Color(0xffEEF1F1),
                          gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                          child:
                          Container(
                            height: 25,
                            width: 200,
                            decoration:
                            BoxDecoration(
                              color: Color(0xffEEF1F1),
                            ),
                          ),
                        ),
                      ),
                      YMargin(17),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child:
                            SkeletonAnimation(
                              shimmerColor:
                              Color(0xffEEF1F1),
                              gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                              child:
                              Container(
                                height: 25,
                                width: 100,
                                decoration:
                                BoxDecoration(
                                  color: Color(0xffEEF1F1),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child:
                            SkeletonAnimation(
                              shimmerColor:
                              Color(0xffEEF1F1),
                              gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                              child:
                              Container(
                                height: 25,
                                width: 150,
                                decoration:
                                BoxDecoration(
                                  color: Color(0xffEEF1F1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              YMargin(60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child:
                    SkeletonAnimation(
                      shimmerColor:
                      Color(0xffEEF1F1),
                      gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                      child:
                      Container(
                        height: 25,
                        width: 100,
                        decoration:
                        BoxDecoration(
                          color: Color(0xffEEF1F1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                    SkeletonAnimation(
                      shimmerColor:
                      Color(0xffEEF1F1),
                      gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                      child:
                      Container(
                        height: 25,
                        width: 150,
                        decoration:
                        BoxDecoration(
                          color: Color(0xffEEF1F1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              YMargin(30),
              IntrinsicHeight(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  constraints: BoxConstraints(
                      minHeight: 140),
                  width: double.infinity,
                  decoration:
                  BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 1),
                          color: Color(0xFF000000).withOpacity(0.08),
                          blurRadius: 24)
                    ],
                    color: AppColors.kWhite,
                    borderRadius:
                    BorderRadius.circular(7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets
                            .symmetric(
                            horizontal:
                            20),
                        child:
                        SkeletonAnimation(
                          shimmerColor: Color(0xffEEF1F1),
                          gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                          child:
                          Container(
                            height: 25,
                            width: 200,
                            decoration:
                            BoxDecoration(
                              color: Color(0xffEEF1F1),
                            ),
                          ),
                        ),
                      ),
                      YMargin(17),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:
                        SkeletonAnimation(
                          shimmerColor:
                          Color(0xffEEF1F1),
                          gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                          child:
                          Container(
                            height: 25,
                            width: 200,
                            decoration:
                            BoxDecoration(
                              color: Color(0xffEEF1F1),
                            ),
                          ),
                        ),
                      ),
                      YMargin(17),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child:
                            SkeletonAnimation(
                              shimmerColor:
                              Color(0xffEEF1F1),
                              gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                              child:
                              Container(
                                height: 25,
                                width: 100,
                                decoration:
                                BoxDecoration(
                                  color: Color(0xffEEF1F1),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child:
                            SkeletonAnimation(
                              shimmerColor:
                              Color(0xffEEF1F1),
                              gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                              child:
                              Container(
                                height: 25,
                                width: 150,
                                decoration:
                                BoxDecoration(
                                  color: Color(0xffEEF1F1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              YMargin(60),
            ],
          ),
        )
      ],
    );
  }
}

class NotificationsLoadingShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20, top: 25),
          width: screenWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: 150),
                  width: double.infinity,
                  decoration:
                  BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.6),
                    color: AppColors.kWhite,
                    borderRadius:
                    BorderRadius.circular(7),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets
                            .symmetric(
                            horizontal: 20, vertical: 20),
                        child:
                        SkeletonAnimation(
                          shimmerColor: Color(0xffEEF1F1),
                          gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                          child:
                          Container(
                            height: 30,
                            width: 30,
                            decoration:
                            BoxDecoration(
                              color: Color(0xffEEF1F1),
                              shape: BoxShape.circle
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .symmetric(
                                  horizontal:
                                  20),
                              child:
                              SkeletonAnimation(
                                shimmerColor: Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 250,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                            YMargin(17),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child:
                              SkeletonAnimation(
                                shimmerColor:
                                Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 200,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                            YMargin(17),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child:
                              SkeletonAnimation(
                                shimmerColor:
                                Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 100,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              YMargin(20),
              IntrinsicHeight(
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: 150),
                  width: double.infinity,
                  decoration:
                  BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.6),
                    color: AppColors.kWhite,
                    borderRadius:
                    BorderRadius.circular(7),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets
                            .symmetric(
                            horizontal: 20, vertical: 20),
                        child:
                        SkeletonAnimation(
                          shimmerColor: Color(0xffEEF1F1),
                          gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                          child:
                          Container(
                            height: 30,
                            width: 30,
                            decoration:
                            BoxDecoration(
                                color: Color(0xffEEF1F1),
                                shape: BoxShape.circle
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .symmetric(
                                  horizontal:
                                  20),
                              child:
                              SkeletonAnimation(
                                shimmerColor: Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 250,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                            YMargin(17),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child:
                              SkeletonAnimation(
                                shimmerColor:
                                Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 200,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                            YMargin(17),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child:
                              SkeletonAnimation(
                                shimmerColor:
                                Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 100,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              YMargin(20),
              IntrinsicHeight(
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: 150),
                  width: double.infinity,
                  decoration:
                  BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.6),
                    color: AppColors.kWhite,
                    borderRadius:
                    BorderRadius.circular(7),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets
                            .symmetric(
                            horizontal: 20, vertical: 20),
                        child:
                        SkeletonAnimation(
                          shimmerColor: Color(0xffEEF1F1),
                          gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                          child:
                          Container(
                            height: 30,
                            width: 30,
                            decoration:
                            BoxDecoration(
                                color: Color(0xffEEF1F1),
                                shape: BoxShape.circle
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .symmetric(
                                  horizontal:
                                  20),
                              child:
                              SkeletonAnimation(
                                shimmerColor: Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 250,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                            YMargin(17),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child:
                              SkeletonAnimation(
                                shimmerColor:
                                Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 200,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                            YMargin(17),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child:
                              SkeletonAnimation(
                                shimmerColor:
                                Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 100,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              YMargin(20),
              IntrinsicHeight(
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: 150),
                  width: double.infinity,
                  decoration:
                  BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.6),
                    color: AppColors.kWhite,
                    borderRadius:
                    BorderRadius.circular(7),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets
                            .symmetric(
                            horizontal: 20, vertical: 20),
                        child:
                        SkeletonAnimation(
                          shimmerColor: Color(0xffEEF1F1),
                          gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                          child:
                          Container(
                            height: 30,
                            width: 30,
                            decoration:
                            BoxDecoration(
                                color: Color(0xffEEF1F1),
                                shape: BoxShape.circle
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .symmetric(
                                  horizontal:
                                  20),
                              child:
                              SkeletonAnimation(
                                shimmerColor: Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 250,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                            YMargin(17),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child:
                              SkeletonAnimation(
                                shimmerColor:
                                Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 200,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                            YMargin(17),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child:
                              SkeletonAnimation(
                                shimmerColor:
                                Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 100,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              YMargin(20),
              IntrinsicHeight(
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: 150),
                  width: double.infinity,
                  decoration:
                  BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.6),
                    color: AppColors.kWhite,
                    borderRadius:
                    BorderRadius.circular(7),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets
                            .symmetric(
                            horizontal: 20, vertical: 20),
                        child:
                        SkeletonAnimation(
                          shimmerColor: Color(0xffEEF1F1),
                          gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                          child:
                          Container(
                            height: 30,
                            width: 30,
                            decoration:
                            BoxDecoration(
                                color: Color(0xffEEF1F1),
                                shape: BoxShape.circle
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .symmetric(
                                  horizontal:
                                  20),
                              child:
                              SkeletonAnimation(
                                shimmerColor: Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 250,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                            YMargin(17),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child:
                              SkeletonAnimation(
                                shimmerColor:
                                Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 200,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                            YMargin(17),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child:
                              SkeletonAnimation(
                                shimmerColor:
                                Color(0xffEEF1F1),
                                gradientColor: AppColors.kBottomNav.withOpacity(0.5),
                                child:
                                Container(
                                  height: 25,
                                  width: 100,
                                  decoration:
                                  BoxDecoration(
                                    color: Color(0xffEEF1F1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
