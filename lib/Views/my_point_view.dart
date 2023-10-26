import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/component/point_policy_dialog.dart';
import 'package:pard_app/controllers/point_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/model/point_model/point_model.dart';
import 'package:pard_app/model/user_model/user_model.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MyPointView extends StatefulWidget {
  const MyPointView({super.key});

  @override
  State<MyPointView> createState() => _MyPointViewState();
}

class _MyPointViewState extends State<MyPointView> {
  final PointController pointController = Get.put(PointController());
  final UserController userController = Get.put(UserController());
  final formatter = NumberFormat("#,##0.##");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pointController.fetchAndSortUserPoints();
      pointController.fetchCurrentUserPoints();
      pointController.getCurrentUserRank();
      pointController.getCurrentUserPartRank();
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey buttonKey = GlobalKey();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PardAppBar(
        '내 점수',
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                left: 24.0.w,
                right: 24.0.w,
                top: 24.0.h,
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
                      return const CircularProgressIndicator(
                        color: primaryBlue,
                      ); // 로딩 처리
                    }

                    // RxMap을 Map<UserModel, double>으로 변환
                    final Map<UserModel, double> userPointsMap =
                        Map<UserModel, double>.from(rxUserPointsMap);

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
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            rankWithText(
                              '파트 내 랭킹',
                              context,
                              pointController.currentUserRank.value,
                              pointController.currentUserPartRank.value,
                            ),
                            rankWithText(
                              '전체 랭킹',
                              context,
                              pointController.currentUserRank.value,
                              pointController.currentUserPartRank.value,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/overallRanking');
                        },
                        child: Text(
                          '전체랭킹 확인하기',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
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
                        child: SizedBox(
                          height: 24.h,
                          child: Image(
                            image: const AssetImage(
                                'assets/images/checkPointPolicy.png'),
                            width: 102.w,
                            // height: 20.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          ),
          pointRecordCarouselSlider(context, buttonKey),
        ],
      ),
    );
  }

  Widget rankWithTopIcon(String top, context, UserModel user) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        // maxWidth: 92.w,
        maxHeight: 49.h,
      ),
      child: Row(
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
                '${user.part}',
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
      ),
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
            (userController.userInfo.value?.member == '잔잔파도' ||
                    userController.userInfo.value?.member == '운영진')
                ? '- 위'
                : (text == '파트 내 랭킹')
                    ? '$currentUserPartRank위'
                    : '$currentUserRank위',
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
          constraints: BoxConstraints(maxHeight: 92.h),
          width: double.infinity,
          height: 92.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: containerBackgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 54.5.w,
              right: 54.5.w,
              top: 24.h,
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
                      Obx(() {
                        PointModel? pointModel =
                            pointController.rxPointModel.value;

                        if (pointModel == null) {
                          return const CircularProgressIndicator(
                            color: primaryBlue,
                          ); // 로딩 처리
                        }
                        return Text(
                          (userController.userInfo.value?.member == '잔잔파도' ||
                                  userController.userInfo.value?.member ==
                                      '운영진')
                              ? '-'
                              : (pointModel.currentPoints == 0)
                                  ? '${formatter.format(pointModel.currentPoints)}점'
                                  : '+${formatter.format(pointModel.currentPoints)}점',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: primaryGreen),
                        );
                      }),
                    ],
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                  endIndent: 24.h,
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
                      Obx(() {
                        PointModel? pointModel =
                            pointController.rxPointModel.value;
                        if (pointModel == null) {
                          return const CircularProgressIndicator(
                            color: primaryBlue,
                          ); // 로딩 처리
                        }
                        return Text(
                          (userController.userInfo.value?.member == '잔잔파도' ||
                                  userController.userInfo.value?.member ==
                                      '운영진')
                              ? '-'
                              : '${formatter.format(pointModel.currentBeePoints)}점',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: errorRed),
                        );
                      }),
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
              Container(
                constraints: BoxConstraints(
                  minHeight: 136,
                ),
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
    double digit = pointData['digit'].toDouble();
    String formattedDigit = formatter.format(digit);
    bool isBeePoint = false;

    if (type == '세미나 지각' ||
        type == '세미나 결석' ||
        type == '과제 지각' ||
        type == '과제 결석') {
      isBeePoint = true;
    }

    return Padding(
      padding: isFirst
          ? EdgeInsets.only(left: 24.w)
          : isLast
              ? EdgeInsets.only(right: 24.w)
              : EdgeInsets.zero,
      child: Container(
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
                            Theme.of(context)
                                .colorScheme
                                .error
                                .withOpacity(0.1),
                            Theme.of(context)
                                .colorScheme
                                .error
                                .withOpacity(0.1),
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
                SizedBox(
                  width: 100.w,
                  child: AutoSizeText(
                    reason,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 2,
                    minFontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  isBeePoint
                      ? '$date | $formattedDigit점'
                      : '$date | +$formattedDigit점',
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
      ),
    );
  }
}

String formatTimestamp(Timestamp firestoreTimestamp) {
  DateTime dateTime = firestoreTimestamp.toDate();
  final DateFormat formatter = DateFormat('MM.dd(E)', 'ko_KR');
  return formatter.format(dateTime);
}
