import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pard_app/controllers/spring_user_controller.dart';
import 'package:pard_app/model/point_model/point_reason.dart';
import 'package:pard_app/model/point_model/rank_point_model.dart';
import 'package:pard_app/model/point_model/total_rank_model.dart';
import 'package:pard_app/model/point_model/user_point.dart';
import 'dart:convert';
import 'auth_controller.dart';

class SpringPointController extends GetxController {
  Rx<UserPoint?> rxUserPoint = Rx<UserPoint?>(null);
 RxList<RankPointModel> top3RankList = <RankPointModel>[].obs;   
 RxBool isLoading = true.obs;
  final AuthController authController = Get.find<AuthController>();
  RxList<RankingResponseDTO> rankingList = <RankingResponseDTO>[].obs;
  RxList<ReasonBonus> pointReasonList = <ReasonBonus>[].obs;
  final SpringUserController springUserController = Get.find<SpringUserController>();

  @override
  void onInit() async{
    super.onInit();
    await fetchUserPoint();
    await fetchTop3Rank();
    fetchTotalRank();
    fetchReasonBonus();
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
      String? generation = springUserController.userInfo.value?.generation;
      
      final uri = Uri.parse('${dotenv.env['SERVER_URL']}/v1/rank/top3?generation=$generation');
      print(uri);
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'Authorization=$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<RankPointModel> top3Rank = jsonResponse.map((data) => RankPointModel.fromJson(data)).toList();
        top3RankList.assignAll(top3Rank);
      } else {
        throw Exception('Failed to load top 3 ranks: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching top 3 ranks: $e');
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchTotalRank() async {
    try {
      isLoading(true);
      String? token = authController.obxToken.value;
      String? generation = springUserController.userInfo.value?.generation;
      final uri = Uri.parse('${dotenv.env['SERVER_URL']}/v1/rank/total?generation=$generation');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'Authorization=$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<RankingResponseDTO> rankingListResponse = jsonResponse
            .map((data) => RankingResponseDTO.fromJson(data))
            .toList();
        rankingList.assignAll(rankingListResponse);
      } else {
        throw Exception('Failed to load total rank: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching total rank: $e');
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchReasonBonus() async {
    try {
      isLoading(true);
      String? token = authController.obxToken.value;

      final response = await http.get(
        Uri.parse('${dotenv.env['SERVER_URL']}/v1/reason'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'Authorization=$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<ReasonBonus> reasonBonusListResponse = jsonResponse
            .map((data) => ReasonBonus.fromJson(data))
            .toList();
        pointReasonList.assignAll(reasonBonusListResponse);
      } else {
        throw Exception('Failed to load reason bonus: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching reason bonus: $e');
    } finally {
      isLoading(false);
    }
  }
}
