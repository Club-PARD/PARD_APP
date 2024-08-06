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
import 'package:pard_app/utilities/color_style.dart';
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
  bool _isScanning = false; 
  bool _dialogShown = false;

void onQRViewCreated(QRViewController controller) {
  this.controller = controller;

  // 유효한 QR 코드 URL 리스트
  final validQrCodes = [
    "https://me-qr.com/uoN4lOs1",
    "https://me-qr.com/1",
    "https://me-qr.com/2",
    "https://me-qr.com/3",
    "https://me-qr.com/4",
    "https://me-qr.com/5",
    "https://me-qr.com/6",
    "https://me-qr.com/7",
    "https://me-qr.com/8",
    "https://me-qr.com/9",
    "https://me-qr.com/10",
  ];

  controller.scannedDataStream.listen((scanData) async {
    if (!isScanned && !_isScanning) {
      
      result.value = scanData; // 스캔 결과 저장

      String qrCode = result.value?.code ?? '';
      print(qrCode);

      // QR 코드 유효성 검사
      if (!validQrCodes.contains(qrCode) && !_dialogShown) {
         _dialogShown = true;
        _showInvalidQRDialog();
        isScanned = false; // 스캔 플래그 리셋
        _isScanning = false;
        return;
      }

      String? todaySchedule = await getTodaySchedule(qrCode);

      QRAttendanceRequestDTO requestDTO = QRAttendanceRequestDTO(
        qrUrl: qrCode,
        seminar: todaySchedule ?? '', 
      );

      // 백엔드 호출하여 QR 유효성 검사
      AttendanceResponse? response = await _validateQR(requestDTO);
      print(response?.attended);
      if (response != null && response.attended) {
        _showAttendanceDialog('출석이 완료되었어요.', '출석', 'check_success.png', Colors.green);
      } else {
        _showAttendanceDialog('지각 처리되었어요', '지각', 'warning.png', Colors.red);
      }
      
    } else {
      _showAttendanceDialog(
        '이미 출석 완료되었어요',
        '출석체크',
        '2ndQR.png',
        primaryBlue,
      );
    }
  });
}

Future<AttendanceResponse?> _validateQR(QRAttendanceRequestDTO requestDTO) async {
  if (_isScanning) {
    print('QR 코드 스캔이 이미 진행 중입니다.');
    return null;
  }

  _isScanning = true;
  try {
    Map<String, dynamic> requestBody = requestDTO.toJson();
    final response = await http.post(
      Uri.parse('${dotenv.env['SERVER_URL']}/v1/validQR'),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'Authorization=${authController.obxToken.value}',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return AttendanceResponse.fromJson(jsonDecode(response.body));
    } else {
      print('200 아님 : ${response.statusCode}');
      print({response.body});
      return null;
    }
  } catch (e) {
    print('Error validating QR: $e');
    return null;
  } finally {
    _isScanning = false;
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
                        _dialogShown = false;
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
                        isScanned = true; 
                        _isScanning = false;
                        Get.toNamed('/home');
                      },
                      child: Text(
                        title == "지각" ?  '다음부터 안그럴게요' : '세미나 입장하기',
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

  Future<String> getTodaySchedule(String qrCode) async {
  switch (qrCode) {
    case "https://me-qr.com/uoN4lOs1":
      return "OT";
    case "https://me-qr.com/1":
      return "1차 세미나";
    case "https://me-qr.com/2":
      return "2차 세미나";
    case "https://me-qr.com/3":
      return "3차 세미나";
    case "https://me-qr.com/4":
      return "4차 세미나";
    case "https://me-qr.com/5":
      return "5차 세미나";
    case "https://me-qr.com/6":
      return "6차 세미나";
    case "https://me-qr.com/7":
      return "연합 세미나";
    case "https://me-qr.com/8":
      return "연합 세미나2";
    case "https://me-qr.com/9":
      return "아이디어 피칭";
    case "https://me-qr.com/10":
      return "종강총회";
    default:
      throw Exception("잘못된 QR 코드입니다.");
  }
}


  Future<void> checkAttendance(String status,String seminar, String email) async {
    final url = Uri.parse('${dotenv.env['SERVER_URL']}/v1/attendance/admin');
    final dto = AttendanceAdminRequestDTO(
      status: status,
      seminar: seminar
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
