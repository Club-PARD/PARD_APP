import 'dart:convert';

import 'package:get/get.dart';
import 'package:pard_app/model/schedule_model/schedule_spring_model.dart';
import 'package:http/http.dart' as http;

class SpringScheduleController extends GetxController{
  RxList<SpringScheduleModel> upcomingSchedules = <SpringScheduleModel>[].obs;
  RxList<SpringScheduleModel> pastSchedules = <SpringScheduleModel>[].obs;

  @override
  void onInit(){
    super.onInit();
    fetchSchedules(part: 'WEB'); //mockup 데이타가 WEB이여서 일단 WEB으로 설정 나중에 userController에서 받아온 part로 변경
  }

  // SpringBoot의 GetMapping "/schedule/ALL/up-coming" API를 호출하여 스케줄을 가져옴
  void fetchSchedules({required String part}) async {
    // 'all'에 해당하는 스케줄을 불러옵니다.
    final urlAll = Uri.parse('http://192.168.35.51:8080/mock/schedule/all/up-coming');
    // 특정 'part'에 해당하는 스케줄을 불러옵니다.
    final urlPart = Uri.parse('http://192.168.35.51:8080/mock/schedule/$part/up-coming');

    try {
      // 'all' 스케줄 요청
      final responseAll = await http.get(urlAll);
      // 'part' 스케줄 요청
      final responsePart = part != 'all' ? await http.get(urlPart) : null;

      List<dynamic> schedulesJsonAll = json.decode(responseAll.body);
      List<dynamic> schedulesJsonPart = responsePart != null ? json.decode(responsePart.body) : [];

      // 두 응답을 합칩니다.
      schedulesJsonAll.addAll(schedulesJsonPart);

      var now = DateTime.now();

      var upcoming = schedulesJsonAll.map((json) => SpringScheduleModel.fromJson(json)).where((schedule) => schedule.scheduleDate!.isAfter(now)).toList();
      var past = schedulesJsonAll.map((json) => SpringScheduleModel.fromJson(json)).where((schedule) => schedule.scheduleDate!.isBefore(now)).toList();

      // 출력 및 할당
      print("Upcoming Schedules:");
      for (var schedule in upcoming) {
        print("${schedule.title}, Date: ${schedule.getFormattedScheduleDate()}");
      }

      print("Past Schedules:");
      for (var schedule in past) {
        print("${schedule.title}, Date: ${schedule.getFormattedScheduleDate()}");
      }

      upcomingSchedules.assignAll(upcoming);
      pastSchedules.assignAll(past);
    } catch (e) {
      print("Error fetching schedules: $e");
    }
  }
}
