import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:pard_app/Views/home_schedule_view.dart';
import 'package:pard_app/component/fixed_appbar.dart';
import 'package:pard_app/component/home_appbar.dart';
import 'package:pard_app/controllers/point_controller.dart';
import 'package:pard_app/controllers/push_notification_controller.dart';
import 'package:pard_app/controllers/schedule_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PointController pointController = Get.put(PointController());
  final UserController userController = Get.put(UserController());
  final ScheduleController scheduleController = Get.put(ScheduleController());
  final GlobalKey questionDialogKey = GlobalKey();

  bool showContainer = false;
  OverlayEntry? overlayEntry;

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
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SizedBox(
                                    width: 270.w,
                                    height: 60.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8.h),
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
                                                            style: titleSmall),
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
                                                    textAlign: TextAlign.center,
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
                                        height: 20.h,
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
    return Scaffold(
      endDrawer: const HomeBar(),
      backgroundColor: backgroundColor,
      appBar: const HomeFixedBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  width: 375.w,
                  height: 287.h,
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
                          RichText(
                            text: TextSpan(
                              style: displaySmall,
                              children: <TextSpan>[
                                const TextSpan(text: '안녕하세요, '),
                                TextSpan(
                                  text: userController.userInfo.value!.name,
                                  style: displayMedium.copyWith(
                                      color: const Color(0XFF5262F5)),
                                ),
                                const TextSpan(text: '님\n오늘도 PARD에서 함께 협업해요!'),
                              ],
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
                          Container(
                            width: 50.w,
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
                                  '${userController.userInfo.value?.generation}기'
                                      .toString(),
                                  style: titleMedium),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Container(
                            width:
                                (userController.userInfo.value!.part!.length <=
                                        2)
                                    ? 70.w
                                    : 90.w,
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

                                  /** part값으로 대체 */
                                  '${userController.userInfo.value!.part} 파트',
                                  style: titleMedium),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Container(
                            width: 80.w,
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
                                  /** member값으로 대체 */
                                  '${userController.userInfo.value!.member}',
                                  style: titleMedium),
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
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 24.w,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
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
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2A2A2A),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
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
                                        child: Image.asset(
                                          'assets/images/pardie${pointController.level.value}.png',
                                          width: changeCurrentWidth(
                                              pointController.level.value),
                                          height: changeCurrentHeight(
                                              pointController.level.value),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  width: 60.w,
                                  height: 12.h,
                                  child: Image.asset(
                                    'assets/images/level${pointController.level.value}.png',
                                    fit: BoxFit.fill,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 40.w,
                            ),
                            Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 0.0)
                                ..rotateZ(1.57),
                              child: Container(
                                width: 24.w,
                                height: 24.h,
                                decoration: const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(1.00, -0.03),
                                    end: Alignment(-1, 0.03),
                                    colors: [
                                      Color(0xFF5262F5),
                                      Color(0xFF7B3FEF)
                                    ],
                                  ),
                                  shape: StarBorder.polygon(
                                    sides: 3,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: Image.asset(
                                          'assets/images/Frame.png',
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.fill,
                                        )),
                                    if (pointController.level.value != 5)
                                      Positioned(
                                        left: 14.w,
                                        top: 20.h,
                                        child: SizedBox(
                                          width: 94.w,
                                          height: 12.h,
                                          child: Image.asset(
                                            'assets/images/NEXT_LEVEL.png',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    Positioned(
                                      left: (pointController.level.value != 5)
                                          ? (pointController.level.value != 4)
                                              ? 35.w
                                              : 24.w
                                          : 14.w,
                                      top: (pointController.level.value != 5)
                                          ? 42.h
                                          : 31.h,
                                      child: Image.asset(
                                        'assets/images/lv${pointController.level.value + 1}s.png',
                                        width: changeNextWidth(
                                            pointController.level.value),
                                        height: changeNextHeight(
                                            pointController.level.value),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  width: 60.w,
                                  height: 12.h,
                                  child: Image.asset(
                                    'assets/images/n_level${pointController.level.value + 1}.png',
                                    fit: BoxFit.fill,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 24.w,
                            ),
                          ],
                        ),
                      ),
                      /** -------------------------- 여기까지 이미지 ---------------------------------------------------- */
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 24.w,
                          ),
                          Text('🏄🏻‍♂️ PARDNERSHIP 🏄🏻‍♂️ ',
                              style: headlineLarge),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Get.toNamed('/mypoint');
                              },
                              child: Text('더보기',
                                  style: titleMedium.copyWith(
                                    decoration: TextDecoration.underline,
                                  ))),
                          SizedBox(
                            width: 20.w,
                          )
                        ],
                      ),
                      Container(
                          width: 279.w, height: 1.h, color: grayScale[30]),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 163.5.w,
                            child: Column(
                              children: [
                                Text('파드 포인트', style: titleMedium),
                                SizedBox(
                                  height: 8.h,
                                ),
                                /** User의 point로 변경 */
                                Obx(
                                  () => Text(
                                    '+${pointController.points.value}점',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(color: primaryGreen),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: 1.w, height: 44.h, color: grayScale[30]),
                          SizedBox(
                            width: 162.5.w,
                            child: Column(
                              children: [
                                Text('벌점', style: titleMedium),
                                SizedBox(
                                  height: 8.h,
                                ),
                                /** User의 point로 변경 */
                                Obx(
                                  () => Text(
                                    '-${pointController.beePoints.value}점',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(color: errorRed),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 24.w,
                          ),
                          Text('🗓 UPCOMING EVENT 🗓 ', style: headlineLarge),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                Get.toNamed('/schedule');
                              },
                              child: Text('더보기',
                                  style: titleMedium.copyWith(
                                    decoration: TextDecoration.underline,
                                  ))),
                          SizedBox(
                            width: 20.w,
                          )
                        ],
                      ),
                      Container(
                          width: 279.w, height: 1.h, color: grayScale[30]),
                      SizedBox(
                        width: 275.w,
                        height: 100.h,
                        child: HomeSchedule(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double changeCurrentWidth(int level) {
    switch (level) {
      case 1:
        return 70;
      case 2:
        return 76;
      case 3:
        return 86.59;
      case 4:
        return 93.02;
      default:
        return 106.16;
    }
  }

  double changeCurrentHeight(int level) {
    switch (level) {
      case 1:
        return 69.14;
      case 2:
        return 80.14;
      case 3:
        return 96;
      case 4:
        return 103;
      default:
        return 100;
    }
  }

  double changeNextWidth(int level) {
    switch (level) {
      case 1:
        return 56.1;
      case 2:
        return 54.67;
      case 3:
        return 60;
      case 4:
        return 78;
      default:
        return 91;
    }
  }

  double changeNextHeight(int level) {
    switch (level) {
      case 1:
        return 59.17;
      case 2:
        return 64;
      case 3:
        return 68.3;
      case 4:
        return 69.31;
      default:
        return 60;
    }
  }
}
