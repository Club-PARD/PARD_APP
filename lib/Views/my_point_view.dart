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
                child: const Image(
                  image: AssetImage('assets/images/pardnershipTop3.png'),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  rankWithTopIcon('top1'),
                  rankWithTopIcon('top2'),
                  rankWithTopIcon('top3'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rankWithTopIcon(String top) {
    return Row(
      children: [
        Image(
          width: 40.w,
          height: 49.h,
          image: AssetImage('assets/images/$top.png'),
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: 유저 데이터 가져오기
            Text(
              '디자인 파트',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              '김파드',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
