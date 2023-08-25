import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/Views/my_point_view.dart';
import 'package:pard_app/Views/schedule_view.dart';
import 'package:pard_app/utilities/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.regularTheme,
        builder: (BuildContext context, Widget? child) {
          final data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(
                textScaleFactor: data.textScaleFactor >= 1.4 ? 1.4 : 1.0),
            child: child!,
          );
        },
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => MyPointScreen()),
          GetPage(name: '/schedule', page: () => SchedulerScreen()),
          // GetPage(name: '/first', page: () => FirstNamedPage()),
          // GetPage(name: '/second', page: () => SecondNamedPage()),
        ],
      ),
    );
  }
}
