import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pard_app/controllers/error_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  final UserController _userController = Get.put(UserController());
  final ErrorController _errorController = Get.put(ErrorController());
  late String? uid = _userController.userInfo.value?.uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Rx<FlutterSecureStorage> sStorage = const FlutterSecureStorage().obs;
  Rx<String?> userEmail = Rx<String?>(null); // 1차적으로 이메일 저장(휴대폰 인증 전 필요)
  Rx<User?> user = Rx<User?>(null);
  RxBool isAgree = false.obs;
  RxBool isLogin = true.obs;

  checkPreviousLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 첫 앱 실행인지 구분
      if (prefs.getBool('first_run') ?? true) {
        await sStorage.value.deleteAll();
        prefs.setBool('first_run', false);
      }
      String? email = await sStorage.value.read(key: 'login');
      userEmail.value = email;
      print('checkPreviousLogin() ${userEmail.value}');
      if (email == null ||
          (await _userController.isVerifyUserByEmail(email) == false)) {
        print('로그인 이력 없음: 로그인 필요');
        isLogin.value = false;
      } else {
        print("auth_controller: ${_userController.hashCode}");
        await _userController.getUserInfoByEmail(email);
        await _userController.updateTimeByEmail(email);
        Get.toNamed('/home');
        isLogin.value = true;
      }
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'checkPreviousLogin()',
      );
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
            await sStorage.value.write(key: 'login', value: user.email!);
            Get.toNamed('/home');
          } else {
            Get.toNamed('/tos');
          }
        }
      }
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'signInWithGoogle()',
      );
    }
  }

  Future<void> signInWithApple() async {
    try {
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

      userEmail.value = appleCredential.email; //애플에서 받아온 email을 Rx email에 넣는다

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // if (appleCredential.email == null) {
      //   List<String> jwt = appleCredential.identityToken?.split('.') ?? [];
      //   String payload = jwt[1];
      //   payload = base64.normalize(payload);

      //   final List<int> jsonData = base64.decode(payload);
      //   final userInfo = jsonDecode(utf8.decode(jsonData));
      //   print('--------------DECODED USERINFO-----------------');
      //   print(userInfo);
      //   String email = userInfo['email'];
      //   print('-----------DECODED Email----------------------');
      //   print(email);
      //   userEmail.value = email;
      // }

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      final User? user = authResult.user;

      if (user != null) {
        // 이전에 휴대폰 인증을 해서 저장한 email 정보가 있으면 로그인 후 번호인증 생략
        bool isUserExists =
            await _userController.isVerifyUserByEmail(userEmail.value!);
        if (isUserExists) {
          await _userController.updateTimeByEmail(userEmail.value!);
          await _userController.getUserInfoByEmail(userEmail.value!);
          await sStorage.value.write(key: 'login', value: userEmail.value!);
          Get.toNamed('/home');
        } else {
          Get.toNamed('/tos');
        }
      }
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'signInWithApple()',
      );
    }
  }

  //탈퇴하기
  Future<void> deleteUserFields() async {
    try {
      print('----------------------------탈퇴하기 uid------------------------');
      print(uid);

      // _firestore; //파이어스토어 인스턴스 가져옴
      await _firestore
          .collection('points')
          .doc(_userController.userInfo.value!.pid)
          .delete();
      await _firestore.collection('users').doc(uid).delete();

      await _auth.currentUser?.delete();
      await sStorage.value.deleteAll();
      await _auth.signOut();
      await _googleSignIn.signOut();
      Get.offAllNamed('/', predicate: (route) => Get.currentRoute == '/');
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'deleteUserFields()',
      );
    }
  }

  //로그아웃
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await sStorage.value.delete(key: 'login');
      Get.offAllNamed('/', predicate: (route) => Get.currentRoute == '/');
    } catch (e) {
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'signOut()',
      );
    }
  }
}
