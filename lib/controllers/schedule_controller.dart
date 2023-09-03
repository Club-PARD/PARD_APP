import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pard_app/model/schedule_model/schedule_model.dart';

class ScheduleController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<ScheduleModel> upcomingSchedules = <ScheduleModel>[].obs;
  RxList<ScheduleModel> pastSchedules = <ScheduleModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    getSchedules('앱');
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
            Map<String, int>.from(scheduleData['attend']),
            scheduleData['title'],
            scheduleData['description'],
            (scheduleData['dueDate'] as Timestamp).toDate(),
            scheduleData['place'],
            scheduleData['part'],
            now.isAfter((scheduleData['dueDate'] as Timestamp).toDate()),
            sid
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