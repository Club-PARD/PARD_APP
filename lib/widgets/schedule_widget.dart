import 'package:flutter/material.dart';
import 'package:pard_app/model/schedule_model.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'package:pard_app/widgets/part_widget.dart';

class ScheduleItemWidget extends StatelessWidget {
  final ScheduleModel schedule;
  final bool isPast;

  const ScheduleItemWidget(this.schedule, {super.key, this.isPast = false});

  @override
  Widget build(BuildContext context) {
    final dDay = _calculateDday(schedule.dueDate);

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width / 50),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: ColorStyles.scheduleWidget,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    PartWidget(schedule.part),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(schedule.title,
                        style: isPast
                            ? TextStyles.pastScheduleTitleStyle
                            : TextStyles.scheduleTitleStyle),
                  ],
                ),
              ),
              Text(dDay,
                  style: isPast
                      ? TextStyles.pastDueDateStyle
                      : TextStyles.dueDateStyle),
            ],
          ),
          const SizedBox(height: 8),
          Text(schedule.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: isPast
                  ? TextStyles.pastScheduleDescriptionStyle
                  : TextStyles.scheduleDescriptionStyle),
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
