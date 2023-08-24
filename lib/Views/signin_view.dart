import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/auth_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/utilities/color_style.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.put(AuthController());
    final UserController _userController = Get.put(UserController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 146.h,
            ),
            Text('Pay it Foward를 실천하는 IT 협업 동아리', style: Theme.of(context).textTheme.titleSmall),
            SizedBox(
              height: 12.h,
            ),
            Image.asset(
              'assets/images/logo_text.png',
              width: 240.h,
              height: 50.h,
            ),
            SizedBox(
              height: 112.h,
            ),
            Image.asset(
              'assets/images/logo_image.png',
              width: 461.w,
              height: 178.h,
            ),
            SizedBox(
              height: 162.h,
            ),
            GestureDetector(
                child: Container(
                  width: 327.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.onSecondary,
                      Theme.of(context).colorScheme.secondary,
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo_google.png',
                        height: 22.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        '구글로 로그인 하기',
                        style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              height: 24.h / 18.h,
                              color: whiteScale[100]),
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  await _userController.getDeviceInfo();
                  print(
                      '디바이스 명: ${_userController.deviceName}, 디바이스 버전: ${_userController.deviceVersion}');
                  _authController.signInWithGoogle();
                }),
          ],
        ),
      ),
    );
  }
}