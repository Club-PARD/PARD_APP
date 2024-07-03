import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pard_app/controllers/auth_controller.dart';
import 'package:pard_app/model/schedule_model/schedule_response_dto.dart.dart';

class SpringScheduleController extends GetxController {
  final baseUrl = '${dotenv.env['SERVER_URL']}/v1/schedule';
  var upcomingSchedules= <ScheduleResponseDTO>[].obs;
  var pastSchedules= <ScheduleResponseDTO>[].obs;
  var allSchedules= <ScheduleResponseDTO>[].obs;
  var partSchedules = <ScheduleResponseDTO>[].obs;
  var isLoading = true.obs;
  AuthController authController = Get.find();

  @override
  void onInit() {
    fetchAllSchedules();
    super.onInit();
  }

  Future<void> fetchAllSchedules() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': 'Authorization=${authController.obxToken.value}',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        var scheduleList = jsonResponse.map((data) => ScheduleResponseDTO.fromJson(data)).toList();
        allSchedules.assignAll(scheduleList);
        await categorizeSchedules(scheduleList);
      } else {
        throw Exception('Failed to load schedules from $baseUrl. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> categorizeSchedules(List<ScheduleResponseDTO> scheduleList) async {
    var upcoming = <ScheduleResponseDTO>[];
    var past = <ScheduleResponseDTO>[];

    for (var schedule in scheduleList) {
      if (schedule.date.isBefore(DateTime.now())) {
        past.add(schedule);
      } else {
        upcoming.add(schedule);
      }
    }

    upcomingSchedules.assignAll(upcoming);
    pastSchedules.assignAll(past);
  }

  Future<void> fetchPartSchedules(String part) async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('$baseUrl/$part'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': 'Authorization=${authController.obxToken.value}',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        var scheduleList = jsonResponse.map((data) => ScheduleResponseDTO.fromJson(data)).toList();
        partSchedules.assignAll(scheduleList);
      } else {
        throw Exception('Failed to load schedules for part $part. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

}