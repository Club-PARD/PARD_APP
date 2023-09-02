import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pard_app/component/pard_part.dart';
import 'package:pard_app/controllers/schedule_controller.dart';
import 'package:pard_app/model/schedule_model/schedule_model.dart';

class HomeSchedule extends StatelessWidget {
  final ScheduleController scheduleController = Get.put(ScheduleController());

  HomeSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.w,
      height: 100.h,
      child: Obx(() {
        if (scheduleController.upcomingSchedules.isNotEmpty) {
          ScheduleModel firstSchedule =
              scheduleController.upcomingSchedules.first;

          final DateTime now = DateTime.now();
          final DateTime dueDate = firstSchedule.dueDate;
          final int dayLeft = dueDate.difference(now).inDays;
          final dDay = _calculateDday(firstSchedule.dueDate);
          final bool isAllParts = firstSchedule.part == '전체';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      PartComponent(firstSchedule.part),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(firstSchedule.title,
                          style: Theme.of(context).textTheme.headlineLarge),
                    ],
                  ),
                  Text(dDay, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              isAllParts
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('일시: ${_formatDate(firstSchedule.dueDate)}',
                            style: Theme.of(context).textTheme.titleLarge),
                        Text('장소: ${firstSchedule.place}',
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    )
                  : // Display description (up to 20 characters) and due date
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstSchedule.description.length > 20
                              ? '${firstSchedule.description.substring(0, 20)}...'
                              : firstSchedule.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text('일시: ${_formatDate(firstSchedule.dueDate)}',
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
            ],
          );
        } else {
          return const Text('No upcoming schedules');
        }
      }),
    );
  }

  String _calculateDday(DateTime dueDate) {
    final now = DateTime.now();
    final dueDateWithoutTime =
        DateTime(dueDate.year, dueDate.month, dueDate.day);
    final nowWithoutTime = DateTime(now.year, now.month, now.day);
    final difference = dueDateWithoutTime.difference(nowWithoutTime).inDays;

    if (difference == 0) {
      return 'D-DAY';
    } else if (difference > 0) {
      return 'D-$difference';
    } else {
      return '';
    }
  }

  String _formatDate(DateTime date) {
    final formattedDate = DateFormat('M월 d일 EEEE HH:mm', 'ko_KR').format(date);
    return formattedDate;
  }
}
