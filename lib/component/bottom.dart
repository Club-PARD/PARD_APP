import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final BottomBarController controller = Get.find();
  final double iconSize = 24.h;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory, // Disables splash effect
              highlightColor: Colors.transparent, // Disables highlight effect
            ),
            child: BottomNavigationBar(
              backgroundColor: const Color(0xFF2A2A2A),
              elevation: 8.0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(right: 18.0.w),
                    child: controller.selectedIndex.value == 0
                        ? Image.asset(
                            'assets/images/selected_home.png',
                            width: iconSize,
                          )
                        : Image.asset(
                            'assets/images/home.png',
                            width: iconSize,
                          ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(left: 18.0.w),
                      child: controller.selectedIndex.value == 1
                          ? Image.asset(
                              'assets/images/selected_my.png',
                              width: iconSize,
                            )
                          : Image.asset(
                              'assets/images/my.png',
                              width: iconSize,
                            ),
                    ),
                    label: ''),
              ],
              currentIndex: controller.selectedIndex.value,
              // selectedItemColor: const Color.fromRGBO(82, 98, 245, 1),
              onTap: controller.onItemTapped,
              
            ),
          ),
        ),
      ),
    );
  }
}
