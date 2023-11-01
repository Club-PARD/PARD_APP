import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pard_app/controllers/error_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';

import 'package:pard_app/model/schedule_model/schedule_model.dart';

class ScheduleController extends GetxController {
  final UserController _userController = Get.put(UserController());
  final ErrorController _errorController = Get.put(ErrorController());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<ScheduleModel> upcomingSchedules = <ScheduleModel>[].obs;
  RxList<ScheduleModel> pastSchedules = <ScheduleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getSchedules('${_userController.userInfo.value!.part}');
  }

  Future<void> getSchedules(String userPart) async {
    try {
      final now = DateTime.now();
      final schedulesSnapshot =
          await _firestore.collection('schedules').orderBy('dueDate').get();

      upcomingSchedules.clear();
      pastSchedules.clear();

      for (var scheduleDoc in schedulesSnapshot.docs) {
        final scheduleData = scheduleDoc.data();
        final sid = scheduleDoc.id;
        print('sid : $sid');

        if (scheduleData['part'] == userPart || scheduleData['part'] == '전체') {
          final schedule = ScheduleModel(
              scheduleData['title'],
              (scheduleData['dueDate'] as Timestamp).toDate(),
              scheduleData['place'],
              scheduleData['part'],
              now.isAfter((scheduleData['dueDate'] as Timestamp).toDate()),
              sid,
              scheduleData['type']);

          if (schedule.previous) {
            pastSchedules.add(schedule);
          } else {
            upcomingSchedules.add(schedule);
          }
        }
      }
      pastSchedules = pastSchedules.reversed.toList().obs;
      print('upcomingSchedules : $upcomingSchedules');
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching schedules: $e');
      }
      await _errorController.writeErrorLog(
        e.toString(),
        _userController.userInfo.value!.phone ?? 'none',
        'getSchedules()',
      );
    }
  }
}
