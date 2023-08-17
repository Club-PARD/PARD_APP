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
      pastSchedules = pastSchedules.reversed.toList().obs;
    } catch (e) {
      print('Error fetching schedules: $e');
    }
  }
}
