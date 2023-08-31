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

  PardAppBar(
    this.title, {
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
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
<<<<<<< Updated upstream
                size: 24,
=======
                size: 24.sp,
>>>>>>> Stashed changes
              ),
              onPressed: function ??
                  () {
                    Get.back();
                  },
            ),
        actions: [trailing ?? Container()],
        title: Text(
          title,
<<<<<<< Updated upstream
          style: Theme.of(context).textTheme.displayMedium,
=======
          style: TextStyle(
            fontFamily: "Pretendard",
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
>>>>>>> Stashed changes
        ),
      ),
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}
