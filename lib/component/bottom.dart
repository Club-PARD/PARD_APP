import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  final BottomBarController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Obx(() => BottomNavigationBar(
                backgroundColor: const Color(0xFF2A2A2A),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: ''),
                  BottomNavigationBarItem(icon: Icon(null), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person_2_outlined,
                      ),
                      label: ''),
                ],
                currentIndex: controller.selectedIndex.value,
                selectedItemColor: const Color.fromRGBO(82, 98, 245, 1),
                onTap: controller.onItemTapped,
              )),
          SizedBox(
            width: 80.w,
            height: 80.h,
            child: FloatingActionButton(
              onPressed: () {
                controller.onItemTapped(1);
                Get.toNamed('/qr');
                // 활성화, 비활 만들어야 함
              },
              backgroundColor: const Color.fromRGBO(42, 42, 42, 1),
              child: Obx(
                () => Icon(
                  Icons.qr_code_scanner_outlined,
                  color: controller.selectedIndex.value == 1
                      ? const Color.fromRGBO(82, 98, 245, 1)
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
