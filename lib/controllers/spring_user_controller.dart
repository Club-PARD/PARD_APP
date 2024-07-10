import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pard_app/controllers/error_controller.dart';
import 'package:pard_app/model/user_model/user_info_model.dart';
import 'package:pard_app/model/user_model/user_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pard_app/model/user_model/user_info_model.dart' as pard_user;


class SpringUserController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _loadOnOffValue();
  }

  var isAgree = false.obs;
   Rx<pard_user.UserInfo?> userInfo = Rx<pard_user.UserInfo?>(null);
   final ErrorController _errorController = Get.put(ErrorController());
   final storage = const FlutterSecureStorage();
   RxBool? onOff = true.obs;
   Rx<String?> deviceName = Rx<String?>(null);
   Rx<String?> deviceVersion = Rx<String?>(null);

     Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (GetPlatform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceName.value = androidInfo.model; // Android 기기의 모델명
        deviceVersion.value = androidInfo.version.release; // Android 기기의 버전
      } else if (GetPlatform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceName.value = iosInfo.model; // iOS 기기의 모델명
        deviceVersion.value = iosInfo.systemVersion; // IOS 기기의 버전
      }
    } catch (e) {
      print("디바이스 모델명 불러오기 실패: $e");
      await _errorController.writeErrorLog(
        e.toString(),
        userInfo.value?.name ?? 'none',
        'getDeviceInfo()',
      );
    }
  }

   Future<void> _loadOnOffValue() async {
    String? value = await storage.read(key: 'onOff');
    if (value != null) {
      onOff!.value = value.toLowerCase() == 'true';
    }
  }

  Future<void> saveOnOffValue(bool value) async {
    await storage.write(key: 'onOff', value: value.toString());
  }

  Future<String?> login(String email) async {
    final response = await http.post(
      Uri.parse('${dotenv.env['SERVER_URL']}/v1/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      print('Login successful: ${response.body}');
      
      // Extract and save the token from the response cookies
      String? rawCookie = response.headers['set-cookie'];
      if (rawCookie != null) {
        int index = rawCookie.indexOf(';');
        String token = (index == -1) ? rawCookie : rawCookie.substring(0, index);
        print('Token saved: $token');
        return token;
      }
    } else {
      // Handle error
      print('Failed to login From SPringController login method');
    }
    return null;
  }

  Future<UserInfo?> fetchUser(String token) async {
    print('${dotenv.env['SERVER_URL']}/v1/users/me');
    if (token.startsWith('Authorization=')) {
    token = token.replaceFirst('Authorization=', '');
  }
    final uri = Uri.parse('${dotenv.env['SERVER_URL']}/v1/users/me');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': 'Authorization=$token', // 쿠키로 Authorization 설정
      },
    );

    if (response.statusCode == 200) {
      var user = UserInfo.fromJson(jsonDecode(response.body));
      userInfo.value = user;
      return user;
    } else {
      print('Failed to fetch user info From SPringController fetchUser method');
      return null;
    }
  }

  }
  
