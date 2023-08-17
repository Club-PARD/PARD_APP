import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/schedule_controller.dart';
import 'package:pard_app/model/schedule_model.dart';

class SchedulerPage extends StatelessWidget {
  final ScheduleController scheduleController = Get.put(ScheduleController());

  SchedulerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일정'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        children: [
          _buildSection('다가오는 일정', () => scheduleController.upcomingSchedules),
          _buildSection('지난 일정', () => scheduleController.pastSchedules),
        ],
      ),
    );
  }

  Widget _buildSection(
      String title, List<ScheduleModel> Function() getSchedules) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Obx(
          () {
            final schedules = getSchedules();
            if (schedules.isEmpty) {
              return const SizedBox.shrink();
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];
                final dDay = scheduleController.calculateDday(schedule.dueDate);
                return ListTile(
                  leading: Text(schedule.part),
                  title: Text(schedule.title),
                  subtitle: Text(schedule.description),
                  trailing: Text(dDay),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
