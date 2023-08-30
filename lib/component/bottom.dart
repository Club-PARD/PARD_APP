import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final BottomBarController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Obx(() => BottomNavigationBar(
              backgroundColor: const Color(0xFF2A2A2A),
              items:  <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,size: 35.h,
                    ),
                    label: ''),
                const BottomNavigationBarItem(icon: Icon(null), label: ''),
                 BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_2_outlined,size: 35.h,
                    ),
                    label: ''),
              ],
              currentIndex: controller.selectedIndex.value,
              selectedItemColor: const Color.fromRGBO(82, 98, 245, 1),
              onTap: controller.onItemTapped,
            )),
        Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),  
    gradient: const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF5262F5),
      Color(0xFF7B3FEF),
    ],
    ),
  ),
          child: FloatingActionButton(
            onPressed: () {
              controller.onItemTapped(1);
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
      ],
    );
  }
}
