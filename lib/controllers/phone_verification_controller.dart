import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/component/code_snackbar.dart';
import 'package:pard_app/controllers/error_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'auth_controller.dart';

class PhoneVerificationController extends GetxController {
  final AuthController _authController = Get.put(AuthController());
  final UserController _userController = Get.put(UserController());
  final ErrorController _errorController = Get.put(ErrorController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxString phoneTextFormField = ''.obs; //입력된 전화번호
  RxString codeTextFormField = ''.obs; //입력된 인증번호
  Rx<String?> findedUID = Rx<String?>(null);
  Rx<String> verificationCodeFromAuth = ''.obs; //전송된 인증번호
  Rx<bool?> isCorrectPhoneNumber = Rx(null); //올바른 전화번호 체크
  Rx<bool?> isCorrectCode = Rx(null); //올바른 인증번호 체크
  Rx<Widget> snackBar = Container(
    height: 40.h,
  ).obs;

  // Timer
  RxInt seconds = 60.obs;
  RxBool isTimerRunning = false.obs;
  Rx<Timer> timer = Timer.periodic(const Duration(seconds: 1), (timer) {}).obs;

  void startTimer() {
    isTimerRunning.value = true;
    timer.value = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds.value--;
      if (seconds.value == 0) stopTimer();
    });
  }

  void stopTimer() {
    isTimerRunning.value = false;
    seconds.value = 60;
    timer.value.cancel();
  }

  //입력한 전화번호가 데이터베이스에 있는지 확인
  Future<bool> isVerifyPhoneNumber(String inputNumber) async {
    String phoneNumber = inputNumber;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('phone', isEqualTo: phoneNumber)
              .get();

      if (querySnapshot.docs.isEmpty) {
        print("저장된 번호 없음");
        return false;
      } else {
        print("저장된 번호 있음");
        findedUID = Rx<String?>(querySnapshot.docs.first.id);
        return true;
      }
    } catch (e) {
      print("Error while verifying phone number: $e");
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'isVerifyPhoneNumber()',
      );
      return false;
    }
  }

  //인증번호 전송
  Future<void> sendPhoneNumber(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verficationId) {},
        phoneNumber:
            '+82${phoneTextFormField.substring(1).replaceAll('-', '')}',
        verificationCompleted: (verificationCompleted) async {
          print("번호 인증 성공");
        },
        verificationFailed: (verificationFailed) async {
          print(verificationFailed.code);
          print("인증번호 전송 실패");
        },
        codeSent: (verificationId, resendingToken) async {
          verificationCodeFromAuth.value = verificationId;
          snackBar.value = const CodeSnackBar('인증번호를 발송했어요.').build(context);
          await Future.delayed(const Duration(seconds: 3));
          snackBar.value = Container(height: 40.h);
          print("인증번호 전송 완료");
        },
      );
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'sendPhoneNumber()',
      );
    }
  }

  //인증번호 일치 확인, user정보 가져오기
  void verifyCode(BuildContext context) async {
    print(codeTextFormField.value);
    print(verificationCodeFromAuth.value);
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationCodeFromAuth.value,
          smsCode: codeTextFormField.value);
      isCorrectCode.value =
          await signInWithPhoneAuthCredential(phoneAuthCredential);
      if (isCorrectCode.value != null && isCorrectCode.value == true) {
        // 코드가 일치하는 경우
        // 이전 페이지에서 저장한 이메일 가져오기
        String email = _authController.userEmail.value!;
        print(email);

        if (email.isNotEmpty) {
          String uid = findedUID.value!;
          await _userController.saveEmail(uid, email);
          // 토스트 메시지 출력
          snackBar.value = const CodeSnackBar('인증번호가 확인되었어요.').build(context);
          await Future.delayed(const Duration(seconds: 3));
          snackBar.value = Container(height: 40.h);
          print('인증성공');
        }
      } else {
        print('인증실패');
      }
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'verifyCode()',
      );
    }
  }

  //인증번호 인증성공 토스트 메시지
  void codeValidationSnackBar(BuildContext context, String text) {
    final snackBar = Positioned(
      bottom: 152.h,
      left: 16.w,
      right: 16.w,
      child: Container(
        height: 40.h,
        width: 343.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.onSecondary,
              Theme.of(context).colorScheme.secondary,
            ]),
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(82, 98, 245, 0.1),
              Color.fromRGBO(123, 63, 239, 0.1),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: GradientText(
            text,
            style: headlineSmall,
            colors: const [
              primaryBlue,
              primaryPurple,
            ],
          ),
        ),
      ),
    );

    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) => snackBar);
    overlayState.insert(overlayEntry);
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  //휴대폰 인증, 인증 후 휴대폰 로그인 기록 삭제
  Future<bool> signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        await _auth.currentUser?.delete();
        print("auth정보삭제");
        _auth.signOut();
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException {
      print("인증실패");
      return false;
    }
  }
}
