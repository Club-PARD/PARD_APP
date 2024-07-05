import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pard_app/model/point_model/user_point.dart';
import 'dart:convert';
import 'auth_controller.dart';

class SpringPointController extends GetxController {
  Rx<UserPoint?> rxUserPoint = Rx<UserPoint?>(null);
  RxBool isLoading = true.obs;
  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() async{
    super.onInit();
    await fetchUserPoint();
  }

  Future<UserPoint?> fetchUserPoint() async {
    try {
      isLoading(true);
      String? token = authController.obxToken.value;

      final response = await http.get(
        Uri.parse('${dotenv.env['SERVER_URL']}/v1/rank/me'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'Authorization=$token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        UserPoint userPoint = UserPoint.fromJson(jsonResponse);
        rxUserPoint.value = userPoint;
        return userPoint;
      } else {
        throw Exception('Failed to load user point: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user point: $e');
      return null;
    } finally {
      isLoading(false);
    }
  }
}
