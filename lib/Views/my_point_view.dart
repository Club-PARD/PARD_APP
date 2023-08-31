<<<<<<< Updated upstream
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/controllers/point_controller.dart';

class MyPointScreen extends StatelessWidget {
  MyPointScreen({super.key});
  final PointController pointController = Get.put(PointController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/component/point_policy_dialog.dart';
import 'package:pard_app/controllers/point_controller.dart';
import 'package:pard_app/model/point_model/point_model.dart';
import 'package:pard_app/model/user_model/user_model.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MyPointView extends StatefulWidget {
  MyPointView({super.key});

  @override
  State<MyPointView> createState() => _MyPointViewState();
}

class _MyPointViewState extends State<MyPointView> {
  final PointController pointController = Get.put(PointController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PointController pointController = Get.put(PointController());
      pointController.fetchAndSortUserPoints();
      pointController.fetchCurrentUserPoints();
    });
  }

  // final PointController pointController = Get.find<PointController>();
  @override
  Widget build(BuildContext context) {
    final GlobalKey buttonKey = GlobalKey();
    int currentUserRank = pointController.getCurrentUserRank();
    int currentUserPartRank = pointController.getCurrentUserPartRank();

    return Scaffold(
      backgroundColor: backgroundColor,
>>>>>>> Stashed changes
      appBar: PardAppBar(
        '내 점수',
      ),
      body: Center(
<<<<<<< Updated upstream
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                pointController.getUserUid();
              },
              child: Text('uid 가져오기 버튼'),
            ),
            ElevatedButton(
              onPressed: () {
                pointController.getUserPoints();
              },
              child: Text('point 가져오기 버튼'),
            ),
            ElevatedButton(
              onPressed: () {
                pointController.getUserPoints();
                pointController.getUserDataAndPoints();
              },
              child: Text('point model 버튼'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('버튼'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('버튼'),
            ),
          ],
=======
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
              Obx(() {
                final RxMap<dynamic, dynamic> rxUserPointsMap =
                    pointController.userPointsMap;

                if (rxUserPointsMap.isEmpty) {
                  return CircularProgressIndicator(); // 로딩 처리
                }

                // RxMap을 Map<UserModel, int>으로 변환
                final Map<UserModel, int> userPointsMap =
                    Map<UserModel, int>.from(rxUserPointsMap);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    rankWithTopIcon(
                      'top1',
                      context,
                      userPointsMap.keys.elementAt(0),
                    ),
                    rankWithTopIcon(
                      'top2',
                      context,
                      userPointsMap.keys.elementAt(1),
                    ),
                    rankWithTopIcon(
                      'top3',
                      context,
                      userPointsMap.keys.elementAt(2),
                    ),
                  ],
                );
              }),
              SizedBox(
                height: 24.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rankWithText(
                        '파트 내 랭킹',
                        context,
                        currentUserRank,
                        currentUserPartRank,
                      ),
                      rankWithText(
                        '전체 랭킹',
                        context,
                        currentUserRank,
                        currentUserPartRank,
                      ),
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
>>>>>>> Stashed changes
        ),
      ),
    );
  }
<<<<<<< Updated upstream
=======

  Widget rankWithTopIcon(String top, context, UserModel user) {
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
              '${user.part} 파트',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: grayScale[30]),
            ),
            Text(
              user.name!,
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

  Widget rankWithText(
      String text, context, int currentUserRank, int currentUserPartRank) {
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
            text,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: grayScale[10]),
          ),
          SizedBox(height: 8.h),
          Text(
            (text == '파트 내 랭킹') ? '$currentUserPartRank위' : '$currentUserRank위',
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
                SizedBox(
                  width: 60.w,
                  child: Column(
                    children: [
                      Text(
                        '파드 포인트',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Obx(
                        () => Text(
                          '+${pointController.points.value}점',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: primaryGreen),
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                  color: grayScale[30],
                ),
                SizedBox(
                  width: 60.w,
                  child: Column(
                    children: [
                      Text(
                        '벌점',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Obx(
                        () => Text(
                          '-${pointController.beePoints.value}점',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: errorRed),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget pointRecordCarouselSlider(context, buttonKey) {
    return Obx(() {
      PointModel? pointModel = pointController.rxPointModel.value;
      List<Map>? sortedPoints = [];

      if (pointModel?.points != null) {
        sortedPoints.addAll(pointModel!.points!);
      }

      if (pointModel?.beePoints != null) {
        sortedPoints.addAll(pointModel!.beePoints!);
      }

      if (sortedPoints.isNotEmpty) {
        // points 리스트를 날짜 기준으로 정렬
        sortedPoints.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

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
                      PointPolicyDialog(context, buttonKey)
                          .showPointPolicyDialog();
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
                  itemCount: sortedPoints.length,
                  itemBuilder: (context, index) {
                    return itemInCarouselSlider(
                      context,
                      isFirst: index == 0,
                      isLast: index == sortedPoints.length - 1,
                      pointData: sortedPoints[index],
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
      } else {
        return Container();
      }
    });
  }

  Widget itemInCarouselSlider(context,
      {bool isFirst = false, bool isLast = false, required Map pointData}) {
    String type = pointData['type'];
    String reason = pointData['reason'];
    String date = formatTimestamp(pointData['timestamp']);
    int digit = pointData['digit'];
    bool isBeePoint = false;

    if (type == '세미나 지각' ||
        type == '세미나 결석' ||
        type == '과제 지각' ||
        type == '과제 결석') {
      isBeePoint = true;
    }

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
                    gradient: isBeePoint
                        ? LinearGradient(colors: [
                            Theme.of(context).colorScheme.error,
                            Theme.of(context).colorScheme.error,
                          ])
                        : LinearGradient(colors: [
                            Theme.of(context).colorScheme.onSecondary,
                            Theme.of(context).colorScheme.secondary,
                          ]),
                  ),
                  gradient: isBeePoint
                      ? LinearGradient(colors: [
                          Theme.of(context).colorScheme.error.withOpacity(0.1),
                          Theme.of(context).colorScheme.error.withOpacity(0.1),
                        ])
                      : LinearGradient(colors: [
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
                  child: GradientText(
                    isBeePoint ? '벌점' : type,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(height: 0),
                    colors: isBeePoint
                        ? [
                            Theme.of(context).colorScheme.error,
                            Theme.of(context).colorScheme.error,
                          ]
                        : [
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
                reason,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                isBeePoint ? '$date | -$digit점' : '$date | +$digit점',
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

String formatTimestamp(Timestamp firestoreTimestamp) {
  DateTime dateTime = firestoreTimestamp.toDate();
  final DateFormat formatter = DateFormat('MM.dd(E)', 'ko_KR');
  return formatter.format(dateTime);
>>>>>>> Stashed changes
}
