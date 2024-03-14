import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/utilities/text_style.dart';

class QrView extends StatelessWidget {
  const QrView({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1A1A1A),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 327.w,
            height: 264.h,
            decoration: ShapeDecoration(
                color: const Color(0xFF1A1A1A),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50, color: Color(0xFF5262F5)),
                  borderRadius: BorderRadius.circular(8),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '출석체크',
                  style:
                      displaySmall.copyWith(color: const Color((0xFF5262F5))),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  width: 56.w,
                  height: 58.h,
                  child:
                      Image.asset('assets/images/2ndQR.png', fit: BoxFit.fill),
                ),
                Text('이미 출석이 완료되었어요.',
                    textAlign: TextAlign.center,
                    style: titleSmall.copyWith(color: const Color(0xFF5262F5))),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                    width: 254.w,
                    height: 44.h,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(1.00, -0.03),
                        end: Alignment(-1, 0.03),
                        colors: [
                          Color(0xFF7B3FEF),
                          Color(0xFF5262F5),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          '세미나 입장하기',
                          style: headlineMedium.copyWith(
                            color: Colors.white,
                          ),
                        ))),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
