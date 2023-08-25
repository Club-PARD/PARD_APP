import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/controllers/auth_controller.dart';
import 'package:pard_app/component/tos_statement.dart';
import 'package:pard_app/component/next_button.dart';

class TosView extends StatelessWidget {
  const TosView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: PardAppBar('이용약관'),
          body: Obx(
            () => Center(
              child: Column(
                children: [
                  tosDescription(
                      context, '서비스 가입 및 이용을 위해', '서비스 이용약관', '에 동의해주세요'),
                  SizedBox(
                    height: 48.h,
                  ),
                  SizedBox(
                    width: 327.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        checkbox(context, authController.isAgree, 20.h),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          '서비스 이용약관 전체동의',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              height: 20.h / 16.h,
                              color: authController.isAgree.value
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : Theme.of(context).colorScheme.surface),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  tosAgreement(context),
                  SizedBox(
                    height: 316.h,
                  ),
                  nextButton(context, '다음', '/numberauth',
                      authController.isAgree.value, null),
                ],
              ),
            ),
          )),
    );
  }
}
