import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controllers/push_notification_controller.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PushNotificationController.to; /** push_notification controller 가져온다  */
    return Scaffold(
      body: Center(
        child: Obx(() {
          return Switch(
            value: controller.onOff.value,
            onChanged: (value) {
              controller.onOff.value = !controller.onOff.value;
              print(controller.onOff.value);
            },
          );
        }),
      ),
    );
  }
}