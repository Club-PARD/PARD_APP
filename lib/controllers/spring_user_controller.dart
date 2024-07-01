import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pard_app/model/user_model/user_info_model.dart';
import 'package:pard_app/model/user_model/user_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpringUserController extends GetxController {

  var isAgree = false.obs;
  var userInfo = UserInfo().obs;

  Future<void> login(String email) async {
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
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('Authorization', token);
        print('Token saved: $token');
      }
    } else {
      // Handle error
      print('Failed to login From SPringController login method');
    }
  }

  Future<UserInfo?> fetchUser(String token) async {
    final response = await http.get(
      Uri.parse('${dotenv.env['SERVER_URL']}/api/users/me'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      var user = UserInfo.fromJson(jsonDecode(response.body));
      userInfo.value = user;
      print('User info fetched: ${userInfo.value.name}');
      return user;
    } else {
      print('Failed to fetch user info');
      return null;
    }
  }
  }
  
