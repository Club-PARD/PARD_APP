import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/controllers/point_controller.dart';
import 'package:pard_app/model/user_model/user_model.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';

class OverallRankingView extends StatelessWidget {
  OverallRankingView({Key? key}) : super(key: key);
  final PointController pointController = Get.put(PointController());
  final formatter = NumberFormat("#,##0.##");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PardAppBar(
        '전체 랭킹',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Column(
            children: [
              SizedBox(
                width: 180.w,
                height: 36.h,
                child: const Image(
                  image: AssetImage('assets/images/pardnership.png'),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              infiniteRankScroll(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget infiniteRankScroll(context) {
    return Obx(
      () {
        final RxMap<dynamic, dynamic> rxUserPointsMap =
            pointController.userPointsMap;

        if (rxUserPointsMap.isEmpty) {
          return CircularProgressIndicator(); // 로딩 처리
        }

        // RxMap을 Map<UserModel, int>으로 변환
        final Map<UserModel, double> userPointsMap =
            Map<UserModel, double>.from(rxUserPointsMap);

        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          width: double.infinity,
          height: userPointsMap.length * 63.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: containerBackgroundColor,
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: userPointsMap.length * 2 - 1,
            itemBuilder: (context, index) {
              if (index.isEven) {
                UserModel user = userPointsMap.keys.elementAt(index ~/ 2);
                double points = userPointsMap.values.elementAt(index ~/ 2);
                String formattedPoints = formatter.format(points);

                if (index ~/ 2 < 3) {
                  return beforeFourthTile(index ~/ 2, user, formattedPoints);
                } else {
                  return afterFourthTile(index ~/ 2, user, formattedPoints);
                }
              } else {
                return Divider(
                  indent: 8.w,
                  endIndent: 8.w,
                  height: 0,
                  thickness: 1.h,
                  color: grayScale[30],
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget beforeFourthTile(int index, UserModel user, String points) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0.w, 8.h, 16.0.w, 16.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image(
            image: AssetImage('assets/images/rank${index + 1}.png'),
            width: 40.w,
            height: 38.h,
          ),
          SizedBox(width: 8.w),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    user.name!,
                    style: headlineMedium.copyWith(
                      color: grayScale[10],
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${user.part}파트',
                    style: titleSmall.copyWith(
                      color: grayScale[30],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
            ],
          ),
          Expanded(
            child: SizedBox(),
          ),
          Column(
            children: [
              Text(
                '$points점',
                style: titleMedium.copyWith(
                  color: grayScale[10],
                ),
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ],
      ),
    );
  }

  Widget afterFourthTile(index, UserModel user, String points) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 22.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 24.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                width: 1.w,
                color: grayScale[30]!,
              ),
              color: grayScale[30]!.withOpacity(0.1),
            ),
            child: Text(
              '${index + 1}등',
              style: titleMedium.copyWith(
                height: 0,
                color: grayScale[30],
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Row(
            children: [
              Text(
                user.name!,
                style: headlineMedium.copyWith(
                  color: grayScale[10],
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '${user.part}파트',
                style: titleSmall.copyWith(
                  color: grayScale[30],
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(),
          ),
          Text(
            '$points점',
            style: titleMedium.copyWith(
              color: grayScale[10],
            ),
          ),
        ],
      ),
    );
  }
}
