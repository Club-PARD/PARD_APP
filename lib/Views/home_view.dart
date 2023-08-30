import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/Views/home_schedule_view.dart';
import 'package:pard_app/component/bottom.dart';
import 'package:pard_app/component/home_appbar.dart';
import 'package:pard_app/component/pard_part.dart';
import 'package:pard_app/component/schedule_container.dart';
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

  bool showContainer = false;
  OverlayEntry? overlayEntry;

  void showOverlay(BuildContext context) async {
    await PushNotificationController.to.setupFlutterNotifications();
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
                top: 200.h,
                left: 30.w,
                child: Material(
                  child: GestureDetector(
                    onTap: () {
                      removeOverlay();
                    },
                    child: Container(
                        width: 310.w,
                        height: 80.h,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF1A1A1A),
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFF5262F5)),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300.w,
                              height: 60.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Icon(
                                              Icons.close,
                                              color: grayScale[30],
                                              size: 20.h,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 375.w,
              height: 377.h,
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
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 24.w,
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        width: 120.w,
                        height: 25.h,
                      ),
                      const Spacer(),
                      Builder(builder: (context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          iconSize: 40.w,
                        );
                      }),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  ),
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
                                style:
                                    const TextStyle(color: Color(0XFF5262F5))),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        width: 90.w,
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
                      SizedBox(
                        width: 60.w,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            showOverlay(context);
                          });
                        },
                        child: Image.asset(
                          'assets/images/question.png',
                          fit: BoxFit.fill,
                          width: 24.w,
                          height: 30.h,
                        ),
                      ),
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
                  Row(
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
                          Container(
                            width: 120.w,
                            height: 120.h,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                  color: Color(0xFF5262F5),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/pardie1.png',
                                width: 50.w,
                                height: 50.h,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            width: 53.w,
                            height: 14.h,
                            child: Image.asset(
                              'assets/images/level1.png',
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 30.w,
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
                              colors: [Color(0xFF5262F5), Color(0xFF7B3FEF)],
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
                                  width: 120.w,
                                  height: 120.h,
                                  child: Image.asset(
                                    'assets/images/Frame.png',
                                    width: 120.w,
                                    height: 120.h,
                                    fit: BoxFit.fill,
                                  )),
                              Positioned(
                                  left: 10.w,
                                  top: 16.h,
                                  child: SizedBox(
                                      width: 94.w,
                                      height: 18.h,
                                      child: Image.asset(
                                        'assets/images/NEXT_LEVEL.png',
                                        fit: BoxFit.fill,
                                      ))),
                              Positioned(
                                left: 35.w,
                                top: 42.h,
                                child: Image.asset(
                                  'assets/images/lv2s.png',
                                  width: 50.w,
                                  height: 50.h,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            width: 53.w,
                            height: 14.h,
                            child: Image.asset(
                              'assets/images/n_level2.png',
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                    ],
                  )
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('🏄🏻‍♂️ PARDNERSHIP 🏄🏻‍♂️ ',
                          style: headlineLarge),
                      TextButton(
                          onPressed: () {
                            Get.toNamed('/mypoint');
                          },
                          child: Text('더보기', style: titleMedium)),
                    ],
                  ),
                  Container(width: 279.w, height: 1.h, color: grayScale[30]),
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
                            Text('+7점',
                                style: headlineLarge.copyWith(
                                    color: const Color(0xFF64C59A)))
                          ],
                        ),
                      ),
                      Container(width: 1.w, height: 44.h, color: grayScale[30]),
                      SizedBox(
                        width: 162.5.w,
                        child: Column(
                          children: [
                            Text('벌점', style: titleMedium),
                            SizedBox(
                              height: 8.h,
                            ),
                            /** User의 point로 변경 */
                            Text('컨트롤러에서 ㅋ',
                                style: headlineLarge.copyWith(
                                  color: const Color(0xFFFF5A5A),
                                ))
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
              height: 180.h,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('🗓 UPCOMING EVENT 🗓 ', style: headlineLarge),
                      TextButton(
                          onPressed: () {
                            Get.toNamed('/schedule');
                          },
                          child: Text('더보기', style: titleMedium)),
                    ],
                  ),
                  Container(width: 279.w, height: 1.h, color: grayScale[30]),
                  SizedBox(
                    width: 275.w,
                    height: 90.h,
                    child: HomeSchedule(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
