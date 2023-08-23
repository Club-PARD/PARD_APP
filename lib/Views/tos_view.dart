import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/controllers/auth_controller.dart';
import 'package:pard_app/component/tos_statement.dart';
import 'package:pard_app/component/next_button.dart';

class TosView extends StatelessWidget {
  const TosView({super.key});

  @override
  Widget build(BuildContext context) {
    double unit_height = MediaQuery.of(context).size.height / 812;
    double unit_width = MediaQuery.of(context).size.width / 375;
    double appBar_height = AppBar().preferredSize.height;

    final AuthController _authController = Get.put(AuthController());

    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(26, 26, 26, 1),
          appBar: PardAppBar('이용약관'),
          body: Obx(
            () => Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                children: [
                  SizedBox(
                    height: unit_height * 56 - appBar_height,
                  ),
                  tosDescription(unit_height, unit_width, '서비스 가입 및 이용을 위해',
                      '서비스 이용약관', '에 동의해주세요'),
                  SizedBox(
                    height: unit_height * 48,
                  ),
                  Row(
                    children: [
                      checkbox(_authController.isAgree, unit_width * 20,
                          unit_height * 20),
                      SizedBox(
                        width: unit_width * 4,
                      ),
                      Text(
                        '서비스 이용약관 전체동의',
                        style: TextStyle(
                            fontSize: 16,
                            color: _authController.isAgree.value
                                ? Color.fromRGBO(82, 98, 245, 1)
                                : Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: unit_height * 16,
                  ),
                  tosAgreement(unit_height, unit_width),
                  SizedBox(
                    height: unit_height * 316,
                  ),
                  nextButton('다음', '/numberauth', unit_width, unit_height,
                      _authController.isAgree.value, null),
                ],
              ),
            ),
          )),
    );
  }
}
