import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/Views/my_point_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'Pretendard',
          useMaterial3: true,
        ),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => MyPointScreen()),
          // GetPage(name: '/first', page: () => FirstNamedPage()),
          // GetPage(name: '/second', page: () => SecondNamedPage()),
        ],
      ),
    );
  }
}
