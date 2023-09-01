import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController extends GetxController {
  final UserController _userController = Get.put(UserController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<String?> userEmail = Rx<String?>(null); // 1차적으로 이메일 저장(휴대폰 인증 전 필요)
  Rx<User?> user = Rx<User?>(null);
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  RxBool isAgree = false.obs;
  RxBool isLogin = true.obs;

  Rx<FlutterSecureStorage> sStorage = FlutterSecureStorage().obs;

  checkPreviousLogin() async {
    String? uid = await sStorage.value.read(key: 'login');
    print(uid);
    if (uid != null) {
      await _userController.getUserInfoByUID(uid);
      await _userController.updateTimeByEmail(_userController.userInfo.value!.email!);
      Get.offAllNamed('/home');
      isLogin.value = true;
    } else {
      print('로그인 이력 없음: 로그인 필요');
      isLogin.value = false;
    }
  }

  //로그인
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null) {
          // 이전에 휴대폰 인증을 해서 저장한 email 정보가 있으면 로그인 후 번호인증 생략
          userEmail.value = user.email;
          print(userEmail.value);
          bool isUserExists =
              await _userController.isVerifyUserByEmail(user.email!);
          if (isUserExists) {
            await _userController.updateTimeByEmail(user.email!);
            await _userController.getUserInfoByEmail(user.email!);
            await sStorage.value.write(key: 'login', value: _userController.userInfo.value!.uid);
            Get.toNamed('/home');
          } else
            Get.toNamed('/tos');
        }
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  //로그아웃
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await sStorage.value.delete(key: 'login');
      Get.toNamed('/');
    } catch (error) {
      print('Sign Out Error: $error');
    }
  }
}
