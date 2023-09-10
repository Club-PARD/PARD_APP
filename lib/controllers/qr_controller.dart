import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';
import 'package:pard_app/controllers/point_controller.dart';
import 'package:pard_app/controllers/schedule_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/model/schedule_model/schedule_model.dart';
import 'package:pard_app/model/user_model/user_model.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRController extends GetxController {
  var result = Rx<Barcode?>(null); // 스캔한 결과
  QRViewController? controller; // qr 커트롤러
  BottomBarController bController = Get.find();
  bool isScanned = false; // 한 번만 찍게 하려고
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  UserController userController = Get.find();
  final ScheduleController scheduleController = Get.put(ScheduleController());
  final PointController pointController = Get.find();

  void onQRViewCreated(QRViewController controller) async {
    this.controller = controller;

    //오늘 qr찍었는지 확인, 스케쥴 가져오는 변수들
    DateTime today = DateTime.now();
    DateTime startToday = DateTime(today.year, today.month, today.day);
    DateTime endToday = startToday
        .add(const Duration(days: 1))
        .subtract(const Duration(seconds: 1));

    //오늘 있는 schedule가져옴
    QuerySnapshot scheduleSnapshot = await FirebaseFirestore.instance
        .collection('schedules')
        .where('dueDate',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startToday))
        .where('dueDate', isLessThanOrEqualTo: Timestamp.fromDate(endToday))
        .get();
    //오늘 스케쥴 가져오기
    DocumentSnapshot todayScheduleDoc = scheduleSnapshot.docs.first;
    String sid = todayScheduleDoc.id; // sid추출
    DateTime scheduleDueDate = todayScheduleDoc['dueDate'].toDate();
    print('scheduleDueDate : $scheduleDueDate');
    //qr 스캔하는지
    controller.scannedDataStream.listen((scanData) async {
      if (!isScanned) {
        // isScanned이 false일 때만 스캔 처리
        isScanned = true; // 스캔을 true로 설정
        result.value = scanData; //스캔한 결과 저장
        UserModel user = userController.userInfo.value!;
        bool hasScanned = await userController.hasAlreadyScannedToday(
            userController.userInfo.value,
            result.value?.code); //찍은적 없으면 hasScanned는 false
        DateTime currentTime = DateTime.now(); //QR찍었을 때 시간
        print('HAS SCANNED!!!!!!!!!!!!!!!!!!!!!!!!!!!!59');
        print(hasScanned);

        print("Scanned QR Code: ${result.value!.code}");
        print("Scanned Time: $currentTime");
        print("Current time: $currentTime");
        print("Schedule Due Date: $scheduleDueDate");

        if (hasScanned) {
          Get.back(); //찍으면 홈으로 돌아감
          bController.selectedIndex.value = 0;
          print(bController.selectedIndex);

          Get.dialog(
              barrierDismissible: false,
              Dialog(
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
                                'assets/images/2ndQR.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text('이미 출석이 완료되었어요.',
                                textAlign: TextAlign.center,
                                style: titleSmall.copyWith(
                                    color: const Color(0xFF5262F5))),
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
                    ]),
              ));
          isScanned = false;
        }
        //오늘 찍은적이 없으면
        else if (!hasScanned) {
          if (currentTime.isBefore(scheduleDueDate) &&
              result.value!.code == "https://me-qr.com/uoN4lOs1") {
            //정상출석

            Get.back(); //찍으면 홈으로 돌아감
            bController.selectedIndex.value = 0;
            print(bController.selectedIndex);

            Get.dialog(
                barrierDismissible: false,
                Dialog(
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
                                      onPressed: () async {
                                        Get.back();
                                        userController.AddAttend(sid, '출');
                                        await pointController.attendQR(user, 6);
                                        await userController.AddAttendInfo('출');
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
                ));
            isScanned = false;
            print('HAS SCANNED!!!!!!!!!!!!!!!!!!!!!!!!!!!!164');
            print(hasScanned);
          } else if (currentTime.isAfter(scheduleDueDate) &&
              result.value!.code == "https://me-qr.com/uoN4lOs1") {
            //이미 시간 지난 오늘치 schedule과 qr찍은 시간 비교했을 때 이미 지났으면 지각
            print(currentTime.isAfter(scheduleDueDate));

            Get.back(); //찍으면 홈으로 돌아감
            bController.selectedIndex.value = 0;
            print(bController.selectedIndex);

            Get.dialog(
                barrierDismissible: false,
                Dialog(
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
                                height: 56.h,
                                child: Image.asset(
                                  'assets/images/warning.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text('지각 처리되었어요',
                                  textAlign: TextAlign.center,
                                  style: titleSmall.copyWith(
                                    color: const Color(0xFFFF5A5A),
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
                                      onPressed: () async {
                                        userController.AddAttend(sid, "지");
                                        await pointController.lateQR(user, 4);
                                        await userController.AddAttendInfo('지');
                                        Get.back();
                                      },
                                      child: Text(
                                        '다음부터 안그럴게요',
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
                ));
            isScanned = false;
          }
        }
        if (result.value!.code != "https://me-qr.com/uoN4lOs1") {
          Get.back();
          bController.selectedIndex.value = 0;
          print(bController.selectedIndex);
          Get.dialog(
              barrierDismissible: false,
              Dialog(
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
                            Text('유효하지 않은 QR 코드입니다.\n다시 시도해주세요.',
                                textAlign: TextAlign.center,
                                style: titleSmall.copyWith(
                                  color: Colors.white,
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
                                onPressed: () async {
                                  print("Back button pressed");
                                  Get.back();
                                  isScanned = false; // Reset the isScanned flag
                                },
                                child: Text(
                                  '확인',
                                  style: headlineMedium.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ]),
              ));
          isScanned = false;
        }
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
