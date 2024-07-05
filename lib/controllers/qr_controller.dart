import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pard_app/controllers/auth_controller.dart';
import 'package:pard_app/controllers/spring_schedule_controller.dart';
import 'package:pard_app/controllers/spring_user_controller.dart';
import 'package:pard_app/model/qr_model/attendance_admin_request_dto.dart';
import 'package:pard_app/model/qr_model/request_qr_dto.dart';
import 'package:pard_app/model/qr_model/response_qr_dto.dart';
import 'package:pard_app/model/schedule_model/schedule_response_dto.dart.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class QRController extends GetxController {
  var result = Rx<Barcode?>(null); // Scanned result
  QRViewController? controller; // QR controller
  bool isScanned = false; // To ensure it scans only once
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  RxString? obxToken; // Token from AuthController
  SpringScheduleController springScheduleController = Get.find();
  AuthController authController = Get.find();
  

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    final email = authController.userEmail.value ?? '';

    controller.scannedDataStream.listen((scanData) async {
      if (!isScanned) {
        isScanned = true; 
        result.value = scanData; // Save scan result

        DateTime currentTime = DateTime.now(); // Time when QR is scanned
        String qrCode = result.value?.code ?? '';

        ScheduleResponseDTO? todaySchedule = await getTodaySchedule();

        // Check QR validity
        if (qrCode != "https://me-qr.com/uoN4lOs1") {
          _showInvalidQRDialog();
          return;
        }

        QRAttendanceRequestDTO requestDTO = QRAttendanceRequestDTO(
          QRUrl: qrCode,
          seminar: todaySchedule?.title ?? '', 
          time: currentTime,
        );

        // Call backend to validate QR
        AttendanceResponse? response = await _validateQR(requestDTO);

        if (response != null && response.isAttended) {
          checkAttendance('출석', todaySchedule?.title ?? '', email);
          _showAttendanceDialog('출석이 완료되었어요.', '출석', 'check_success.png', Colors.green);
        } else {
          checkAttendance('지각', todaySchedule?.title ?? '', email);
          _showAttendanceDialog('지각 처리되었어요', '지각', 'warning.png', Colors.red);
        }
        isScanned = false; // Reset scanned flag
      }
    });
  }

  Future<AttendanceResponse?> _validateQR(QRAttendanceRequestDTO requestDTO) async {
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['SERVER_URL']}/v1/validQR'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'Authorization=${authController.obxToken.value}',
        },
        body: jsonEncode(requestDTO.toJson()),
      );

      if (response.statusCode == 200) {
        return AttendanceResponse.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to validate QR: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error validating QR: $e');
      return null;
    }
  }

  void _showInvalidQRDialog() {
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
                  side: const BorderSide(width: 0.50, color: Color(0xFF5262F5)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 10.h),
                  Text('출석체크',
                      style: TextStyle(color: const Color(0xFF5262F5), fontSize: 20.sp)),
                  SizedBox(height: 10.h),
                  Text('유효하지 않은 QR 코드입니다.\n다시 시도해주세요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                  SizedBox(height: 10.h),
                  Container(
                    width: 254.w,
                    height: 44.h,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(1.00, -0.03),
                        end: Alignment(-1, 0.03),
                        colors: [Color(0xFF7B3FEF), Color(0xFF5262F5)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        Get.back();
                        isScanned = false; 
                      },
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAttendanceDialog(String message, String title, String image, Color color) {
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
                  side: const BorderSide(width: 0.50, color: Color(0xFF5262F5)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 10.h),
                  Text(title, style: TextStyle(color: color, fontSize: 20.sp)),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 56.w,
                    height: 58.h,
                    child: Image.asset('assets/images/$image', fit: BoxFit.fill),
                  ),
                  Text(message,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: color, fontSize: 16.sp)),
                  SizedBox(height: 10.h),
                  Container(
                    width: 254.w,
                    height: 44.h,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(1.00, -0.03),
                        end: Alignment(-1, 0.03),
                        colors: [Color(0xFF7B3FEF), Color(0xFF5262F5)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        Get.back();
                        // Add attendance info to the backend
                        // await userController.addAttendInfo('출');
                        // await pointController.attendQR(user, 6);
                      },
                      child: Text(
                        '세미나 입장하기',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ScheduleResponseDTO?> getTodaySchedule() async {
    DateTime now = DateTime.now();
    String todayStr = DateFormat('yyyy-MM-dd').format(now);

    try {
      ScheduleResponseDTO firstSchedule = springScheduleController.upcomingSchedules.firstWhere(
        (schedule) {
          String scheduleDateStr = DateFormat('yyyy-MM-dd').format(schedule.date);
          return scheduleDateStr == todayStr;
        },
        orElse: () => throw Exception('No schedule found for today'),
      );

      return firstSchedule;
    } catch (e) {
      print('오늘 스케쥴 없음 : $e');
      return null;
    }
  }

  Future<void> checkAttendance(String status,String seminar, String email) async {
    final url = Uri.parse('${dotenv.env['SERVER_URL']}/v1/attendance/admin');
    final dto = AttendanceAdminRequestDTO(
      status: status,
      seminar: seminar,
      email: email,
    );

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'Authorization=${authController.obxToken.value}',
      },
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200) {
      print('Attendance confirmed: ${response.body}');
    } else {
      print('Failed to confirm attendance: ${response.statusCode}');
    }
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
