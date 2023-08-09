import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/push_notification_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final PushNotificationController pnc = Get.put(PushNotificationController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder.put(() => PushNotificationController(),permanent: true),
      home: const Scaffold(
        
      ),
    );
  }
}
