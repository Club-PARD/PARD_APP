//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';
import 'package:pard_app/controllers/qr_controller.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScan extends StatelessWidget {
  final QRController qrController = Get.put(QRController());
  final BottomBarController bController = Get.find();

  QRScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrController.qrKey,
            onQRViewCreated: qrController.onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: const Color(0xFF7B3FEF),
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 280.h,
            ),
            onPermissionSet: (ctrl, p) => qrController.onPermissionSet(p),
          ),
          Positioned(
            top: 222.h,
            left: 60.w,
            child: Text(
              '테두리 안에 출석 QR코드를 인식해주세요',
              style: headlineLarge.copyWith(
                color: const Color(0xFF1A1A1A),
              ),
            ),
          ),
          Positioned(
            bottom: 146.h,
            right: 168.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(1.00, -0.03),
                      end: Alignment(-1, 0.03),
                      colors: [Color(0xFF5262F5), Color(0xFF7B3FEF)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    bController.selectedIndex.value = 0;
                    print(bController.selectedIndex);
                    Get.back();
                  },
                  icon: const Icon(Icons.close, color: Colors.white),
                  color: const Color(0xFF7B3FEF),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
