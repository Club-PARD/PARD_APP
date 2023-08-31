import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< Updated upstream
=======
import 'package:pard_app/controllers/user_controller.dart';
>>>>>>> Stashed changes

import 'package:pard_app/model/schedule_model/schedule_model.dart';

class ScheduleController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController userController = Get.find();

  RxList<ScheduleModel> upcomingSchedules = <ScheduleModel>[].obs;
  RxList<ScheduleModel> pastSchedules = <ScheduleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
<<<<<<< Updated upstream

    getSchedules('앱');
=======
    final userPart = userController.userInfo.value?.part;

    if (userPart != null) {
      getSchedules(userPart);
    }
>>>>>>> Stashed changes
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

        if (scheduleData['part'] == userPart || scheduleData['part'] == '전체') {
          final schedule = ScheduleModel(
            Map<String, int>.from(scheduleData['attend']),
            scheduleData['title'],
            scheduleData['description'],
            (scheduleData['dueDate'] as Timestamp).toDate(),
            scheduleData['place'],
            scheduleData['part'],
            now.isAfter((scheduleData['dueDate'] as Timestamp).toDate()),
          );

          if (schedule.previous) {
            pastSchedules.add(schedule);
          } else {
            upcomingSchedules.add(schedule);
          }
        }
      }
      pastSchedules = pastSchedules.reversed.toList().obs;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching schedules: $e');
      }
    }
  }
}
