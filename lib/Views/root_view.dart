import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/Views/home_view.dart';
import 'package:pard_app/Views/mypage.dart';
import 'package:pard_app/component/bottom.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';
import 'package:pard_app/utilities/color_style.dart';

class RootVeiw extends StatelessWidget {
  const RootVeiw({super.key});

  static List<Widget> tabPages = <Widget>[
    const HomePage(),
    // Container(),
    const MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(BottomBarController());
    return Obx(()=>Scaffold(
      extendBody: true,
      body: Obx(() => tabPages[BottomBarController.to.selectedIndex.value]),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: BottomBarController.to.selectedIndex.value == 0
          ?  const LinearGradient(
            colors: [
              Color(0xFF5262F5),
              Color(0xFF7B3FEF),
            ],
          )
          :null,
          color: BottomBarController.to.selectedIndex.value == 1
              ? grayScale[30]
              : null,
          boxShadow: [
            BoxShadow(
              blurRadius: 8.r,
              color: Colors.white.withOpacity(0.25),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            if (BottomBarController.to.selectedIndex.value != 1) {
           Get.toNamed('/qr');
      }
          },
          backgroundColor:Colors.transparent,
          elevation: 0,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Image.asset(
              'assets/images/qr.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    ));
  }
}
