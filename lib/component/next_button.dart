import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/spring_user_controller.dart';
import 'package:pard_app/utilities/color_style.dart';

class NextButton extends StatelessWidget {
  final String title;
  final String route;
  final bool isNext;
  final VoidCallback? function;
  final String token;

  const NextButton(
    this.title,
    this.route,
    this.isNext, 
    this.token,{super.key, 
    this.function,
  });

  @override
  Widget build(BuildContext context) {
      final SpringUserController springUserController = Get.find();

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
            borderRadius: BorderRadius.all(Radius.circular(8.w)),
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
        onTap: () async {
          if (isNext) {
            if (function != null) {
              function!();
            }
            await springUserController.fetchUser(token);
            await Get.toNamed(route);
          }
        });
  }
}
