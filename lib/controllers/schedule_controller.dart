import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pard_app/model/schedule_model.dart';

class ScheduleController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<ScheduleModel> upcomingSchedules = <ScheduleModel>[].obs;
  RxList<ScheduleModel> pastSchedules = <ScheduleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSchedules('앱');
  }

  Future<void> fetchSchedules(String userPart) async {
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

      // Reverse the order of past schedules to have the most recent ones at the top
      pastSchedules = pastSchedules.reversed.toList().obs;
    } catch (e) {
      print('Error fetching schedules: $e');
    }
  }

  Future<void> addSchedule(ScheduleModel newSchedule) async {
    try {
      await _firestore.collection('schedules').add({
        'attend': newSchedule.attend,
        'title': newSchedule.title,
        'description': newSchedule.description,
        'dueDate': newSchedule.dueDate.toIso8601String(),
        'place': newSchedule.place,
        'part': newSchedule.part,
        'previous': newSchedule.previous,
      });
      fetchSchedules(newSchedule.part);
    } catch (e) {
      print('Error adding schedule: $e');
    }
  }

  String calculateDday(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;
    if (difference > 0) {
      return 'D-$difference';
    } else if (difference == 0) {
      return 'D-Day';
    } else {
      return 'D+${-difference}';
    }
  }
}
