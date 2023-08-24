import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:url_launcher/url_launcher.dart';

Widget tosAgreement(BuildContext context) {
  return Container(
    width: 327.w,
    height: 104.h,
    decoration: BoxDecoration(
        color: const Color(0xff2A2A2A),
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
        border: Border.all(
          color: grayScale[30]!,
          width: 1,
        )),
    child: Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                Icons.check,
                size: 14.sp,
                color: Theme.of(context).colorScheme.surface,
              ),
              SizedBox(
                width: 4.w,
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(
                      'https://pardhgu.notion.site/Pard-APP-fbccc11671d14b4d8012dd999eff7f93?pvs=4'));
                },
                child: Text('개인정보 수집 및 이용 동의(필수)',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      height: 20 / 14,
                      color: Theme.of(context).colorScheme.surface,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.check,
                size: 14.sp,
                color: Theme.of(context).colorScheme.surface,
              ),
              SizedBox(
                width: 4.w,
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(
                      'https://pardhgu.notion.site/Pard-APP-18c93fe8a2c648009e17d1ab294a4fa9?pvs=4'));
                },
                child: Text(
                  '서비스 이용약관(필수)',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 20 / 14,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget tosDescription(
    BuildContext context, String string1, String string2, String string3) {
  return Container(
    width: 327.w,
    height: 68.h,
    decoration: BoxDecoration(
        color: const Color(0xff2A2A2A),
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
        border: Border.all(
          color: grayScale[30]!,
          width: 1,
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          string1,
          style: TextStyle(
            fontSize: 14.sp,
            color: grayScale[30],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              string2,
              style: TextStyle(
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.onSecondary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(Rect.fromLTWH(
                      0, 0, 327.w, 68.h)), // Adjust the Rect as needed
                fontSize: 14.sp,
              ),
            ),
            Text(
              string3,
              style: TextStyle(
                fontSize: 14.sp,
                color: grayScale[30],
              ),
            )
          ],
        ),
      ],
    ),
  );
} 

Widget checkbox(
    BuildContext context, RxBool isAgree, double height) {
  return GestureDetector(
    onTap: () {
      isAgree.value = !(isAgree.value);
    },
    child: SizedBox(
      width: height,
      height: height,
      child: Container(
        width: (16.25).h,
        height: (16.25).h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular((1.88).w)),
          color: isAgree.value
              ? Theme.of(context).colorScheme.onSecondary
              : grayScale[30],
        ),
        child: Center(child: Icon(Icons.check, size: (14.37).sp, color: blackScale[100],)),
      ),
    ),
  );
}
