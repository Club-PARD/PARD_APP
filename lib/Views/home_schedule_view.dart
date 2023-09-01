import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/schedule_controller.dart';
import 'package:pard_app/model/schedule_model/schedule_model.dart';
import 'package:pard_app/utilities/text_style.dart';

class HomeSchedule extends StatelessWidget {
  final ScheduleController scheduleController = Get.put(ScheduleController());

  HomeSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.w,
      height: 110.h,
      child: Obx(() {
        if (scheduleController.upcomingSchedules.isNotEmpty) {
          ScheduleModel firstSchedule =
              scheduleController.upcomingSchedules.first;

              final DateTime now = DateTime.now();
        final DateTime dueDate = firstSchedule.dueDate;
        final int dayLeft = dueDate.difference(now).inDays;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 45.w,
                        height: 30.h,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(1.00, -0.03),
                            end: Alignment(-1, 0.03),
                            colors: [Color(0xFF5262F5), Color(0xFF7B3FEF)],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(firstSchedule.part,
                                style:
                                    titleSmall.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        firstSchedule.title,
                        style: headlineLarge.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(' D - $dayLeft', style: titleMedium.copyWith(color: Colors.white)),
                  SizedBox(width: 10.w,),
                ],
              ),
              SizedBox(height: 5.h,),
              Row(
                children: [
                  Text(
                    '일시 : ',
                    style: titleSmall.copyWith(color: Colors.white),
                  ),
                  Text('${firstSchedule.dueDate}',
                      style: titleSmall.copyWith(color: Colors.white)),
                ],
              ),
              SizedBox(height: 5.h,),
              Row(
                children: [
                  Text('장소 : ', style: titleSmall.copyWith(color: Colors.white)),
                  Text(firstSchedule.place,
                      style: titleSmall.copyWith(color: Colors.white)),
                ],
              )
            ],
          );
        } else {
          return const Text('No upcoming schedules');
        }
      }),
    );
  }
}
