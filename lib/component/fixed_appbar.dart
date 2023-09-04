import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pard_app/utilities/color_style.dart';

class HomeFixedBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeFixedBar({super.key});

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.h),
      child: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: Color(0xFF242424),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 24.0.w),
          child: Image.asset(
            "assets/images/logo.png",
            width: 120.w,
            height: 25.h,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0.w),
            child: InkWell(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Image.asset(
                "assets/images/hamburger.png",
                width: 40.w,
                height: 40.h,
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     Scaffold.of(context).openEndDrawer();
            //   },
            //   icon: const Icon(
            //     Icons.menu,
            //     color: Colors.white,
            //   ),
            //   iconSize: 40.w,
            // ),
          ),
        ],
      ),
    );
  }
}
