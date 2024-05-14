// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pard_app/component/schedule_container.dart';
// import 'package:pard_app/controllers/schedule_controller.dart';
// import 'package:pard_app/controllers/spring_schedule_controller.dart';
// import 'package:pard_app/model/schedule_model/schedule_model.dart';
// import 'package:pard_app/model/schedule_model/schedule_spring_model.dart';
// import 'package:pard_app/utilities/color_style.dart';
// import 'package:pard_app/utilities/text_style.dart';

// class SchedulerScreen extends StatelessWidget {
//   final ScheduleController scheduleController = Get.put(ScheduleController());
//   // Spring Schedule controller 가져오기
//   final SpringScheduleController springScheduleController =
//       Get.put(SpringScheduleController());

//   SchedulerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: backgroundColor,
//         elevation: 0,
//         title: Text('일정', style: Theme.of(context).textTheme.headlineLarge),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//             size: 20,
//           ),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: ListView(
//         padding: EdgeInsets.symmetric(
//             horizontal: MediaQuery.of(context).size.width / 24),
//         children: [
//           buildSection('다가오는 일정', () => springScheduleController.upcomingSchedules,
//               displaySmall, false),
//           SizedBox(
//             height: MediaQuery.of(context).size.width / 34,
//           ),
//           Divider(
//             color: grayScale[30],
//             thickness: 1,
//           ),
//           buildSection('지난 일정', () => springScheduleController.pastSchedules,
//               displaySmall, true),
//         ],
//       ),
//     );
//   }

//   Widget buildSection(
//       String title,
//       List<SpringScheduleModel> Function() getSchedules,
//       TextStyle titleStyle,
//       bool isPast) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Divider(),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             title,
//             style: titleStyle,
//           ),
//         ),
//         Obx(
//           () {
//             final schedules = getSchedules();
//             if (schedules.isEmpty) {
//               return const SizedBox.shrink();
//             }

//             return Column(
//               children: schedules.map((schedule) {
//                 return ScheduleContainer(schedule, isPast: isPast);
//               }).toList(),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }