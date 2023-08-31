import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';
import 'package:pard_app/utilities/color_style.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final BottomBarController controller = Get.find();
  final double iconSize = 28.h;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0), // Adjust the radius as needed
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, -2), // Adjust the offset as needed
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0), // Same radius as in the outer container
          ),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFF2A2A2A),
            elevation: 8.0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: iconSize,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_2_outlined,
                    size: iconSize,
                  ),
                  label: ''),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: const Color.fromRGBO(82, 98, 245, 1),
            onTap: controller.onItemTapped,
          ),
        ),
      ),
    );
  }
}
