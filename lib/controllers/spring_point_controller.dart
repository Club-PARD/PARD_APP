import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pard_app/model/point_model/rank_point_model.dart';
import 'package:pard_app/model/point_model/user_point.dart';
import 'dart:convert';
import 'auth_controller.dart';

class SpringPointController extends GetxController {
  Rx<UserPoint?> rxUserPoint = Rx<UserPoint?>(null);
  RxMap<RankPointModel, double> userPointsMap = <RankPointModel, double>{}.obs;
  RxBool isLoading = true.obs;
  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() async{
    super.onInit();
    await fetchUserPoint();
    await fetchTop3Rank();
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

  Future<void> fetchTop3Rank() async {
    try {
      isLoading(true);
      String? token = authController.obxToken.value;
      final response = await http.get(
        Uri.parse('${dotenv.env['SERVER_URL']}/top3'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'Authorization=$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        Map<RankPointModel, double> userPoints = {};
        for (var data in jsonResponse) {
          RankPointModel user = RankPointModel.fromJson(data);
          userPoints[user] = data['totalBonus'];
        }
        userPointsMap.assignAll(userPoints);
      } else {
        throw Exception('Failed to load top 3 ranks: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching top 3 ranks: $e');
    } finally {
      isLoading(false);
    }
  }
}
