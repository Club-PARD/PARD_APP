import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/component/verification_textfield.dart';
import 'package:pard_app/controllers/phone_verification_controller.dart';
import 'package:pard_app/component/tos_statement.dart';
import 'package:pard_app/component/next_button.dart';
import 'package:pard_app/controllers/user_controller.dart';

import '../controllers/auth_controller.dart';

class NumberAuthView extends StatelessWidget {
  const NumberAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final PhoneVerificationController _phoneVerificationController =
        Get.put(PhoneVerificationController());
    final UserController _userController =
        Get.put(UserController());
    final AuthController _authController =
        Get.put(AuthController());

    double unit_height = MediaQuery.of(context).size.height / 812;
    double unit_width = MediaQuery.of(context).size.width / 375;
    const String phoneValidation = '* PARD 회원으로 등록된 전화번호가 아니예요.';
    const String codeValidation = '* 잘못된 인증번호예요. 다시 입력해주세요.';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(26, 26, 26, 1),
        appBar: PardAppBar('PARD 회원인증'),
        body: Obx(
          () => Column(
            children: [
              tosDescription(unit_height, unit_width, 'PARD 회원임을 인증하기 위해',
                  'PARD 등록에 사용한 전화번호', '를 입력해주세요.'),
              SizedBox(
                height: unit_height * 48,
              ),
              Container(
                width: unit_width * 327,
                child: Text(
                  '전화번호',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(
                height: unit_height * 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  verificationTextField(
                      _phoneVerificationController,
                      PhoneNumberFormatter(),
                      '전화번호를 입력해주세요.',
                      unit_width,
                      unit_height),
                  SizedBox(
                    width: unit_width * 8,
                  ),
                  GestureDetector(
                    onTap: () async {
                      print(_phoneVerificationController
                          .phoneTextFormField.value);
                      _phoneVerificationController.isCorrectPhoneNumber.value =
                          await _phoneVerificationController
                              .isVerifyPhoneNumber(_phoneVerificationController
                                  .phoneTextFormField.value);
                      if (_phoneVerificationController
                                  .isCorrectPhoneNumber.value !=
                              null &&
                          _phoneVerificationController
                                  .isCorrectPhoneNumber.value ==
                              true) {
                        await _phoneVerificationController.sendPhoneNumber();
                        print(
                            '인증번호: ${_phoneVerificationController.verificationCodeFromAuth.value}');
                      }
                    },
                    child: Container(
                      width: unit_width * 108,
                      height: unit_height * 48,
                      decoration: BoxDecoration(
                        color: _phoneVerificationController
                                    .phoneTextFormField.value ==
                                ''
                            ? Color.fromRGBO(163, 163, 163, 1)
                            : Color.fromRGBO(82, 98, 245, 1),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Center(
                        child: const Text(
                          '인증번호 받기',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: unit_height * 8,
              ),
              Container(
                  width: unit_width * 327,
                  height: unit_height * 16,
                  child: Text(
                    _phoneVerificationController.isCorrectPhoneNumber.value !=
                                null &&
                            _phoneVerificationController
                                    .isCorrectPhoneNumber.value ==
                                false
                        ? phoneValidation
                        : '',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(255, 90, 90, 1),
                    ),
                  )),
              SizedBox(
                height: unit_height * 8,
              ),
              Container(
                width: unit_width * 327,
                child: Text(
                  '인증번호',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(
                height: unit_height * 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  verificationTextField(_phoneVerificationController, null,
                      '인증번호(6자리)를 입력해주세요.', unit_width, unit_height),
                  SizedBox(
                    width: unit_width * 8,
                  ),
                  GestureDetector(
                    onTap: () => _phoneVerificationController.verifyCode(context),
                    child: Container(
                      width: unit_width * 108,
                      height: unit_height * 48,
                      decoration: BoxDecoration(
                        color: _phoneVerificationController
                                    .codeTextFormField.value ==
                                ''
                            ? Color.fromRGBO(163, 163, 163, 1)
                            : Color.fromRGBO(82, 98, 245, 1),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Center(
                        child: Text(
                          '인증번호 확인',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: unit_height * 8,
              ),
              Container(
                  width: unit_width * 327,
                  height: unit_height * 16,
                  child: Text(
                    _phoneVerificationController.isCorrectCode.value != null &&
                            _phoneVerificationController.isCorrectCode.value ==
                                false
                        ? codeValidation
                        : '',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(255, 90, 90, 1),
                    ),
                  )),
              SizedBox(
                height: unit_height * 232,
              ),
              // nextButton('PARD 회원 인증하기', '/mypage', unit_width, unit_height,
              //     _phoneVerificationController.isCorrectCode.value ?? false, () async {await _userController.updateTimeByEmail(_authController.userEmail.value!);}),
               nextButton('PARD 회원 인증하기', '/mypoint', unit_width, unit_height,
                  _phoneVerificationController.isCorrectCode.value ?? false, () async {await _userController.updateTimeByEmail(_authController.userEmail.value!);}),
              SizedBox(
                height: unit_height * 16,
              ),
              Text(
                '회원 인증에 실패하셨나요?',
                style: TextStyle(
                    color: Color.fromRGBO(82, 98, 245, 1), fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}