// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:pard_app/component/pard_part.dart';
// import 'package:pard_app/controllers/schedule_controller.dart';
// import 'package:pard_app/controllers/spring_schedule_controller.dart';
// import 'package:pard_app/model/schedule_model/schedule_model.dart';

// class HomeSchedule extends StatelessWidget {
//   final ScheduleController scheduleController = Get.put(ScheduleController());

//   // Spring Schedule controller 가져오기
//   final SpringScheduleController springScheduleController =
//       Get.put(SpringScheduleController());

//   HomeSchedule({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 280.w,
//       height: 100.h,
//       child: Obx(() {
//         if (scheduleController.upcomingSchedules.isNotEmpty) {
//           ScheduleModel firstSchedule =
//               scheduleController.upcomingSchedules.first;

//           final DateTime now = DateTime.now();
//           final DateTime dueDate = firstSchedule.dueDate;
//           final int dayLeft = dueDate.difference(now).inDays;
//           final dDay = _calculateDday(firstSchedule.dueDate);
//           final bool isAllParts = firstSchedule.part == '전체';

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 15.h,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       PartComponent(firstSchedule.part),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       Text(firstSchedule.title,
//                           style: Theme.of(context).textTheme.headlineLarge),
//                     ],
//                   ),
//                   Text(dDay, style: Theme.of(context).textTheme.titleMedium),
//                 ],
//               ),
//               SizedBox(
//                 height: 5.h,
//               ),
//               isAllParts
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('일시: ${_formatDate(firstSchedule.dueDate)}',
//                             style: Theme.of(context).textTheme.titleLarge),
//                         Text('장소: ${firstSchedule.place}',
//                             style: Theme.of(context).textTheme.titleLarge),
//                       ],
//                     )
//                   : // Display description (up to 20 characters) and due date
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // description -> place로 대체
//                         Text(
//                           firstSchedule.place.length > 20
//                               ? '${firstSchedule.place.substring(0, 20)}...'
//                               : firstSchedule.place,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: Theme.of(context).textTheme.titleLarge,
//                         ),
//                         Text('마감: ${_formatDate(firstSchedule.dueDate)}',
//                             style: Theme.of(context).textTheme.titleLarge),
//                       ],
//                     ),
//             ],
//           );
//         } else {
//           return const Center(
//             child: Text(
//               '다가오는 일정이 없어요.',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           );
//         }
//       }),
//     );
//   }

//   String _calculateDday(DateTime dueDate) {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final difference = dueDate.difference(today);

//     if (difference.isNegative) {
//       return '';
//     } else if (difference.inDays > 0) {
//       final days = difference.inDays;
//       return 'D-$days';
//     } else {
//       return 'D-DAY';
//     }
//   }

//   String _formatDate(DateTime date) {
//     final formattedDate = DateFormat('M월 d일 EEEE HH:mm', 'ko_KR').format(date);
//     return formattedDate;
//   }
// }
