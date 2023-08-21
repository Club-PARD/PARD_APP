import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      /** 다이알로그 배경 투명해지는 것 */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '테두리 안에 출석 QR코드를 인식해주세요.',
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
            SizedBox(
              height: height / 33.8,
            ),
            Container(
              width: 280,
              height: 280,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFF5262F5)),
                ),
              ),
              child: MobileScanner(
                /** 가운데 위치, 카메라 크기 */
                scanWindow: Rect.fromCenter(
                    center: const Offset(140, 140), width: 280, height: 280),
                onDetect: (capture) {
                  /** qr감지하면 사진 찍고 */
                  final List<Barcode> barcodes = capture.barcodes;
                  /** 찍은qr에서 바코드 정보 추출*/
                  for (final barcode in barcodes) {
                    /** 추출한 바코드 한줄씩 디버깅해서 어떤 qr인지 정보 얻어냄 */
                    debugPrint('Barcode found! ${barcode.rawValue}');
                  }
                  /** 테스트해봤는데 잘됨 */
                },
              ),
            ),
            SizedBox(height: height / 10),
            Stack(
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
                    borderRadius:
                        BorderRadius.circular(24), // to make it circular
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close, color: Colors.white),
                  color: Colors.transparent, // making the color transparent
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
