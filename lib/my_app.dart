import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/Views/home_view.dart';
import 'package:pard_app/Views/my_point_view.dart';
import 'package:pard_app/Views/number_auth_view.dart';
import 'package:pard_app/Views/overall_ranking_view.dart';
import 'package:pard_app/Views/signin_view.dart';
import 'package:pard_app/Views/tos_view.dart';
import 'package:pard_app/Views/mypage.dart';
import 'package:pard_app/component/qr_scanner.dart';
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
          GetPage(name: '/', page: () => const SignInView()),
          GetPage(name: '/tos', page: () => const TosView()),
          GetPage(name: '/numberauth', page: () => const NumberAuthView()),
          GetPage(name: '/mypoint', page: () => MyPointView()),
          GetPage(
              name: '/overallRanking', page: () => const OverallRankingView()),
          GetPage(name: '/home', page: () => HomePage()),
          GetPage(name: '/mypage', page: () => const MyPage()),
          GetPage(name: '/qr', page: () => QRScan())
          // GetPage(name: '/first', page: () => FirstNamedPage()),
          // GetPage(name: '/second', page: () => SecondNamedPage()),
        ],
      ),
    );
  }
}
