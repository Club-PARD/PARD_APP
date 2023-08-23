import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget tosAgreement(double height, double width) {
  return Container(
    width: width * 327,
    height: height * 104,
    decoration: BoxDecoration(
        color: Color.fromRGBO(42, 42, 42, 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: Color.fromRGBO(163, 163, 163, 1),
          width: 1,
        )),
    child: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                Icons.check,
                color: Color.fromRGBO(228, 228, 228, 1),
              ),
              SizedBox(
                width: width * 4,
              ),
              Text(
                '개인정보 수집 및 이용 동의(필수)',
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(228, 228, 228, 1)),
              ),
            ],
          ),
          SizedBox(
            height: height * 16,
          ),
          Row(
            children: [
              Icon(
                Icons.check,
                color: Color.fromRGBO(228, 228, 228, 1),
              ),
              SizedBox(
                width: width * 4,
              ),
              Text(
                '서비스 이용약관(필수)',
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(228, 228, 228, 1)),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget tosDescription(double height, double width, String string1,
    String string2, String string3) {
  return Container(
    width: width * 327,
    height: height * 68,
    decoration: BoxDecoration(
        color: Color.fromRGBO(42, 42, 42, 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: Color.fromRGBO(163, 163, 163, 1),
          width: 1,
        )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          string1,
          style:
              TextStyle(fontSize: 14, color: Color.fromRGBO(163, 163, 163, 1)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              string2,
              style: TextStyle(
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [
                      Color.fromRGBO(82, 98, 245, 1),
                      Color.fromRGBO(123, 63, 239, 1),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(
                      Rect.fromLTWH(0, 0, 90, 0)), // Adjust the Rect as needed
                fontSize: 14,
              ),
            ),
            Text(
              string3,
              style: TextStyle(
                  fontSize: 14, color: Color.fromRGBO(163, 163, 163, 1)),
            )
          ],
        ),
      ],
    ),
  );
}

Widget checkbox(RxBool isAgree, double width, double height) {
    return Container(
      width: width,
      height: height,
      child: Checkbox(
        value: isAgree.value,
        onChanged: (bool? value) {
          isAgree.value = !(isAgree.value);
        },
        checkColor: Colors.black,
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed) || isAgree.value) {
            return Color.fromRGBO(82, 98, 245, 1); // 배경색 (눌렸을 때 또는 true 일 때)
          }
          return Color.fromRGBO(171, 171, 171, 1); // 배경색 (false 일 때)
        }),
      ),
    );
  }