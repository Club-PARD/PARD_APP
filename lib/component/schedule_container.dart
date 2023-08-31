import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pard_app/component/pard_part.dart';
import 'package:pard_app/model/schedule_model/schedule_model.dart';
import 'package:pard_app/utilities/color_style.dart';

class ScheduleContainer extends StatelessWidget {
  final ScheduleModel schedule;
  final bool isPast;

  const ScheduleContainer(this.schedule, {super.key, this.isPast = false});

  @override
  Widget build(BuildContext context) {
    final dDay = _calculateDday(schedule.dueDate);
    final bool isAllParts = schedule.part == '전체';

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width / 50),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: blackScale,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PartComponent(schedule.part),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(schedule.title,
                      style: isPast
                          ? Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: grayScale[30])
                          : Theme.of(context).textTheme.headlineLarge),
                ],
              ),
              Text(dDay,
                  style: isPast
                      ? Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: grayScale[30])
                      : Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          isAllParts
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('일시: ${_formatDate(schedule.dueDate)}',
                        style: isPast
                            ? Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: grayScale[30])
                            : Theme.of(context).textTheme.titleLarge),
                    Text('장소: ${schedule.place}',
                        style: isPast
                            ? Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: grayScale[30])
                            : Theme.of(context).textTheme.titleLarge),
                  ],
                )
              : // Display description (up to 20 characters) and due date
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schedule.description.length > 20
                          ? '${schedule.description.substring(0, 20)}...'
                          : schedule.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: isPast
                          ? Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: grayScale[30])
                          : Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('일시: ${_formatDate(schedule.dueDate)}',
                        style: isPast
                            ? Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: grayScale[30])
                            : Theme.of(context).textTheme.titleLarge),
                  ],
                ),
        ],
      ),
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
