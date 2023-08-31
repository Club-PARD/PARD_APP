import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
<<<<<<< Updated upstream
import 'package:pard_app/component/bottom.dart';
import 'package:pard_app/component/home_appbar.dart';
import 'package:pard_app/controllers/point_controller.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final PointController pointController = Get.put(PointController());
=======
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
                top: 210.h,
                left: 30.w,
                child: Material(
                  child: GestureDetector(
                    onTap: () {
                      removeOverlay();
                    },
                    child: Container(
                      color: const Color(0xFF242424),
                      child: Container(
                          width: 320.w,
                          height: 80.h,
                          decoration:  ShapeDecoration(
                            color: const Color(0xFF1A1A1A),
                            shape: RoundedRectangleBorder(
                              side:
                                  const BorderSide(width: 1, color: Color(0xFF5262F5)),
                                  borderRadius: BorderRadius.circular(8.h),
                            ),
                            
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10.w,),
                                  SizedBox(
                                    width: 270.w,
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
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const HomeBar(),
      backgroundColor: backgroundColor,
<<<<<<< Updated upstream
=======
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(46.0),
        child: HomeFixedBar()),

>>>>>>> Stashed changes
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 375.w,
<<<<<<< Updated upstream
              height: 377.h,
=======
              height: 310.h,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                  SizedBox(
                    height: 64.h,
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
=======
                 // if(userController.deviceName.value == "iPHONE")
                  SizedBox(
                    height: 15.h,
>>>>>>> Stashed changes
                  ),
                  Row(
                    children: [
                      SizedBox(width: 24.w),
                      RichText(
                        text: TextSpan(
                          style: displaySmall,
<<<<<<< Updated upstream
                          children: const <TextSpan>[
                            TextSpan(text: '안녕하세요, '),
                            TextSpan(
                                text: '조세희',
                                style: TextStyle(color: Color(0XFF5262F5))),
                            TextSpan(text: '님\n오늘도 PARD에서 함께 협업해요!'),
=======
                          children: <TextSpan>[
                            const TextSpan(text: '안녕하세요, '),
                            TextSpan(
                                text: userController.userInfo.value!.name,
                                style: displayMedium.copyWith(color: const Color(0XFF5262F5)),),
                            const TextSpan(text: '님\n오늘도 PARD에서 함께 협업해요!'),
>>>>>>> Stashed changes
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
<<<<<<< Updated upstream
=======
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
>>>>>>> Stashed changes
                    children: [
                      SizedBox(
                        width: 24.w,
                      ),
                      Container(
<<<<<<< Updated upstream
                        width: 42.w,
                        height: 24.h,
=======
                        width: 50.w,
                        height: 30.h,
>>>>>>> Stashed changes
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF5262F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
<<<<<<< Updated upstream
                        child: Text(
                            /** generation값으로 대체 */
                            '2기',
                            style: titleMedium),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Container(
                        width: 79.w,
                        height: 24.h,
=======
                        child: Center(
                          child: Text(
                              /** generation값으로 대체 */
                              '${userController.userInfo.value?.generation}기'
                                  .toString(),
                              style: titleMedium),
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Container(
                        width: (userController.userInfo.value!.part!.length <= 2) ? 70.w : 90.w,
                        height: 30.h,
>>>>>>> Stashed changes
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(1.00, -0.03),
                            end: Alignment(-1, 0.03),
<<<<<<< Updated upstream
                            colors: [Color(0xFF5262F5), Color(0xFF7B3FEF)],
=======
                            colors: [
                              Color(0xFF7B3FEF),
                              Color(0xFF5262F5),
                            ],
>>>>>>> Stashed changes
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
<<<<<<< Updated upstream
                        child: Text(
                            /** part값으로 대체 */
                            '디자인 파트',
                            style: titleMedium),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Container(
                        width: 70.w,
                        height: 24.h,
=======
                        child: Center(
                          child: Text(

                              /** part값으로 대체 */
                              '${userController.userInfo.value!.part} 파트',
                              style: titleMedium),
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Container(
                        width: 80.w,
                        height: 30.h,
>>>>>>> Stashed changes
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF7B3EEF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
<<<<<<< Updated upstream
                        child: Text(
                            /** member값으로 대체 */
                            '거친 파도',
                            style: titleMedium),
=======
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
                          final RenderBox renderBox = context.findRenderObject() as RenderBox;
final offset = renderBox.localToGlobal(Offset.zero);

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
>>>>>>> Stashed changes
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  /** 캐릭터 Row로 나중에 point 정보로 캐릭터들 변경해야함*/
/** -------------------------- 여기부터 ---------------------------------------------------- */
<<<<<<< Updated upstream
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
                          Text(
                            'LEVEL 1',
                            style: TextStyle(
                              color: const Color(0x665262F5),
                              fontSize: 14.h,
                              fontFamily: 'Sandoll Danpatpang',
                              fontWeight: FontWeight.w400,
                              height: 1.40,
                            ),
                          ),
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
                          Container(
                            width: 120.w,
                            height: 120.h,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    color: Color(0xFF3B3B3B)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Column(children: [
                              SizedBox(
                                height: 16.h,
                              ),
                              const Text(
                                'NEXT LEVEL',
                                style: TextStyle(
                                  color: Color(0x335262F5),
                                  fontSize: 18,
                                  fontFamily: 'Sandoll Danpatpang',
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Image.asset(
                                'assets/images/lv2s.png',
                                width: 50.w,
                                height: 50.h,
                              ),
                            ]),
                          ),
                          Text(
                            'LEVEL ?',
                            style: TextStyle(
                              color: const Color(0xFF3B3B3B),
                              fontSize: 14.h,
                              fontFamily: 'Sandoll Danpatpang',
                              fontWeight: FontWeight.w400,
                              height: 1.40,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                    ],
                  )
=======
                  Obx(
                    () => Row(
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

                            Stack(
                              children: [
                                Container(
                              width: 120.w,
                              height: 120.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    blurRadius: 12,
                                    offset: const Offset(0, -1),
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                            Container(
  width: 120.w,
  height: 120.h,
  decoration: BoxDecoration(
    color: const Color(0xFF2A2A2A),
    borderRadius: BorderRadius.circular(30),
  ),
),

                                Container(
                              width: 120.w,
                              height: 120.h,
                              decoration: 
                            BoxDecoration(
                               borderRadius: BorderRadius.circular(30),
                               border: GradientBoxBorder(width: 1.w,
                               gradient: LinearGradient(colors: [
                            Theme.of(context).colorScheme.onSecondary,
                            Theme.of(context).colorScheme.secondary,
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
                              width: 53.w,
                              height: 14.h,
                              child: Image.asset(
                                'assets/images/level${pointController.level.value}.png',
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
                              width: 53.w,
                              height: 14.h,
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                      SizedBox(
                        height: 20.h,
                        child: Text('🏄🏻‍♂️ PARDNERSHIP 🏄🏻‍♂️ ',
                            style: headlineLarge),
                      ),
                      TextButton(
                          onPressed: () {},
=======
                      Text('🏄🏻‍♂️ PARDNERSHIP 🏄🏻‍♂️ ',
                          style: headlineLarge),
                      TextButton(
                          onPressed: () {
                            Get.toNamed('/mypoint');
                          },
>>>>>>> Stashed changes
                          child: Text('더보기', style: titleMedium)),
                    ],
                  ),
                  Container(width: 279.w, height: 1.h, color: grayScale[30]),
                  SizedBox(
<<<<<<< Updated upstream
                    height: 20.5.h,
=======
                    height: 10.h,
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                            Text('+7점',
                                style: headlineLarge.copyWith(
                                    color: const Color(0xFF64C59A)))
=======
                            Obx(
                              () => Text(
                                '+${pointController.points.value}점',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: primaryGreen),
                              ),
                            ),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                            Text('컨트롤러에서 ㅋ',
                                style: headlineLarge.copyWith(
                                  color: const Color(0xFFFF5A5A),
                                ))
=======
                            Obx(
                              () => Text(
                                '-${pointController.beePoints.value}점',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: errorRed),
                              ),
                            ),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
              height: 162.h,
=======
              height: 180.h,
>>>>>>> Stashed changes
              decoration: ShapeDecoration(
                color: const Color(0xFF2A2A2A),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Column(
                children: [
<<<<<<< Updated upstream
=======
                  SizedBox(
                    height: 10.h,
                  ),
>>>>>>> Stashed changes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('🗓 UPCOMING EVENT 🗓 ', style: headlineLarge),
                      TextButton(
                          onPressed: () {
                            Get.toNamed('/schedule');
                          },
<<<<<<< Updated upstream
                          child: Text('더보기', style: titleMedium)),
                    ],
                  ),
                  SizedBox(
                    height: 15.5.h,
                  ),
                  Container(width: 279.w, height: 1.h, color: grayScale[30]),
=======
                          child: Text('더보기', style: titleMedium.copyWith(decoration: TextDecoration.underline,))),
                    ],
                  ),
                  Container(width: 279.w, height: 1.h, color: grayScale[30]),
                  SizedBox(
                    width: 275.w,
                    height: 90.h,
                    child: HomeSchedule(),
                  )
>>>>>>> Stashed changes
                ],
              ),
            ),
          ],
        ),
      ),
<<<<<<< Updated upstream
      bottomNavigationBar: BottomBar(),
    );
  }
=======
      // bottomNavigationBar: BottomBar(),
    );
  }

  double changeCurrentWidth(int level) {
    switch (level) {
      case 1:
        return 50.w;
      case 2:
        return 66.w;
      case 3:
        return 76.59.w;
      case 4:
        return 83.02.w;
      default:
        return 106.16.w;
    }
  }

  double changeCurrentHeight(int level) {
    switch (level) {
      case 1:
        return 49.14.h;
      case 2:
        return 70.14.h;
      case 3:
        return 86.h;
      case 4:
        return 93.h;
      default:
        return 100.h;
    }
  }

  double changeNextWidth(int level) {
    switch (level) {
      case 1:
        return 56.1.w;
      case 2:
        return 54.67.w;
      case 3:
        return 60.w;
      case 4:
        return 78.w;
      default:
        return 91.w;
    }
  }

  double changeNextHeight(int level) {
    switch (level) {
      case 1:
        return 59.17.h;
      case 2:
        return 64.h;
      case 3:
        return 68.3.h;
      case 4:
        return 69.31.h;
      default:
        return 14.h;
    }
  }
>>>>>>> Stashed changes
}
