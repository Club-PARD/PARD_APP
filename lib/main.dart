import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/schedule_controller.dart';
import 'package:pard_app/pages/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SchedulerPage(),
    );
  }
}

class ScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScheduleController());
  }
}
