import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PointPolicyDialog {
  final BuildContext context;
  final GlobalKey buttonKey;
  const PointPolicyDialog(
    this.context,
    this.buttonKey,
  );

  void showPointPolicyDialog() {
    final RenderBox buttonBox =
        buttonKey.currentContext!.findRenderObject() as RenderBox;
    final buttonPosition = buttonBox.localToGlobal(Offset.zero);

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              left: buttonPosition.dx - 244.w,
              top: buttonPosition.dy - 45.h,
              child: Dialog(
                shadowColor: Colors.white.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Container(
                  width: 312.w,
                  height: 182.h,
                  padding: EdgeInsets.only(
                    left: 16.w,
                    top: 16.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: GradientBoxBorder(
                      width: 1.w,
                      gradient: LinearGradient(colors: [
                        Theme.of(context).colorScheme.onSecondary,
                        Theme.of(context).colorScheme.secondary,
                      ]),
                    ),
                    color: backgroundColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // MVP
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          pointContainer('MVP'),
                          SizedBox(width: 6.w),
                          Text(
                            '연합 세미나, 숏커톤, 서핑데이에서 조별 1명 선발',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: 10.sp,
                                  // height: 14.sp / 10.sp,
                                ),
                          ),
                          SizedBox(width: 4.w),
                          specificPoints('5점', 27.w),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  color: grayScale[60],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      // Study
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          pointContainer('스터디'),
                          SizedBox(width: 6.w),
                          Text(
                            '개최 및 수료',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: 10.sp,
                                  // height: 14.sp / 10.sp,
                                ),
                          ),
                          SizedBox(width: 4.w),
                          specificPoints('5점', 27.w),
                          SizedBox(width: 6.w),
                          Text(
                            '참여 및 수료',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: 10.sp,
                                  // height: 14.sp / 10.sp,
                                ),
                          ),
                          SizedBox(width: 4.w),
                          specificPoints('3점', 27.w),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      // communcation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          pointContainer('소통'),
                          SizedBox(width: 6.w),
                          Text(
                            '파드 구성원과의 만남 후 사진을 슬랙에 인증',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: 10.sp,
                                  // height: 14.sp / 10.sp,
                                ),
                          ),
                          SizedBox(width: 4.w),
                          specificPoints('1점/주 1회', 52.w),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      // retrospection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          pointContainer('회고'),
                          SizedBox(width: 6.w),
                          Text(
                            '디스콰이엇 작성 후 파트장에게 공유',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: 10.sp,
                                  // height: 14.sp / 10.sp,
                                ),
                          ),
                          SizedBox(width: 4.w),
                          specificPoints('3점/필수과제 제외', 82.w),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      // beePoint
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          pointContainer('벌점'),
                          SizedBox(width: 6.w),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '세미나 지각',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontSize: 10.sp,
                                          // height: 14.sp / 10.sp,
                                        ),
                                  ),
                                  SizedBox(width: 4.w),
                                  specificPoints('-1점', 29.w),
                                  SizedBox(width: 6.w),
                                  Text(
                                    '세미나 결석',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontSize: 10.sp,
                                          // height: 14.sp / 10.sp,
                                        ),
                                  ),
                                  SizedBox(width: 4.w),
                                  specificPoints('-2점', 31.w),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Text(
                                    '과제 지각',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontSize: 10.sp,
                                          // height: 14.sp / 10.sp,
                                        ),
                                  ),
                                  SizedBox(width: 4.w),
                                  specificPoints('-0.5점', 39.w),
                                  SizedBox(width: 6.w),
                                  Text(
                                    '과제 미제출',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontSize: 10.sp,
                                          // height: 14.sp / 10.sp,
                                        ),
                                  ),
                                  SizedBox(width: 4.w),
                                  specificPoints('-1점', 29.w),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget pointContainer(String content) {
    return Container(
      width: 40.w,
      height: 20.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: content == '벌점'
            ? Border.all(color: errorRed, width: 1.w)
            : GradientBoxBorder(
                width: 1.w,
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.onSecondary,
                  Theme.of(context).colorScheme.secondary,
                ]),
              ),
        gradient: content == '벌점'
            ? LinearGradient(colors: [
                Theme.of(context).colorScheme.error.withOpacity(0.1),
                Theme.of(context).colorScheme.error.withOpacity(0.1),
              ])
            : LinearGradient(colors: [
                Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
                Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              ]),
      ),
      child: Center(
        child: GradientText(
          content,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 10.sp, height: 0),
          colors: content == '벌점'
              ? [errorRed, errorRed]
              : [
                  Theme.of(context).colorScheme.onSecondary,
                  Theme.of(context).colorScheme.secondary,
                ],
        ),
      ),
    );
  }

  Widget specificPoints(String content, double width) {
    return Container(
      width: width,
      height: 17.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: containerBackgroundColor,
      ),
      child: Center(
        child: Text(
          content,
          style: TextStyle(
            fontSize: 9.6.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Pretendard',
            color: grayScale[30],
          ),
        ),
      ),
    );
  }
}
