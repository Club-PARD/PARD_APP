import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? function;
  final Widget? leading;
  final Widget? trailing;
  final bool automaticallyImplyLeading;

  const PardAppBar(
    this.title, {super.key, 
    this.function,
    this.leading,
    this.trailing,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.h),
      child: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        leading: leading ??
            IconButton(
              splashColor: Colors.transparent,
 highlightColor: Colors.transparent,
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 24.sp,
              ),
              onPressed: function ??
                  () {
                    Get.back();
                  },
            ),
        actions: [trailing ?? Container()],
        title: Text(
          title,
          style: TextStyle(
            fontFamily: "Pretendard",
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}
