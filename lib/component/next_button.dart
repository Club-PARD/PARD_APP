import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/utilities/color_style.dart';

Widget nextButton(BuildContext context, title, String route, bool isNext,
    VoidCallback? function) {
  return GestureDetector(
      child: Container(
        width: 327.w,
        height: 56.h,
        decoration: BoxDecoration(
          gradient: isNext
              ? LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.onSecondary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: !isNext ? grayScale[30] : null,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                height: 24.h / 18.h,
                color: whiteScale[100]),
          ),
        ),
      ),
      onTap: () {
        if (isNext) {
          if (function != null) {
            function;
          }
          Get.toNamed(route);
        }
      });
}