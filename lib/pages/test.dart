import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/schedule_controller.dart';
import 'package:pard_app/model/schedule_model.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'package:pard_app/widgets/schedule_widget.dart';

class SchedulerPage extends StatelessWidget {
  final ScheduleController scheduleController = Get.put(ScheduleController());

  SchedulerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.background,
      appBar: AppBar(
        backgroundColor: ColorStyles.background,
        elevation: 0,
        title: const Text('일정', style: TextStyles.appBarTitleStyle),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 24),
        children: [
          _buildSection('다가오는 일정', () => scheduleController.upcomingSchedules,
              TextStyles.sectionTitleStyle, false),
          SizedBox(
            height: MediaQuery.of(context).size.width / 34,
          ),
          const Divider(
            color: Colors.white,
            thickness: 1,
          ),
          _buildSection('지난 일정', () => scheduleController.pastSchedules,
              TextStyles.sectionTitleStyle, true),
        ],
      ),
    );
  }

  Widget _buildSection(
      String title,
      List<ScheduleModel> Function() getSchedules,
      TextStyle titleStyle,
      bool isPast) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
        Obx(
          () {
            final schedules = getSchedules();
            if (schedules.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              children: schedules.map((schedule) {
                return ScheduleItemWidget(schedule, isPast: isPast);
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
