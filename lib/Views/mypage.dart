import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/auth_controller.dart';
import 'package:pard_app/controllers/push_notification_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

void launchPrivateInformation() async {
  final Uri privateInfo = Uri.parse(
      'https://pardhgu.notion.site/Pard-APP-fbccc11671d14b4d8012dd999eff7f93?pvs=4');
  try {
    await launchUrl(privateInfo);
  } catch (e) {
    print("Could not launch $privateInfo: $e");
  }
}

void launchServiceInformation() async {
  final Uri serviceInfo = Uri.parse(
      'https://pardhgu.notion.site/Pard-APP-18c93fe8a2c648009e17d1ab294a4fa9?pvs=4');
  try {
    await launchUrl(serviceInfo);
  } catch (e) {
    print("Could not launch $serviceInfo: $e");
  }
}

void launchFeedback() async {
  final Uri feedback = Uri.parse(
      'https://docs.google.com/forms/d/e/1FAIpQLSfFMK14a9BwcRPR2z6uuhQ_Cleg0povmGpcJwpAMLm-nWYp7A/viewform?usp=sf_link');
  try {
    await launchUrl(feedback);
  } catch (e) {
    print("Could not launch $feedback: $e");
  }
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    final controller = PushNotificationController.to;
    final UserController userController = Get.put(UserController());
    late String? uid = userController.userInfo.value?.uid;
    /** push_notification controller 가져온다  */
    return Scaffold(
      backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                GestureDetector(
                  onTap: launchFeedback,
                  child: SizedBox(
                      width: double.infinity,
                      height: 76.h,
                      child: Image.asset('assets/images/banner.png', fit: BoxFit.fill,)),
                ),
                Column(
                  children: [
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 24.w,
                        ),
                        Text('내 정보', style: displaySmall),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        minWidth: 327,
                        minHeight: 96,
                      ),
                      width: 327.w,
                      height: 96.h,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50, color: Color(0xFF5262F5)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 24.w,
                              ),
                              IntrinsicWidth(
                                child: Container(
                                  // width: 42.w,
                                  height: 30.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 4.h),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF5262F5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                        /** generation값으로 대체 */
                                        '${userController.userInfo.value!.generation}기',
                                        style: titleMedium.copyWith(height: 0)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              IntrinsicWidth(
                                child: Container(
                                  // width: 79.w,
                                  height: 30.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 4.h),
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
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                        '${userController.userInfo.value!.part} 파트',
                                        style: titleMedium.copyWith(height: 0)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              IntrinsicWidth(
                                child: Container(
                                  // width: 70.w,
                                  height: 30.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 4.h),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF7B3EEF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                        '${userController.userInfo.value!.member}',
                                        style: titleMedium.copyWith(height: 0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: Text(
                                '${userController.userInfo.value!.name} 님',
                                style: displayMedium),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 24.w),
                        Text('설정', style: displaySmall),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      width: 327.w,
                      height: 50.h,
                      decoration: const BoxDecoration(color: Color(0xFF2A2A2A)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: Text('알림 설정', style: headlineSmall),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 24.w),
                            child: Obx(() {
                              return Switch(
                                value: userController.onOff.value!,
                                onChanged: (value) async {
                                  userController.onOff.value =
                                      !userController.onOff.value!;
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(uid)
                                      .update({'onOff': value});
                                      AppSettings.openAppSettings(); //스위치 누르면 앱 설정으로 이동
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 24.w,
                        ),
                        Text('이용 안내', style: displaySmall),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      width: 327.w,
                      height: 50.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2A2A2A),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: Text('개인정보 처리방침', style: headlineSmall),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: IconButton(
                                onPressed: () {
                                  launchPrivateInformation();
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color.fromRGBO(228, 228, 228, 1),
                                  size: 20,
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 327.w,
                      height: 50.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2A2A2A),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: Text('서비스 이용약관', style: headlineSmall),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: IconButton(
                                onPressed: () {
                                  launchServiceInformation();
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color.fromRGBO(228, 228, 228, 1),
                                  size: 20,
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 24.w,
                        ),
                        Text('계정', style: displaySmall),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      width: 327.w,
                      height: 50.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2A2A2A),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: Text('로그아웃', style: headlineSmall),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            backgroundColor:
                                                const Color(0xFF1A1A1A),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 327.w,
                                                    height: 192.h,
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                          0xFF1A1A1A),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            width: 0.50,
                                                            color: Color(
                                                                0xFF5262F5)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        SizedBox(
                                                          height: 24.h,
                                                        ),
                                                        Text('로그아웃',
                                                            style: displaySmall
                                                                .copyWith(
                                                              color: const Color(
                                                                  0xFF5262F5),
                                                            )),
                                                        Text('로그아웃 하시겠습니까?',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: titleLarge),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            SizedBox(
                                                              width: 20.w,
                                                            ),
                                                            Container(
                                                              width: 116.w,
                                                              height: 44.h,
                                                              decoration:
                                                                  ShapeDecoration(
                                                                color: const Color(
                                                                    0xFF2A2A2A),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                              ),
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  child: Text(
                                                                    '취소',
                                                                    style: headlineMedium
                                                                        .copyWith(
                                                                      color: const Color(
                                                                          0xFFA2A2A2),
                                                                    ),
                                                                  )),
                                                            ),
                                                            Container(
                                                                width: 116.w,
                                                                height: 44.h,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  gradient:
                                                                      const LinearGradient(
                                                                    begin: Alignment(
                                                                        1.00,
                                                                        -0.03),
                                                                    end: Alignment(
                                                                        -1,
                                                                        0.03),
                                                                    colors: [
                                                                      
                                                                      Color(
                                                                          0xFF7B3FEF),
                                                                          Color(
                                                                          0xFF5262F5),
                                                                    ],
                                                                  ),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30),
                                                                  ),
                                                                ),
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                              AuthController().signOut();
                                                                            },
                                                                        child:
                                                                            Text(
                                                                          '확인',
                                                                          style:
                                                                              headlineMedium.copyWith(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ))),
                                                            SizedBox(
                                                              width: 20.w,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 24.h,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                          );
                                        });
                                  });
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color.fromRGBO(228, 228, 228, 1),
                                  size: 20,
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 327.w,
                      height: 50.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2A2A2A),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: Text('탈퇴하기', style: headlineSmall),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            backgroundColor:
                                                const Color(0xFF1A1A1A),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 327.w,
                                                    height: 192.h,
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                          0xFF1A1A1A),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            width: 0.50,
                                                            color: Color(
                                                                0xFF5262F5)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        SizedBox(
                                                          height: 24.h,
                                                        ),
                                                        Text('회원탈퇴',
                                                            style: displaySmall
                                                                .copyWith(
                                                              color: const Color(
                                                                  0xFF5262F5),
                                                            )),
                                                        Text.rich(
                                                          TextSpan(
                                                            children: [
                                                              const TextSpan(
                                                                text:
                                                                    '회원 탈퇴를 원하시면\n공식 계정(',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'Pretendard',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 1.29,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    'official@we-pard.com',
                                                                style: titleLarge
                                                                    .copyWith(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  color: const Color(
                                                                      0xFF5262F5),
                                                                ),
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () async {
                                                                        final Uri
                                                                            url =
                                                                            Uri.parse('https://we-pard.com/');
                                                                        if (await canLaunchUrl(
                                                                            url)) {
                                                                          await launchUrl(
                                                                              url);
                                                                        } else {
                                                                          throw 'Could not launch $url';
                                                                        }
                                                                      },
                                                              ),
                                                              const TextSpan(
                                                                text:
                                                                    ')으로\n메일을 보내주세요. ',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'Pretendard',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 1.29,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Container(
                                                            width: 252.w,
                                                            height: 44.h,
                                                            decoration:
                                                                ShapeDecoration(
                                                              gradient:
                                                                  const LinearGradient(
                                                                begin:
                                                                    Alignment(
                                                                        1.00,
                                                                        -0.03),
                                                                end: Alignment(
                                                                    -1, 0.03),
                                                                colors: [
                                                                  Color(
                                                                      0xFF5262F5),
                                                                  Color(
                                                                      0xFF7B3FEF)
                                                                ],
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                              ),
                                                            ),
                                                            child: TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child: Text(
                                                                  '확인',
                                                                  style: headlineMedium
                                                                      .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ))),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        SizedBox(
                                                          height: 24.h,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                          );
                                        });
                                  });
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color.fromRGBO(228, 228, 228, 1),
                                  size: 20,
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
