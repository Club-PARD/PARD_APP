import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pard_app/component/pard_appbar.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';

class OverallRankingView extends StatelessWidget {
  const OverallRankingView({Key? key}) : super(key: key);

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
              infiniteRankScroll(),
            ],
          ),
        ),
      ),
    );
  }

  Widget infiniteRankScroll() {
    return Container(
      width: double.infinity,
      height: 600.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: containerBackgroundColor,
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: 20,
        itemBuilder: (context, index) {
          if (index < 3) return beforeFourthTile(index);
          return afterFourthTile(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            indent: 8.w,
            endIndent: 8.w,
            height: 0,
            thickness: 1.h,
            color: grayScale[30],
          );
        },
      ),
    );
  }

  Widget beforeFourthTile(int index) {
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
                    '김파트너',
                    style: headlineMedium.copyWith(
                      color: grayScale[10],
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '디자인파트',
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
                '20점',
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

  Widget afterFourthTile(index) {
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
                '김파트너',
                style: headlineMedium.copyWith(
                  color: grayScale[10],
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '디자인파트',
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
            '20점',
            style: titleMedium.copyWith(
              color: grayScale[10],
            ),
          ),
        ],
      ),
    );
  }
}
