import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< Updated upstream
import 'package:pard_app/model/schedule_model.dart';
=======
import 'package:pard_app/model/schedule_model/schedule_model.dart';
>>>>>>> Stashed changes

class ScheduleController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<ScheduleModel> upcomingSchedules = <ScheduleModel>[].obs;
  RxList<ScheduleModel> pastSchedules = <ScheduleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
<<<<<<< Updated upstream
    fetchSchedules('앱');
  }

  Future<void> fetchSchedules(String userPart) async {
=======
    getSchedules('앱');
  }

  Future<void> getSchedules(String userPart) async {
>>>>>>> Stashed changes
    try {
      final now = DateTime.now();
      final schedulesSnapshot =
          await _firestore.collection('schedules').orderBy('dueDate').get();

      upcomingSchedules.clear();
      pastSchedules.clear();

      for (var scheduleDoc in schedulesSnapshot.docs) {
        final scheduleData = scheduleDoc.data();

        if (scheduleData['part'] == userPart || scheduleData['part'] == '천체') {
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
<<<<<<< Updated upstream
      print('Error fetching schedules: $e');
=======
      if (kDebugMode) {
        print('Error fetching schedules: $e');
      }
>>>>>>> Stashed changes
    }
  }
}
