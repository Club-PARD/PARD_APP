import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRController extends GetxController {
  var result = Rx<Barcode?>(null); // 스캔한 결과
  QRViewController? controller; // qr 커트롤러
  BottomBarController bController = Get.find();
  bool isScanned = false; // 한 번만 찍게 하려고
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  UserController userController = Get.find();

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      if (!isScanned) {
        // isScanned이 false일 때만 스캔 처리
        isScanned = true; // 스캔을 true로 설정
        result.value = scanData;
        String currentTime = DateTime.now().toIso8601String();
        print("Scanned QR Code: ${result.value!.code}");
        print("Scanned Time: $currentTime");
        userController.updateAttend(userController.userInfo.value!.uid!, result.value!.code);

        Get.back(); //찍으면 홈으로 돌아감
        bController.selectedIndex.value = 0;
        print(bController.selectedIndex);
/** ---------------------------------정상 출석 했을 때 ------------------------------------ */
        Get.dialog(Dialog(
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
                      side: const BorderSide(
                          width: 0.50, color: Color(0xFF5262F5)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text('출석체크',
                          style: displaySmall.copyWith(
                            color: const Color(0xFF5262F5),
                          )),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: 56.w,
                        height: 58.h,
                        child: Image.asset(
                          'assets/images/check_success.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text('출석이 완료되었어요.',
                          textAlign: TextAlign.center,
                          style: titleSmall.copyWith(
                            color: const Color(0xFF64C59A),
                          )),
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
                              colors: [Color(0xFF5262F5), Color(0xFF7B3FEF)],
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
              ]),
        )
        /** ---------------------------------정상 출석 했을 때 Dialog------------------------------------ */

        /** ---------------------------------지각 했을 때 ------------------------------------ */
        // Get.dialog(Dialog(
        //   backgroundColor: const Color(0xFF1A1A1A),
        //   child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Container(
        //           width: 327.w,
        //           height: 264.h,
        //           decoration: ShapeDecoration(
        //             color: const Color(0xFF1A1A1A),
        //             shape: RoundedRectangleBorder(
        //               side: const BorderSide(
        //                   width: 0.50, color: Color(0xFF5262F5)),
        //               borderRadius: BorderRadius.circular(8),
        //             ),
        //           ),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //             children: [
        //               SizedBox(
        //                 height: 10.h,
        //               ),
        //               Text('출석체크',
        //                   style: displaySmall.copyWith(
        //                     color: const Color(0xFF5262F5),
        //                   )),
        //               SizedBox(
        //                 height: 10.h,
        //               ),
        //               SizedBox(
        //                 width: 56.w,
        //                 height: 56.h,
        //                 child: Image.asset(
        //                   'assets/images/warning.png',
        //                   fit: BoxFit.fill,
        //                 ),
        //               ),
        //               Text('지각 처리되었어요',
        //                   textAlign: TextAlign.center,
        //                   style: titleSmall.copyWith(
        //                     color: const Color(0xFFFF5A5A),
        //                   )),
        //               SizedBox(
        //                 height: 10.h,
        //               ),
        //               Container(
        //                   width: 254.w,
        //                   height: 44.h,
        //                   decoration: ShapeDecoration(
        //                     gradient: const LinearGradient(
        //                       begin: Alignment(1.00, -0.03),
        //                       end: Alignment(-1, 0.03),
        //                       colors: [Color(0xFF5262F5), Color(0xFF7B3FEF)],
        //                     ),
        //                     shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(30),
        //                     ),
        //                   ),
        //                   child: TextButton(
        //                       onPressed: () {
        //                         Get.back();
        //                       },
        //                       child: Text(
        //                         '다음부터 안그럴게요',
        //                         style: headlineMedium.copyWith(
        //                           color: Colors.white,
        //                         ),
        //                       ))),
        //               SizedBox(
        //                 height: 10.h,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ]),
        // )
        /** ---------------------------------지각 했을 때 Dialog------------------------------------ */

        );
      }
    });
  }

  void onPermissionSet(bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      Get.snackbar('Error', 'No permission');
    }
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }
}
