import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/controllers/point_controller.dart';
import 'package:pard_app/utilities/color_style.dart';

class MyPointScreen extends StatelessWidget {
  MyPointScreen({super.key});
  final PointController pointController = Get.put(PointController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PardAppBar(
        '내 점수',
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 32.0,
          ),
          child: Column(
            children: [
              SizedBox(
                width: 229.w,
                height: 36.h,
                child: const Image(
                  image: AssetImage('assets/images/pardnershipTop3.png'),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  rankWithTopIcon('top1'),
                  rankWithTopIcon('top2'),
                  rankWithTopIcon('top3'),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rankWithText(context),
                      rankWithText(context),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '전체랭킹 확인하기',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              myCurrentPoints(context),
              pointRecordCarouselSlider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget rankWithTopIcon(String top) {
    return Row(
      children: [
        Image(
          width: 40.w,
          height: 49.h,
          image: AssetImage('assets/images/$top.png'),
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: 유저 데이터 가져오기
            Text(
              '디자인 파트',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              '김파드',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget rankWithText(context) {
    return Container(
      width: 155.5.w,
      height: 68.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: GradientBoxBorder(
          width: 1.w,
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.onSecondary,
            Theme.of(context).colorScheme.secondary,
          ]),
        ),
      ),
      child: Column(
        children: [
          Text(
            '파드 내 랭킹',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            '3위',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget myCurrentPoints(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '내 점수 현황',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        SizedBox(
          height: 16.h,
        ),
        Container(
          width: double.infinity,
          height: 92.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: containerBackgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 54.5.w,
              vertical: 24.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      '파드 포인트',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      '+7점',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: primaryGreen),
                    ),
                  ],
                ),
                VerticalDivider(
                  thickness: 1,
                  color: grayScale[30],
                ),
                Column(
                  children: [
                    Text(
                      '파드 포인트',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      '+7점',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: errorRed),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget pointRecordCarouselSlider() {
    List<int> list = [1, 2, 3, 4, 5];
    return CarouselSlider(
      options: CarouselOptions(),
      items: list
          .map((item) => Container(
                child: Center(child: Text(item.toString())),
                color: Colors.green,
              ))
          .toList(),
    );
  }
}
