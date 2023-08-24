import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRController extends GetxController {
  var result = Rx<Barcode?>(null); // 스캔한 결과
  QRViewController? controller; // qr 커트롤러
  bool isScanned = false; // 한 번만 찍게 하려고
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
        Get.back(); //찍으면 홈으로 돌아감
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