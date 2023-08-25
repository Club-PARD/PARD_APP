import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/component/bottom.dart';
import 'package:pard_app/component/home_appbar.dart';
import 'package:pard_app/controllers/point_controller.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final PointController pointController = Get.put(PointController());

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
                  ),
                  Row(
                    children: [
                      SizedBox(width: 24.w),
                      RichText(
                        text: TextSpan(
                          style: displaySmall,
                          children: const <TextSpan>[
                            TextSpan(text: '안녕하세요, '),
                            TextSpan(
                                text: '조세희',
                                style: TextStyle(color: Color(0XFF5262F5))),
                            TextSpan(text: '님\n오늘도 PARD에서 함께 협업해요!'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 24.w,
                      ),
                      Container(
                        width: 42.w,
                        height: 24.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF5262F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF7B3EEF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                            /** member값으로 대체 */
                            '거친 파도',
                            style: titleMedium),
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
                      SizedBox(
                        height: 20.h,
                        child: Text('🏄🏻‍♂️ PARDNERSHIP 🏄🏻‍♂️ ',
                            style: headlineLarge),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text('더보기', style: titleMedium)),
                    ],
                  ),
                  Container(width: 279.w, height: 1.h, color: grayScale[30]),
                  SizedBox(
                    height: 20.5.h,
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
              height: 162.h,
              decoration: ShapeDecoration(
                color: const Color(0xFF2A2A2A),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Column(
                children: [
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
                  SizedBox(
                    height: 15.5.h,
                  ),
                  Container(width: 279.w, height: 1.h, color: grayScale[30]),
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
