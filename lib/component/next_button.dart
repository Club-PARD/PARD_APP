import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget nextButton(String title, String route, double unit_width,
    double unit_height, bool isNext, VoidCallback? function) {
  return GestureDetector(
      child: Container(
        width: unit_width * 327,
        height: unit_height * 56,
        decoration: BoxDecoration(
          gradient: isNext
              ? LinearGradient(
                  colors: [
                    Color.fromRGBO(82, 98, 245, 1),
                    Color.fromRGBO(123, 63, 239, 1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: !isNext ? Color.fromRGBO(163, 163, 163, 1) : null,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        if (isNext) {
          if(function != null) {
            function;
          }
          Get.toNamed(route);
        }
      });
}
