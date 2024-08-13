import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pard_app/utilities/text_style.dart';

class TosAgreement extends StatelessWidget {
  final String pipStatement;
  final String pipUrl;
  final String tosStatement;
  final String tosUrl;

  const TosAgreement(this.pipStatement, this.pipUrl, this.tosStatement, this.tosUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      height: 104.h,
      decoration: BoxDecoration(
          color: const Color(0xff2A2A2A),
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          border: Border.all(
            color: grayScale[30]!,
            width: 1,
          )),
      child: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check,
                  size: 14.sp,
                  color: Theme.of(context).colorScheme.surface,
                ),
                SizedBox(
                  width: 4.w,
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(pipUrl));
                    // 'https://pardhgu.notion.site/Pard-APP-fbccc11671d14b4d8012dd999eff7f93?pvs=4'
                  },
                  child: Text(pipStatement,
                      // '개인정보 수집 및 이용 동의(필수)'
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        height: 20 / 14,
                        color: Theme.of(context).colorScheme.surface,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check,
                  size: 14.sp,
                  color: Theme.of(context).colorScheme.surface,
                ),
                SizedBox(
                  width: 4.w,
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(tosUrl));
                    // 'https://pardhgu.notion.site/Pard-APP-18c93fe8a2c648009e17d1ab294a4fa9?pvs=4'
                  },
                  child: Text(
                    tosStatement,
                    // '개인정보 수집 및 이용 동의(필수)'
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      height: 20 / 14,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TosDescription extends StatelessWidget {
  final String string1;
  final String string2;
  final String string3;

  const TosDescription(
    this.string1,
    this.string2,
    this.string3, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      height: 68.h,
      decoration: BoxDecoration(
          color: const Color(0xff2A2A2A),
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          border: Border.all(
            color: grayScale[30]!,
            width: 1,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            string1,
            style: TextStyle(
              fontSize: 14.sp,
              color: grayScale[30],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(
                string2,
                style: headlineSmall,
                colors: const [
                  primaryBlue,
                  primaryPurple,
                ],
              ),
              Text(
                string3,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: grayScale[30],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TosCheckbox extends StatelessWidget {
  final RxBool isAgree;
  final double height;

  const TosCheckbox(
    this.isAgree,
    this.height, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isAgree.value = !(isAgree.value);
      },
      child: isAgree.value
      ? Image.asset('assets/images/checkbox_blue.png', width: 20.w,)
      : Image.asset('assets/images/checkbox_grey.png', width: 20.w)
    );
  }
}


