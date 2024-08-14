import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pard_app/Views/mypage.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/component/point_policy_dialog.dart';
import 'package:pard_app/controllers/point_controller.dart';
import 'package:pard_app/controllers/spring_point_controller.dart';
import 'package:pard_app/controllers/spring_user_controller.dart';
import 'package:pard_app/controllers/user_controller.dart';
import 'package:pard_app/model/point_model/point_model.dart';
import 'package:pard_app/model/point_model/point_reason.dart';
import 'package:pard_app/model/point_model/rank_point_model.dart';
import 'package:pard_app/model/user_model/user_model.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MyPointView extends StatefulWidget {
  const MyPointView({super.key});

  @override
  State<MyPointView> createState() => _MyPointViewState();
}

class _MyPointViewState extends State<MyPointView> {
  final PointController pointController = Get.find<PointController>();
  final UserController userController = Get.put(UserController());
  final SpringUserController springUserController = Get.put(SpringUserController());
  final SpringPointController springPointController = Get.put(SpringPointController());
  final formatter = NumberFormat("#,##0.##");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('---------------my point view()');
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey buttonKey = GlobalKey();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const PardAppBar(
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
                    if (springPointController.isLoading.value) {
                      return const CircularProgressIndicator(
                        color: primaryBlue,
                      ); // 로딩 처리
                    }

                    List<RankPointModel> top3Ranks =
                        springPointController.top3RankList.toList();

                    if (top3Ranks.isEmpty) {
                      return const CircularProgressIndicator(
                        color: primaryBlue,
                      ); // 로딩 처리
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        rankWithTopIcon(
                          'top1',
                          context,
                          top3Ranks[0],
                        ),
                        rankWithTopIcon(
                          'top2',
                          context,
                          top3Ranks[1],
                        ),
                        rankWithTopIcon(
                          'top3',
                          context,
                          top3Ranks[2],
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
                        () {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              rankWithText(
                                '파트 내 랭킹',
                                context,
                                springPointController.rxUserPoint.value?.totalRanking ?? 0,
                                springPointController.rxUserPoint.value?.partRanking ?? 0,
                              ),
                              rankWithText(
                                '전체 랭킹',
                                context,
                                springPointController.rxUserPoint.value?.totalRanking ?? 0,
                                springPointController.rxUserPoint.value?.partRanking ?? 0,
                              ),
                            ],
                          );
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/overallRanking');
                        },
                        child: Text(
                          '전체 랭킹 확인하기',
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

  Widget rankWithTopIcon(String top, context, RankPointModel user) {
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
                user.part,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: grayScale[30]),
              ),
              Text(
                user.name,
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
          Obx(
            () {
              return Text(
                (getRoleString(springUserController.userInfo.value?.role )== '잔잔파도' ||
                getRoleString(springUserController.userInfo.value?.role ) == '운영진')
                    ? '- 위'
                    : (text == '파트 내 랭킹')
                        ? '$currentUserPartRank위'
                        : '$currentUserRank위',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: grayScale[10]),
              );
            },
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
                        if (springUserController.userInfo.value?.totalBonus == null) {
                          return const CircularProgressIndicator(
                            color: primaryBlue,
                          ); // 로딩 처리
                        }
                        return Text(
                          (getRoleString(springUserController.userInfo.value?.role) == '잔잔파도' ||
                            getRoleString(springUserController.userInfo.value?.role) == '운영진')
                              ? '-'
                              : (springUserController.userInfo.value?.totalBonus == 0)
                                  ? '${formatter.format(springUserController.userInfo.value?.totalBonus)}점'
                                  : '+${formatter.format(springUserController.userInfo.value?.totalBonus)}점',
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
                        if (springUserController.userInfo.value?.totalMinus == null) {
                          return const CircularProgressIndicator(
                            color: primaryBlue,
                          ); // 로딩 처리
                        }
                        return Text(
                          (getRoleString(springUserController.userInfo.value?.role) == '잔잔파도' ||
                            getRoleString(springUserController.userInfo.value?.role) == '운영진')
                              ? '-'
                              : (springUserController.userInfo.value?.totalMinus == 0)
                                  ? '${formatter.format(springUserController.userInfo.value?.totalMinus)}점'
                                  : '+${formatter.format(springUserController.userInfo.value?.totalMinus)}점',
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
      if (springPointController.isLoading.value) {
        return const Center(child: CircularProgressIndicator(color: primaryBlue));
      }

      List<ReasonBonus> sortedPoints = springPointController.pointReasonList.toList();

      print(sortedPoints);

      if (sortedPoints.isNotEmpty) {
        sortedPoints.sort((a, b) => b.createAt.compareTo(a.createAt));

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(
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
        return 
Padding(
  padding: EdgeInsets.symmetric(horizontal: 27.25.w), // Apply padding to the parent
  child: Container(
    constraints: BoxConstraints(maxHeight: 92.h),
    width: double.infinity,
    height: 92.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: containerBackgroundColor,
    ),
    child: Center(
      child: Text(
        '파드에 등록되지 않은 이메일이거나\n파드너십 및 벌점 목록이 비어있습니다.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
        maxLines: 2, 
        overflow: TextOverflow.ellipsis, 
      ),
    ),
  ),
);


      }
    });
  }

  Widget itemInCarouselSlider(BuildContext context,
      {bool isFirst = false, bool isLast = false, required ReasonBonus pointData}) {
    String type = pointData.reason;
    String reason = pointData.detail;
    String date = formatTimestamp(pointData.createAt);
    double digit = pointData.point.toDouble();
    String formattedDigit = formatter.format(digit);
    bool isBonus = pointData.isBonus;

    print(isBonus);

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
                      gradient: isBonus
                          ? LinearGradient(colors: [
                              Theme.of(context).colorScheme.onSecondary,
                              Theme.of(context).colorScheme.secondary,
                            ]) :
                            LinearGradient(colors: [
                              Theme.of(context).colorScheme.error,
                              Theme.of(context).colorScheme.error,
                            ])
                    ),
                    gradient: isBonus
                        ?  LinearGradient(colors: [
                            Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withOpacity(0.1),
                            Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.1),
                          ]) : 
                          LinearGradient(colors: [
                            Theme.of(context)
                                .colorScheme
                                .error
                                .withOpacity(0.1),
                            Theme.of(context)
                                .colorScheme
                                .error
                                .withOpacity(0.1),
                          ])
                  ),
                  child: Center(
                    child: GradientText(
                      isBonus ? type : '벌점' ,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(height: 0),
                      colors: isBonus
                          ?  [
                              Theme.of(context).colorScheme.onSecondary,
                              Theme.of(context).colorScheme.secondary,
                            ] : [
                              Theme.of(context).colorScheme.error,
                              Theme.of(context).colorScheme.error,
                            ]
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
                  isBonus
                      ? '$date | +$formattedDigit점' : '$date | $formattedDigit점',
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

  String formatTimestamp(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MM.dd(E)', 'ko_KR');
    return formatter.format(dateTime);
  }
}
