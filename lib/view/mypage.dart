import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pard_app/component/bottombar.dart';

import '../controllers/push_notification_controller.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final controller = PushNotificationController.to;
    /** push_notification controller 가져온다  */
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Get.offNamed('/home'),
        ),
        title: const Text(
          '마이 페이지',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: width,
            height: height / 10,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(1.00, -0.03),
                end: Alignment(-1, 0.03),
                colors: [Color(0xFF5262F5), Color(0xFF7B3FEF)],
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  '운영진에게 전달하고 싶은 의견이 있나요?\n 피드백 창구를 활용해보세요!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    height: 1.57,
                  ),
                ),
                const SizedBox(width: 11),
                Container(
                  height: height / 36,
                  padding: const EdgeInsets.only(
                    left: 5,
                  ),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '피드백 남기기',
                        style: TextStyle(
                          color: Color(0xFF5262F5),
                          fontSize: 10,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 1.40,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        /** 피드백 남기는 페이지로 이동 */
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: height / 33.8,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width / 15.6,
                  ),
                  const Text(
                    '내 정보',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 101.5,
              ),
              Container(
                width: width / 1.14,
                height: height / 12,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.50, color: Color(0xFF5262F5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 24,
                        ),
                        Container(
                          width: 45,
                          height: 24,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF5262F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            /** generation값으로 대체 */
                            '2기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 90,
                          height: 24,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(1.00, -0.03),
                              end: Alignment(-1, 0.03),
                              colors: [Color(0xFF5262F5), Color(0xFF7B3FEF)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            /** part값으로 대체 */
                            '디자인 파트',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 80,
                          height: 24,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF7B3EEF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            /** member값으로 대체 */
                            '거친 파도',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 24.0),
                      child: Text(
                        '김파드님',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 33.8,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width / 15.6,
                  ),
                  const Text(
                    '설정',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 101.5,
              ),
              Container(
                width: width / 1.14,
                height: height / 16,
                decoration: const BoxDecoration(color: Color(0xFF2A2A2A)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 24.0),
                      child: Text(
                        '알림 설정',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.29,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: Obx(() {
                        return Switch(
                          value: controller.onOff.value,
                          onChanged: (value) {
                            controller.onOff.value = !controller.onOff.value;
                            print(controller.onOff.value);
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 33.8,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width / 15.6,
                  ),
                  const Text(
                    '이용 안내',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 101.5,
              ),
              Container(
                width: width / 1.14,
                height: height / 16,
                decoration: const BoxDecoration(
                  color: Color(0xFF2A2A2A),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 24.0),
                      child: Text(
                        '개인정보 처리방침',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.29,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Color.fromRGBO(228, 228, 228, 1),
                          )),
                    )
                  ],
                ),
              ),
              Container(
                width: width / 1.14,
                height: height / 16,
                decoration: const BoxDecoration(
                  color: Color(0xFF2A2A2A),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 24.0),
                      child: Text(
                        '서비스 이용약관',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.29,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Color.fromRGBO(228, 228, 228, 1),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height / 33.8,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width / 15.6,
                  ),
                  const Text(
                    '계정',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 101.5,
              ),
              Container(
                width: width / 1.14,
                height: height / 16,
                decoration: const BoxDecoration(
                  color: Color(0xFF2A2A2A),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 24.0),
                      child: Text(
                        '로그아웃',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.29,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Color.fromRGBO(228, 228, 228, 1),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
