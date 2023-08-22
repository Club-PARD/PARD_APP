import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/point_controller.dart';

class MyPointScreen extends StatelessWidget {
  MyPointScreen({super.key});
  final PointController pointController = Get.put(PointController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
          title: const Text(
            '내 점수',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  pointController.getUserUid();
                },
                child: Text('uid 가져오기 버튼'),
              ),
              ElevatedButton(
                onPressed: () {
                  pointController.getUserPoints();
                },
                child: Text('point 가져오기 버튼'),
              ),
              ElevatedButton(
                onPressed: () {
                  pointController.getUserPoints();
                  pointController.getUserDataAndPoints();
                },
                child: Text('point model 버튼'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('버튼'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('버튼'),
              ),
            ],
          ),
        ));
  }
}
