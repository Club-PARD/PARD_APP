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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: const PardAppBar('이용약관'),
          body: Obx(
            () => Center(
              child: Column(
                children: [
                  TosDescription('서비스 가입 및 이용을 위해', '서비스 이용약관', '에 동의해주세요'),
                  SizedBox(
                    height: 48.h,
                  ),
                  SizedBox(
                    width: 327.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TosCheckbox(authController.isAgree, 20.h),
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
                  TosAgreement(
                      '개인정보 수집 및 이용 동의(필수)',
                      'https://we-pard.notion.site/Pard-APP-fc37c472e47941d3958765587b57e21f?pvs=4',
                      '서비스 이용약관(필수)',
                      'https://we-pard.notion.site/Pard-APP-74f6a4d8383d4e4993f28e9463b0d9b0?pvs=4'),
                  SizedBox(
                    height: 316.h,
                  ),
                  NextButton('다음', '/numberauth', authController.isAgree.value,),
                ],
              ),
            ),
          ),
        ));
  }
}
