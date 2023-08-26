import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/component/point_policy_dialog.dart';
import 'package:pard_app/controllers/point_controller.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MyPointView extends StatelessWidget {
  MyPointView({super.key});
  final PointController pointController = Get.put(PointController());

  @override
  Widget build(BuildContext context) {
    final GlobalKey buttonKey = GlobalKey();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PardAppBar(
        '내 점수',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0.w,
            vertical: 24.0.h,
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
                  rankWithTopIcon('top1', context),
                  rankWithTopIcon('top2', context),
                  rankWithTopIcon('top3', context),
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
                    onPressed: () {
                      Get.toNamed('/overallRanking');
                    },
                    child: Text(
                      '전체랭킹 확인하기',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: grayScale[30],
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ],
              ),
              myCurrentPoints(context),
              SizedBox(
                height: 24.h,
              ),
              pointRecordCarouselSlider(context, buttonKey),
            ],
          ),
        ),
      ),
    );
  }

  Widget rankWithTopIcon(String top, context) {
    return Row(
      children: [
        Image(
          width: 40.w,
          height: 49.h,
          image: AssetImage('assets/images/$top.png'),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: 유저 데이터 가져오기
            Text(
              '디자인 파트',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: grayScale[30]),
            ),
            Text(
              '김파드',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: grayScale[10]),
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
        color: containerBackgroundColor,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '파드 내 랭킹',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: grayScale[10]),
          ),
          SizedBox(height: 8.h),
          Text(
            '3위',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: grayScale[10]),
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

  Widget pointRecordCarouselSlider(context, buttonKey) {
    List<int> list = [1, 2, 3, 4, 5];
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '점수 기록',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              InkWell(
                key: buttonKey,
                onTap: () {
                  PointPolicyDialog(context, buttonKey).showPointPolicyDialog();
                },
                child: Image(
                  image: AssetImage('assets/images/checkPointPolicy.png'),
                  width: 102.w,
                  height: 20.h,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          SizedBox(
            height: 136.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return itemInCarouselSlider(
                  context,
                  isFirst: index == 0,
                  isLast: index == list.length - 1,
                );
              },
              separatorBuilder: (context, index) => VerticalDivider(
                width: 1,
                thickness: 0.5,
                color: grayScale[30],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemInCarouselSlider(context,
      {bool isFirst = false, bool isLast = false}) {
    return Container(
      width: 144.w,
      decoration: BoxDecoration(
        borderRadius: isFirst
            ? BorderRadius.only(
                topLeft: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r),
              )
            : isLast
                ? BorderRadius.only(
                    topRight: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  )
                : BorderRadius.zero,
        color: containerBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56.w,
                height: 24.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: GradientBoxBorder(
                    width: 1.w,
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.onSecondary,
                      Theme.of(context).colorScheme.secondary,
                    ]),
                  ),
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  ]),
                ),
                child: Center(
                  child: GradientText(
                    '스터디',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(height: 0),
                    colors: [
                      Theme.of(context).colorScheme.onSecondary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'AI 스터디\n참여',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                '08.23(토) | +1점',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: grayScale[30]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
