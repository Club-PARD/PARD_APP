import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/auth_controller.dart';


class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    double unit_height = MediaQuery.of(context).size.height / 812;
    double unit_width = MediaQuery.of(context).size.width / 375;
    final AuthController _authController = Get.put(AuthController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(26, 26, 26, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: unit_height * 90,
            ),
            Text(
              'Pay it Foward를 실천하는 IT 협업 동아리',
              style: TextStyle(
                  fontSize: 12, color: Color.fromRGBO(228, 228, 228, 1)),
            ),
            SizedBox(
              height: unit_height * 12,
            ),
            Image.asset(
              'assets/images/logo_text.png',
              width: unit_width * 240,
              height: unit_height * 50,
            ),
            SizedBox(
              height: unit_height * 112,
            ),
            Image.asset(
              'assets/images/logo_image.png',
              height: unit_height * 178,
            ),
            SizedBox(
              height: unit_height * 162,
            ),
            GestureDetector(
              child: Container(
                width: unit_width * 327,
                height: unit_height * 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(82, 98, 245, 1),
                    Color.fromRGBO(123, 63, 239, 1),
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo_google.png', height: 22,),
                    SizedBox(width: 8,),
                    Text('구글로 로그인 하기',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
              onTap: () {
                _authController.signInWithGoogle();
              }
            ),
          ],
        ),
      ),
    );
  }
}
