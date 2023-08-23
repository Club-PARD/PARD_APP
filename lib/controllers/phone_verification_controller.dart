import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/user_controller.dart';

import '../model/user_model/user_model.dart';
import 'auth_controller.dart';

class PhoneVerificationController extends GetxController {
  final AuthController _authController = Get.put(AuthController());
  final UserController _userController = Get.put(UserController());
  RxString phoneTextFormField = ''.obs;
  RxString codeTextFormField = ''.obs;
  Rx<String?> findedUID = Rx<String?>(null);
  Rx<String> verificationCodeFromAuth = ''.obs;
  Rx<bool?> isCorrectPhoneNumber = Rx(null);
  Rx<bool?> isCorrectCode = Rx(null);
  Rx<bool> isFocused = Rx(false);
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    } catch (error) {
      print("Error while verifying phone number: $error");
      return false;
    }
  }

  //인증번호 전송, 인증번호 return
  Future<void> sendPhoneNumber() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verficationId) {},
      phoneNumber: '+82${phoneTextFormField.substring(1).replaceAll('-', '')}',
      verificationCompleted: (verificationCompleted) async {
        // String verificationId = verificationCompleted as String;
        // verificationCompleter.complete(verificationId);
        print("번호 인증 성공");
      },
      verificationFailed: (verificationFailed) async {
        // verificationCompleter.completeError(verificationFailed.code);
        print(verificationFailed.code);
        print("인증번호 전송 실패");
      },
      codeSent: (verificationId, resendingToken) async {
        // verificationCompleter.complete(verificationId);
        // codeCompleter.complete(verificationId); // Complete the codeCompleter
        verificationCodeFromAuth.value = verificationId;
        print("인증번호 전송 완료");
      },
    );
  }

  void verifyCode(BuildContext context) async {
    print(codeTextFormField.value);
    print(verificationCodeFromAuth.value);

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
        await _userController.getUserInfoByUID(uid);
        // 토스트 메시지 출력
        codeValidationSnackBar(context);
        print('인증성공');
        UserModel? user = _userController.userInfo.value;
        if (user != null) {
          print('사용자 정보:');
          print('uid: ${user.uid}');
          print('name: ${user.name}');
          print('phone: ${user.phone}');
          print('email: ${user.email}');
          print('part: ${user.part}');
          print('member: ${user.member}');
          print('generation: ${user.generation}');
          print('isAdmin: ${user.isAdmin}');
          print('isMaster: ${user.isMaster}');
          print('lastLogin: ${user.lastLogin}');
        }
      }
    } else {
      print('인증실패');
    }
  }

  void codeValidationSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Container(
        height: 40, // 세로 40px
        width: 343, // 가로 343px
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), // 테두리 radius: 8px
          color: Color.fromRGBO(26, 26, 26, 1), // Container 배경색
          border: Border.all(
            width: 1, // 테두리 두께: 1px
          ),
        ),
        child: Center(
          child: Text(
            '인증번호가 확인되었어요.',
            style: TextStyle(
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [
                    Color.fromRGBO(82, 98, 245, 1),
                    Color.fromRGBO(123, 63, 239, 1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(
                    Rect.fromLTWH(0, 0, 100, 0)), // Adjust the Rect as needed
              fontSize: 14,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent, // 배경색: 투명
      duration: Duration(seconds: 3), // 메시지 표시 시간: 3초
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
