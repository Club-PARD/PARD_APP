import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/Views/home_view.dart';
import 'package:pard_app/Views/mypage.dart';
import 'package:pard_app/component/bottom.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';

class RootVeiw extends StatelessWidget {
  const RootVeiw({super.key});

  static List<Widget> tabPages = <Widget>[
    HomePage(),
    Container(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(BottomBarController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: null,
      body: Obx(() => tabPages[BottomBarController.to.selectedIndex.value]),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BottomBar(),
          Positioned(
            bottom: 50.h,
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF5262F5),
                    Color(0xFF7B3FEF),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8.r,
                    color: Colors.white.withOpacity(0.25),
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  // controller.onItemTapped(3);
                  Get.toNamed('/qr');
                  // 활성화, 비활 만들어야 함
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Image.asset(
                  'assets/images/qr.png',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
