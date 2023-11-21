import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/component/code_snackbar.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/component/verification_textfield.dart';
import 'package:pard_app/controllers/phone_verification_controller.dart';
import 'package:pard_app/component/tos_statement.dart';
import 'package:pard_app/controllers/point_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/auth_controller.dart';

class NumberAuthView extends StatelessWidget {
  const NumberAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final PhoneVerificationController phoneVerificationController =
        Get.put(PhoneVerificationController());
    final UserController userController = Get.put(UserController());
    final AuthController authController = Get.put(AuthController());
    final PointController pointController = Get.put(PointController());
    final FocusNode phoneFocus = FocusNode();
    final FocusNode codeFocus = FocusNode();

    const String phoneValidation = '* PARD 회원으로 등록된 전화번호가 아니예요.';
    const String codeValidation = '* 잘못된 인증번호예요. 다시 입력해주세요.';

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          phoneFocus.unfocus();
          codeFocus.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: const PardAppBar('PARD 회원인증'),
          body: Obx(
            () => Center(
              child: Column(
                children: [
                  TosDescription(
                      'PARD 회원임을 인증하기 위해', 'PARD 등록에 사용한 전화번호', '를 입력해주세요.'),
                  SizedBox(
                    height: 48.h,
                  ),
                  SizedBox(
                    width: 327.w,
                    child: Text(
                      '전화번호',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          height: 20.h / 16.h,
                          color: Theme.of(context).colorScheme.surface),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                    width: 327.w,
                    height: 48.h,
                    child: Row(
                      children: [
                        VerificationTextField(
                          phoneFocus,
                          phoneVerificationController,
                          '전화번호를 입력해주세요.',
                          formatter: PhoneNumberFormatter(),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        GestureDetector(
                          onTap: () async {
                            phoneFocus.unfocus();
                            print(phoneVerificationController
                                .phoneTextFormField.value);
                            // Timer
                            if (phoneVerificationController
                                    .isTimerRunning.value ==
                                false) {
                              phoneVerificationController.startTimer();
                              phoneVerificationController
                                      .isCorrectPhoneNumber.value =
                                  await phoneVerificationController
                                      .isVerifyPhoneNumber(
                                          phoneVerificationController
                                              .phoneTextFormField.value);
                              if (phoneVerificationController
                                          .isCorrectPhoneNumber.value !=
                                      null &&
                                  phoneVerificationController
                                          .isCorrectPhoneNumber.value ==
                                      true) {
                                await phoneVerificationController
                                    .sendPhoneNumber(context);
                                print(
                                    '인증번호: ${phoneVerificationController.verificationCodeFromAuth.value}');
                              }
                            }
                          },
                          child: Container(
                            width: 108.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: phoneVerificationController
                                          .phoneTextFormField.value ==
                                      ''
                                  ? grayScale[30]
                                  : Theme.of(context).colorScheme.onSecondary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.w)),
                            ),
                            child: Center(
                              child: Text(
                                phoneVerificationController.isTimerRunning.value
                                    ? '${phoneVerificationController.seconds.value}s'
                                    : '인증번호 받기',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                      width: 327.w,
                      height: 26.h,
                      child: Text(
                        phoneVerificationController
                                        .isCorrectPhoneNumber.value !=
                                    null &&
                                phoneVerificationController
                                        .isCorrectPhoneNumber.value ==
                                    false
                            ? phoneValidation
                            : '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          height: 16.h / 12.h,
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      )),
                  SizedBox(
                    height: 14.h,
                  ),
                  SizedBox(
                    width: 327.w,
                    child: Text(
                      '인증번호',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          height: 20.h / 16.h,
                          color: Theme.of(context).colorScheme.surface),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                    width: 327.w,
                    height: 48.h,
                    child: Row(
                      children: [
                        VerificationTextField(codeFocus,
                            phoneVerificationController, '인증번호(6자리)를 입력해주세요.'),
                        SizedBox(
                          width: 8.w,
                        ),
                        GestureDetector(
                          onTap: () async {
                            codeFocus.unfocus();
                            await phoneVerificationController
                                .verifyCode(context);
                          },
                          child: Container(
                            width: 108.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: phoneVerificationController
                                          .codeTextFormField.value ==
                                      ''
                                  ? grayScale[30]
                                  : Theme.of(context).colorScheme.onSecondary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.w)),
                            ),
                            child: Center(
                              child: Text(
                                '인증번호 확인',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                      width: 327.w,
                      height: 26.h,
                      child: Text(
                        phoneVerificationController.isCorrectCode.value !=
                                    null &&
                                phoneVerificationController
                                        .isCorrectCode.value ==
                                    false
                            ? codeValidation
                            : '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          height: 16.h / 12.h,
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      )),
                  SizedBox(
                    height: 172.h,
                  ),
                  phoneVerificationController.snackBar.value,
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                      child: Container(
                        width: 327.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          gradient: phoneVerificationController
                                      .isCorrectCode.value ??
                                  false
                              ? LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.onSecondary,
                                    Theme.of(context).colorScheme.secondary,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                )
                              : null,
                          color: !(phoneVerificationController
                                      .isCorrectCode.value ??
                                  false)
                              ? grayScale[30]
                              : null,
                          borderRadius: BorderRadius.all(Radius.circular(8.w)),
                        ),
                        child: Center(
                          child: Text(
                            'PARD 회원 인증하기',
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                height: 24.h / 18.h,
                                color: whiteScale[100]),
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (phoneVerificationController.isCorrectCode.value ??
                            false) {
                          await userController
                              .setUserByEmail(authController.userEmail.value!);
                          await userController.getUserInfoByEmail(
                              authController.userEmail.value!);
                          await authController.sStorage.value.write(
                              key: 'login',
                              value: authController.userEmail.value!);
                          await pointController.fetchAndSortUserPoints();
                          await pointController.fetchCurrentUserPoints();
                          await Get.toNamed('/home');
                        }
                      }),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse(
                          'https://docs.google.com/forms/d/e/1FAIpQLSdXG9ZFrKHz2n5K42r249IYneuJ4urArmYtxs6qv_13IwtO4g/viewform?usp=sf_link'));
                    },
                    child: Text(
                      '회원 인증에 실패하셨나요?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        height: 20.h / 14.h,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
