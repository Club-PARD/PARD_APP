import 'package:flutter/material.dart';
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
          Text(schedule.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: isPast
                  ? Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: grayScale[30])
                  : Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }

  String _calculateDday(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;
    if (difference == 0) {
      return 'D-DAY';
    } else if (difference > 0) {
      return 'D-$difference';
    } else {
      return '';
    }
  }
}
