import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  final UserController _userController = Get.put(UserController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<String?> userEmail = Rx<String?>(null); // 1차적으로 이메일 저장(휴대폰 인증 전 필요)
  Rx<User?> user = Rx<User?>(null);
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  RxBool isAgree = false.obs;
  RxBool isLogin = true.obs;

  Rx<FlutterSecureStorage> sStorage = const FlutterSecureStorage().obs;

  checkPreviousLogin() async {
    String? email = await sStorage.value.read(key: 'login');
    print(email);
    if (email == null || !await _userController.isVerifyUserByEmail(email)) {
      print('로그인 이력 없음: 로그인 필요');
      isLogin.value = false;
    } else {
      await _userController.getUserInfoByEmail(email);
      await _userController.updateTimeByEmail(email);
      Get.offAllNamed('/home');
      isLogin.value = true;
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
            await sStorage.value.write(
                key: 'login', value: user.email!);
            Get.toNamed('/home');
          } else {
            Get.toNamed('/tos');
          }
        }
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  Future<void> signInWithApple() async {
  try {
    //앱에서 애플 로그인 창을 호출하고, apple계정의 credential을 가져온다.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: "com.pard.service",
        redirectUri: Uri.parse(
            "https://evergreen-glory-sagittarius.glitch.me/callbacks/sign_in_with_apple"),
      ),
    );

    print('-------APPLE ID오ㅏ EMAIL확인------------');
    print('-------APPLE ID오ㅏ EMAIL확인------------');
    print('-------APPLE ID오ㅏ EMAIL확인------------');
    print('-------APPLE ID오ㅏ EMAIL확인------------');
    print('-------APPLE ID오ㅏ EMAIL확인------------');
    print('-------APPLE ID오ㅏ EMAIL확인------------');
    print('givenName: ${appleCredential.givenName}');
    print('familyName: ${appleCredential.familyName}');
    print('email: ${appleCredential.email}');

//그 credential을 넣어서 OAuth를 생성
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    print('-------APPLE ID오ㅏ EMAIL확인------------');
    print('-------APPLE ID오ㅏ EMAIL확인------------');
    print('-------APPLE ID오ㅏ EMAIL확인------------');
    print('-------APPLE ID오ㅏ EMAIL확인------------');
    print('-------APPLE ID오ㅏ EMAIL확인------------');
    print('-------APPLE ID오ㅏ EMAIL확인------------');
    
    //OAuth를 넣어서 firebase유저 생성
    final UserCredential authResult = 
        await _auth.signInWithCredential(oauthCredential);
    final User? user = authResult.user;
    
    DocumentSnapshot? userDoc = await _firestore.collection('users').doc(user?.uid).get();
    if (user != null) {
      userEmail.value = appleCredential.email;  //애플에서 받아온 email을 Rx email에 넣는다
          // 이전에 휴대폰 인증을 해서 저장한 email 정보가 있으면 로그인 후 번호인증 생략
          print('-------------------USER EMAIL ----------------');
          print(userEmail.value);
          print(user.uid);
          print(userDoc.data());
bool isUserExists =
              await _userController.isVerifyUserByEmail(appleCredential.email!);
          if (isUserExists) {
            await _userController.updateTimeByEmail(appleCredential.email!);
            await _userController.getUserInfoByEmail(appleCredential.email!);
            await sStorage.value.write(
                key: 'login', value: appleCredential.email!);
            Get.toNamed('/home');
          } else {
            Get.toNamed('/tos');
          }    
        }
    } catch (error) {
      print("Apple Sign-In Error: $error");
    }
  }

   


  //로그아웃
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await sStorage.value.delete(key: 'login');
      Get.offAllNamed('/');
    } catch (error) {
      print('Sign Out Error: $error');
    }
  }
}