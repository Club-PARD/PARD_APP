import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/controllers/auth_controller.dart';
import 'package:pard_app/controllers/bottombar_controller.dart';
import 'package:pard_app/controllers/push_notification_controller.dart';
import 'package:pard_app/controllers/spring_user_controller.dart';
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

String getRoleString(String? role) {
    switch (role) {
      case 'ROLE_ADMIN':
        return '운영진';
      case 'ROLE_YB':
        return '파디';
      case 'ROLE_OB':
        return '파도';
      default:
        return '청소';
    }
  }

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    final BottomBarController bottomController = Get.find();
    final UserController userController = Get.put(UserController());
    final SpringUserController springUserController = Get.put(SpringUserController());
    late String? uid = userController.userInfo.value?.uid;
    /** push_notification controller 가져온다  */
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(26, 26, 26, 1),
        extendBody: true,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  GestureDetector(
                      onTap: launchFeedback,
                      child: AspectRatio(
                        aspectRatio: 375 / 76,
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/newBanner.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      )),
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
                                          '${springUserController.userInfo.value?.generation}기',
                                          style:
                                              titleMedium.copyWith(height: 0)),
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
                                          '${springUserController.userInfo.value?.part}',
                                          style:
                                              titleMedium.copyWith(height: 0)),
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
                                          getRoleString(springUserController.userInfo.value?.role),
                                          style:
                                              titleMedium.copyWith(height: 0)),
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
                                  '${springUserController.userInfo.value?.name} 님',
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
                        decoration:
                            const BoxDecoration(color: Color(0xFF2A2A2A)),
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
                                    print(userController.onOff.value);
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(uid)
                                        .update({'onOff': value});
                                    AppSettings.openAppSettings();
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 327.w,
                                                      height: 192.h,
                                                      decoration:
                                                          ShapeDecoration(
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
                                                              style:
                                                                  displaySmall
                                                                      .copyWith(
                                                                color: const Color(
                                                                    0xFF5262F5),
                                                              )),
                                                          Text('로그아웃 하시겠습니까?',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  titleLarge),
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
                                                                        BorderRadius.circular(
                                                                            30),
                                                                  ),
                                                                ),
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          '취소',
                                                                          style:
                                                                              headlineMedium.copyWith(
                                                                            color:
                                                                                const Color(0xFFA2A2A2),
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
                                                                            bottomController.selectedIndex.value =
                                                                                0; //로그아웃하고 들어올 때 index 0으로 하기
                                                                            AuthController().signOut();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            '확인',
                                                                            style:
                                                                                headlineMedium.copyWith(
                                                                              color: Colors.white,
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
                        height: 70.h,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2A2A2A),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 24.w),
                              child: Text('회원탈퇴', style: headlineSmall),
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 327.w,
                                                      height: 192.h,
                                                      decoration:
                                                          ShapeDecoration(
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
                                                            height: 10.h,
                                                          ),
                                                          Text('회원탈퇴',
                                                              style:
                                                                  displaySmall
                                                                      .copyWith(
                                                                color: const Color(
                                                                    0xFF5262F5),
                                                              )),
                                                          Text(
                                                              '회원 탈퇴 후 개인정보, 점수 등의\n 데이터가 삭제되며 복구할 수 없습니다.\n 정말 삭제하시겠습니까?',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  titleLarge),
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
                                                                        BorderRadius.circular(
                                                                            30),
                                                                  ),
                                                                ),
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          '취소',
                                                                          style:
                                                                              headlineMedium.copyWith(
                                                                            color:
                                                                                const Color(0xFFA2A2A2),
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
                                                                              () async {
                                                                                AppSettings.openAppSettings();
                                                                            bottomController.selectedIndex.value =
                                                                                0; //로그아웃하고 들어올 때 index 0으로 하기

                                                                            if (uid !=
                                                                                null) {
                                                                              AuthController().deleteUserFields();
                                                                            } else {
                                                                              print("UID is null");
                                                                            }
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            '확인',
                                                                            style:
                                                                                headlineMedium.copyWith(
                                                                              color: Colors.white,
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
      ),
    );
  }
}
