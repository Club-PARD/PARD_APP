import 'dart:async';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pard_app/controllers/user_controller.dart';

class AuthController extends GetxController {
  final UserController _userController = Get.put(UserController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<String?> userEmail = Rx<String?>(null); // 1차적으로 이메일 저장(휴대폰 인증 전 필요)
  Rx<User?> user = Rx<User?>(null);
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  RxBool isAgree = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());

    // ever(user, (User? user) async {
    //   if (user != null) {
    //     userEmail.value = user.email;
    //     if (userEmail.value != null) {
    //       await _userController.getUserInfoByEmail(userEmail.value!);
    //     }
    //   } else {
    //     // 사용자가 로그아웃한 경우, user 및 userEmail 초기화
    //     user = null;
    //     userEmail.value = null;
    //   }
    // });
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
            Get.toNamed('/home');
            // Get.toNamed('/mypage');
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
      Get.toNamed('/');
    } catch (error) {
      print('Sign Out Error: $error');
    }
  }
}
