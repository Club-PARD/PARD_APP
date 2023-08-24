import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/controllers/point_controller.dart';

class MyPointScreen extends StatelessWidget {
  MyPointScreen({super.key});
  final PointController pointController = Get.put(PointController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PardAppBar(
        '내 점수',
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 32.0,
          ),
          child: Column(
            children: [
              SizedBox(
                width: 229.w,
                height: 36.h,
                child: Image(
                  image: AssetImage('assets/images/pardnershipTop3.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
