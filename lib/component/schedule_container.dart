import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pard_app/component/pard_part.dart';
import 'package:pard_app/model/schedule_model/schedule_response_dto.dart.dart';

class ScheduleContainer extends StatelessWidget {
  final ScheduleResponseDTO schedule;
  final bool isPast;

  const ScheduleContainer(this.schedule, {super.key, this.isPast = false});

  @override
  Widget build(BuildContext context) {
    final dDay = _calculateDday(schedule.date);
    final bool isAllParts = schedule.part == '전체';

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width / 50),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.black, // Replace with your blackScale color
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
                  PartComponent(schedule.part), // Make sure PartComponent works with part from ScheduleResponseDTO
                  const SizedBox(
                    width: 8,
                  ),
                  Text(schedule.title,
                      style: isPast
                          ? Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.grey) // Replace with grayScale[30]
                          : Theme.of(context).textTheme.headlineLarge),
                ],
              ),
              Text(dDay,
                  style: isPast
                      ? Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.grey) // Replace with grayScale[30]
                      : Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          isAllParts
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('일시: ${_formatDate(schedule.date)}',
                        style: isPast
                            ? Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.grey) // Replace with grayScale[30]
                            : Theme.of(context).textTheme.titleLarge),
                    Text('장소: ${schedule.contentsLocation}',
                        style: isPast
                            ? Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.grey) // Replace with grayScale[30]
                            : Theme.of(context).textTheme.titleLarge),
                  ],
                )
              : // Display description (up to 20 characters) and due date
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // description -> place로 대체
                    Text(
                      schedule.contentsLocation.length > 20
                          ? '${schedule.contentsLocation.substring(0, 20)}...'
                          : schedule.contentsLocation,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: isPast
                          ? Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.grey) // Replace with grayScale[30]
                          : Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('마감: ${_formatDate(schedule.date)}',
                        style: isPast
                            ? Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.grey) // Replace with grayScale[30]
                            : Theme.of(context).textTheme.titleLarge),
                  ],
                ),
        ],
      ),
    );
  }

  String _calculateDday(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = dueDate.difference(today);

    if (difference.isNegative) {
      return '';
    } else if (difference.inDays > 0) {
      final days = difference.inDays;
      return 'D-$days';
    } else {
      return 'D-DAY';
    }
  }

  String _formatDate(DateTime date) {
    final formattedDate = DateFormat('M월 d일 EEEE HH:mm', 'ko_KR').format(date);
    return formattedDate;
  }
}
