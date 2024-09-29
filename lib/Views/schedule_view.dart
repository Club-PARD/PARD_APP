import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pard_app/component/schedule_container.dart';
import 'package:pard_app/controllers/spring_schedule_controller.dart';
import 'package:pard_app/model/schedule_model/schedule_response_dto.dart.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';

class SchedulerScreen extends StatelessWidget {
  // final ScheduleController scheduleController = Get.put(ScheduleController());
  final SpringScheduleController springScheduleController = Get.put(SpringScheduleController());

  SchedulerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, 
      appBar: AppBar(
        backgroundColor: backgroundColor, 
        elevation: 0,
        title: Text('일정', style: Theme.of(context).textTheme.headlineLarge),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
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
          buildSection('다가오는 일정', springScheduleController.upcomingSchedules,
              Theme.of(context).textTheme.headlineSmall!, false),
          SizedBox(
            height: MediaQuery.of(context).size.width / 34,
          ),
          // const Divider(
          //   color: Colors.grey, // Replace with grayScale[30]
          //   thickness: 1,
          // ),
          buildSection('지난 일정', springScheduleController.pastSchedules,
              Theme.of(context).textTheme.headlineSmall!, true),
        ],
      ),
    );
  }


  Widget buildSection(
      String title,
      RxList<ScheduleResponseDTO> schedules,
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
            if (schedules.isEmpty) {
              return const SizedBox.shrink();
            }

            return Column(
              children: schedules.map((schedule) {
                return ScheduleContainer(schedule, isPast: isPast);
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}