import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pard_app/model/user_model/user_info_model.dart';
import 'package:pard_app/model/user_model/user_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pard_app/model/user_model/user_info_model.dart' as pard_user;


class SpringUserController extends GetxController {

  var isAgree = false.obs;
   Rx<pard_user.UserInfo?> userInfo = Rx<pard_user.UserInfo?>(null);

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
  
