import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:pard_app/Views/home_schedule_view.dart';
import 'package:pard_app/controllers/auth_controller.dart';
import 'package:pard_app/controllers/point_controller.dart';
import 'package:pard_app/controllers/push_notification_controller.dart';
import 'package:pard_app/controllers/spring_point_controller.dart';
import 'package:pard_app/controllers/spring_user_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/model/point_model/point_model.dart';
import 'package:pard_app/model/point_model/user_point.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PointController pointController = Get.put(PointController());
  final UserController userController = Get.find<UserController>();
  final SpringUserController springUserController = Get.find<SpringUserController>();
  final GlobalKey questionDialogKey = GlobalKey();
  final formatter = NumberFormat("#,##0.##");
  final SpringPointController springPointController = Get.put(SpringPointController());
  final AuthController authController = Get.put(AuthController());

  bool showContainer = false;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('---------------home_view()');
    });
  }

  void showOverlay(BuildContext context) async {
    await PushNotificationController.to.setupFlutterNotifications();


    final RenderBox renderBox =
        questionDialogKey.currentContext!.findRenderObject() as RenderBox;
    final boxPosition = renderBox.localToGlobal(Offset.zero);

    if (overlayEntry == null) {
      OverlayState? overlayState = Overlay.of(context);
      overlayEntry = OverlayEntry(
        builder: (context) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  removeOverlay();
                },
              ),
              Positioned(
                top: boxPosition.dy + renderBox.size.height,
                left: 30.w,
                child: Material(
                  child: GestureDetector(
                    onTap: () {
                      removeOverlay();
                    },
                    child: Container(
                      color: const Color(0xFF242424),
                      child: Center(
                        child: Container(
                            width: 310.w,
                            height: 64.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF1A1A1A),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFF5262F5)),
                                borderRadius: BorderRadius.circular(8.h),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 12.5.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 45.h,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                              text:
                                                                  '저는 파드 포인트와 출석 점수를 먹고 자라는 ‘',
                                                              style:
                                                                  titleSmall),
                                                          TextSpan(
                                                            text: '팡울이',
                                                            style: titleSmall.copyWith(
                                                                color: const Color(
                                                                    0xFF5262F5)),
                                                          ),
                                                          TextSpan(
                                                            text: '‘예요.',
                                                            style: titleSmall,
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '\n오늘도 PARD에서 저와 함께 성장해가요! ☺️',
                                                            style: titleSmall,
                                                          ),
                                                        ],
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.close,
                                          color: grayScale[30],
                                          size: 20.h,
                                        ),
                                        SizedBox(
                                          height: 24.h,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
      overlayState.insert(overlayEntry!);
    }
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      minWidth: 375, // 최소 너비
                      minHeight: 270, // 최소 높이
                    ),
                    width: 375.w,
                    height: 281.h,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF242424),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        // if(userController.deviceName.value == "iPHONE")
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 24.w),
                            Obx(
                              () => RichText(
                                text: TextSpan(
                                  style: displaySmall,
                                  children: <TextSpan>[
                                    const TextSpan(text: '안녕하세요, '),
                                    TextSpan(
                                      text: springUserController.userInfo.value?.name ?? '사용자',
                                      style: displayMedium.copyWith(
                                          color: const Color(0XFF5262F5)),
                                    ),
                                    const TextSpan(
                                        text: ' 님\n오늘도 PARD에서 함께 협업해요!'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 24.w,
                            ),
                            IntrinsicWidth(
                              child: Container(
                                // width: 50.w,
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
                                      /** generation값으로 대체 null이면 0기 */
                                      '${springUserController.userInfo.value?.generation ?? 0}기'
                                          .toString(),
                                      style: titleMedium.copyWith(height: 0)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            IntrinsicWidth(
                              child: Container(
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
                                  child: Obx(
                                    () => Text(
                                        /** part값으로 대체 없으면 청소해 */
                                        springUserController.userInfo.value?.part ?? '청소',
                                        style: titleMedium.copyWith(height: 0)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            IntrinsicWidth(
                              child: Container(
                                // width: 80.w,
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
                                  child: Obx(
                                    () => Text(
                                        /** member값으로 대체 없으면 청소부원*/
                                        getRoleString(springUserController.userInfo.value?.role),
                                        style: titleMedium.copyWith(height: 0)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Builder(
                                key: questionDialogKey,
                                builder: (BuildContext questionDialogContext) {
                                  return InkWell(
                                    onTap: () {
                                      showOverlay(context);
                                    },
                                    child: Image.asset(
                                      'assets/images/question.png',
                                      fit: BoxFit.fill,
                                      width: 24,
                                      height: 24,
                                    ),
                                  );
                                }),
                            SizedBox(
                              width: 24.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        /** 캐릭터 Row로 나중에 point 정보로 캐릭터들 변경해야함*/
                        /** -------------------------- 여기부터 ---------------------------------------------------- */
                        Obx(() {

                          // PointModel? pointModel =
                          //     pointController.rxPointModel.value;

                          // if (pointModel == null) {
                          //   return const CircularProgressIndicator(
                          //     color: primaryBlue,
                          //   ); // 로딩 처리
                          // }
                      

                          if (springUserController.userInfo.value == null) {
                            return const CircularProgressIndicator(
                              color: primaryBlue,
                            ); // 로딩 처리
                          }

                         int level = determineLevel(springUserController.userInfo.value?.pangoolPoint ?? 0);

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 24.w,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // 현재 캐릭터
                                  Stack(
                                    children: [
                                      Container(
                                        constraints: const BoxConstraints(
                                          minWidth: 120, // 최소 너비
                                          minHeight: 120, // 최소 높이
                                        ),
                                        width: 120.h,
                                        height: 120.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                              blurRadius: 12,
                                              offset: const Offset(0, -1),
                                              spreadRadius: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        constraints: const BoxConstraints(
                                          minWidth: 120, // 최소 너비
                                          minHeight: 120, // 최소 높이
                                        ),
                                        width: 120.h,
                                        height: 120.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2A2A2A),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      Container(
                                        constraints: const BoxConstraints(
                                          minWidth: 120, // 최소 너비
                                          minHeight: 120, // 최소 높이
                                        ),
                                        width: 120.h,
                                        height: 120.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: GradientBoxBorder(
                                            width: 1.w,
                                            gradient: LinearGradient(colors: [
                                              Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                              Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ]),
                                          ),
                                          gradient: LinearGradient(colors: [
                                            Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                                .withOpacity(0.1),
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.1),
                                          ]),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: (level == 1 ||
                                                    level == 3)
                                                ? const EdgeInsets.only(
                                                    top: 8.0)
                                                : const EdgeInsets.only(
                                                    top: 0.0),
                                            child: Image.asset(
                                              'assets/images/pardie$level.png',
                                              width: changeCurrentWidth(
                                                  level),
                                              height: changeCurrentHeight(
                                                  level),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Container(
                                    constraints: const BoxConstraints(
                                      minWidth: 60, // 최소 너비
                                      minHeight: 12, // 최소 높이
                                    ),
                                    width: 60.w,
                                    height: 12.h,
                                    child: Image.asset(
                                      'assets/images/level$level.png',
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                ],
                              ),
                              Expanded(child: Container()),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 24, // 최소 너비
                                  maxHeight: 24, // 최소 높이
                                ),
                                child: Image.asset(
                                  'assets/images/triangle.png',
                                  width: 24.w,
                                  height: 24.h,
                                ),
                              ),
                              Expanded(child: Container()),
                              // 다음 캐릭터
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    constraints: const BoxConstraints(
                                      minWidth: 120,
                                      minHeight: 120,
                                    ),
                                    width: 120.w,
                                    height: 120.h,
                                    child: Image.asset(
                                      'assets/images/next_lv${level+ 1}.png',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Container(
                                    constraints: const BoxConstraints(
                                      minWidth: 60, // 최소 너비
                                      minHeight: 12, // 최소 높이
                                    ),
                                    width: 60.w,
                                    height: 12.h,
                                    child: Image.asset(
                                      'assets/images/n_level${level+ 1}.png',
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                ],
                              ),
                              // 여기까지
                              SizedBox(
                                width: 24.w,
                              ),
                            ],
                          );
                        }),
                        /** -------------------------- 여기까지 이미지 ---------------------------------------------------- */
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      minWidth: 327, // 최소 너비
                      minHeight: 130, // 최소 높이
                    ),
                    padding: EdgeInsets.only(left: 24.w, right: 12.w),
                    width: 327.w,
                    height: 140.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2A2A2A),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('🏄🏻‍♂️ PARDNERSHIP 🏄🏻‍♂️ ',
                                style: headlineLarge),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed('/mypoint');
                                },
                                child: Text('더보기',
                                    style: titleMedium.copyWith(
                                        decoration: TextDecoration.underline,
                                        color: grayScale[10]))),
                          ],
                        ),
                        Divider(
                          color: grayScale[30],
                          height: 0,
                          thickness: 1,
                          endIndent: 14.w,
                        ),
                        // Container(height: 1.h, color: grayScale[30]),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 12.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 70.w,
                                child: Column(
                                  children: [
                                    Text('파드 포인트', style: titleMedium),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    /** User의 point로 변경 */
                                    Obx(
                                      () {

                                        if (springUserController.userInfo.value == null) {
                                          return const CircularProgressIndicator(
                                            color: primaryBlue,
                                          ); // 로딩 처리
                                        }
                                        return Text(
                                          (getRoleString(springUserController.userInfo.value?.role) == '잔잔파도' ||
                                          getRoleString(springUserController.userInfo.value?.role) == '운영진')
                                              ? '-'
                                              : (springUserController.userInfo.value == 0)
                                                  ? '${formatter.format(springUserController.userInfo.value?.totalBonus)}점'
                                                  : '+${formatter.format(springUserController.userInfo.value?.totalBonus)}점',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(color: primaryGreen),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  width: 1.w,
                                  height: 44.h,
                                  color: grayScale[30]),
                              SizedBox(
                                width: 70.w,
                                child: Column(
                                  children: [
                                    Text('벌점', style: titleMedium),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    /** User의 point로 변경 */
                                    Obx(
                                      () {
                                        if (springUserController.userInfo.value == null) {
                                          return const CircularProgressIndicator(
                                            color: primaryBlue,
                                          ); // 로딩 처리
                                        }
                                        return Text(
                                          (getRoleString(springUserController.userInfo.value?.role) == '잔잔파도' ||
                                           getRoleString(springUserController.userInfo.value?.role) == '운영진')
                                              ? '-'
                                              : '${formatter.format(springUserController.userInfo.value?.totalMinus)}점',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(color: errorRed),
                                        );

                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      minWidth: 327, // 최소 너비
                      minHeight: 162, // 최소 높이
                    ),
                    width: 327.w,
                    height: 162.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2A2A2A),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 24.w, right: 12.w),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('🗓 UPCOMING EVENT 🗓 ',
                                      style: headlineLarge),
                                  TextButton(
                                      onPressed: () {
                                        Get.toNamed('/schedule');
                                      },
                                      child: Text('더보기',
                                          style: titleMedium.copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                            color: grayScale[10],
                                          ))),
                                ],
                              ),
                              Divider(
                                color: grayScale[30],
                                height: 0,
                                thickness: 1,
                                endIndent: 14.w,
                              ),
                            ],
                          ),
                        ),

                        // Container(
                        //     width: 279.w, height: 1.h, color: grayScale[30]),
                        Container(
                          constraints: const BoxConstraints(
                            minWidth: 275,
                            minHeight: 100,
                          ),
                          width: 275.w,
                          height: 100.h,
                          child: HomeSchedule(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double changeCurrentWidth(int level) {
    switch (level) {
      case 1:
        return 60;
      case 2:
        return 76;
      case 3:
        return 86.59;
      case 4:
        return 88.02;
      default:
        return 106.16;
    }
  }

  double changeCurrentHeight(int level) {
    switch (level) {
      case 1:
        return 59.14;
      case 2:
        return 80.14;
      case 3:
        return 96;
      case 4:
        return 98;
      default:
        return 100;
    }
  }

  String getRoleString(String? role) {
    switch (role) {
      case 'ROLE_ADMIN':
        return '운영진';
      case 'ROLE_YB':
        return '파디';
      case 'ROLE_OB':
        return '잔잔파도';
      default:
        return '청소';
    }
  }

  int determineLevel(double pangoolPoint) {
  if (pangoolPoint >= 0 && pangoolPoint <= 25) {
    return 1;
  } else if (pangoolPoint > 25 && pangoolPoint <= 50) {
    return 2;
  } else if (pangoolPoint > 50 && pangoolPoint <= 75) {
    return 3;
  } else if (pangoolPoint > 75 && pangoolPoint <= 90) {
    return 4;
  } else if (pangoolPoint > 90) {
    return 5;
  } else {
    return 1; 
  }
}

}
