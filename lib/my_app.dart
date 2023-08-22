import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pard_app/Views/my_point_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MyPointScreen()),
        // GetPage(name: '/first', page: () => FirstNamedPage()),
        // GetPage(name: '/second', page: () => SecondNamedPage()),
      ],
    );
  }
}
