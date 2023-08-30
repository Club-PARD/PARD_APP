import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';
import 'package:pard_app/utilities/color_style.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final BottomBarController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          ),
          height: 100.h,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: const Color(0xFF2A2A2A),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                      size: 35.h,
                    ),
                    label: ''),
                const BottomNavigationBarItem(icon: Icon(null), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_2_outlined,
                      size: 35.h,
                    ),
                    label: ''),
              ],
              currentIndex: controller.selectedIndex.value,
              selectedItemColor: const Color.fromRGBO(82, 98, 245, 1),
              onTap: controller.onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
