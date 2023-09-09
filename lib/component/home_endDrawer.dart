import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pard_app/Views/mypage.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeEndDrawer extends StatefulWidget {
  const HomeEndDrawer({super.key});

  @override
  State<HomeEndDrawer> createState() => _HomeEndDrawerState();
}

void launchInstaURL() async {
  final Uri pardInstaUrl =
      Uri.parse('https://www.instagram.com/official_pard_/');
  try {
    await launchUrl(pardInstaUrl);
  } catch (e) {
    print("Could not launch $pardInstaUrl: $e");
  }
}

void launchPardWebURL() async {
  final Uri pardWebUrl = Uri.parse('https://we-pard.com/');
  try {
    await launchUrl(pardWebUrl);
  } catch (e) {
    print("Could not launch $pardWebUrl: $e");
  }
}

void launchNotion() async {
  final Uri pardNotion = Uri.parse(
      'https://pard-notice.oopy.io/');
  try {
    await launchUrl(pardNotion);
  } catch (e) {
    print("Could not launch $pardNotion: $e");
  }
}

void launchSeminar() async {
  final Uri SeminarFeedback = Uri.parse(
      'https://docs.google.com/forms/d/e/1FAIpQLSdvXT0iaH6dXNdzsSf-eZuLcgcrTD5c8Upw3LfTKitixUp3uw/viewform?usp=sf_link');
  try {
    await launchUrl(SeminarFeedback);
  } catch (e) {
    print("Could not launch $SeminarFeedback: $e");
  }
}

void launchPMNotion() async {
  final Uri pardPMNotion = Uri.parse(
      'https://pard-notice.oopy.io/pm');
  try {
    await launchUrl(pardPMNotion);
  } catch (e) {
    print("Could not launch $pardPMNotion: $e");
  }
}

void launchDesignNotion() async {
  final Uri pardDesignNotion = Uri.parse(
      'https://pard-notice.oopy.io/design');
  try {
    await launchUrl(pardDesignNotion);
  } catch (e) {
    print("Could not launch $pardDesignNotion: $e");
  }
}

void launchWebNotion() async {
  final Uri pardWebNotion =
      Uri.parse('https://pard-notice.oopy.io/web');
  try {
    await launchUrl(pardWebNotion);
  } catch (e) {
    print("Could not launch $pardWebNotion: $e");
  }
}

void launchAppNotion() async {
  final Uri pardAppNotionUrl = Uri.parse(
      'https://pard-notice.oopy.io/ios');
  try {
    await launchUrl(pardAppNotionUrl);
  } catch (e) {
    print("Could not launch $pardAppNotionUrl: $e");
  }
}

void launchServerNotion() async {
  final Uri pardServerNotionUrl =
      Uri.parse('https://pardhgu.notion.site/c32944fa18d042caa150a1ba1de306bd');
  try {
    await launchUrl(pardServerNotionUrl);
  } catch (e) {
    print("Could not launch $pardServerNotionUrl: $e");
  }
}

class _HomeEndDrawerState extends State<HomeEndDrawer> {
  bool _areItemsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      color: const Color(0XFF2A2A2A),
      child: Drawer(
        backgroundColor: const Color(0XFF2A2A2A),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.only(left: 24.w),
              decoration: const BoxDecoration(
                color: Color(0XFF2A2A2A),
              ),
              child: GradientText(
                '공지 및 자료',
                style: headlineMedium,
                colors: const [
                  primaryBlue,
                  primaryPurple,
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Divider(
              thickness: 0.5,
              height: 0,
              color: grayScale[30],
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _areItemsVisible = !_areItemsVisible;
                });
              },
              
              child: Container(
                height: 60.h,
                padding: EdgeInsets.only(left: 24.w),
                color: _areItemsVisible ? const Color(0xFF3D3D3D) : const Color(0XFF2A2A2A),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/Notion.png',
                          width: 22.w,
                          height: 22.h,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text('PARD 노션', style: headlineSmall),
                      ],
                    ),
                    IconButton(
                      splashColor: Colors.transparent,
 highlightColor: Colors.transparent,
                      icon: Icon(
                        _areItemsVisible
                            ? Icons.keyboard_arrow_down_sharp
                            : Icons.keyboard_arrow_right_sharp,
                        size: 16.w,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _areItemsVisible = !_areItemsVisible;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (_areItemsVisible) ...[
              ListTile(
                title: InkWell(
                    child: Row(
                  children: [
                    SizedBox(
                      width: 22.w,
                    ),
                    Text('전체',
                        style: headlineSmall.copyWith(color: grayScale[30])),
                  ],
                )),
                onTap: () {
                  launchNotion();
                },
              ),
              ListTile(
                title: InkWell(
                    child: Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    Text('기획 파트',
                        style: headlineSmall.copyWith(color: grayScale[30])),
                  ],
                )),
                onTap: () {
                  launchPMNotion();
                },
              ),
              ListTile(
                title: InkWell(
                    child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    Text('디자인 파트',
                        style: headlineSmall.copyWith(color: grayScale[30])),
                  ],
                )),
                onTap: () {
                  launchDesignNotion();
                },
              ),
              ListTile(
                title: InkWell(
                    child: Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    Text('서버 파트',
                        style: headlineSmall.copyWith(color: grayScale[30])),
                  ],
                )),
                onTap: () {
                  launchServerNotion();
                },
              ),
              ListTile(
                title: InkWell(
                    child: Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    Text('웹 파트',
                        style: headlineSmall.copyWith(color: grayScale[30])),
                  ],
                )),
                onTap: () {
                  launchWebNotion();
                },
              ),
              ListTile(
                title: InkWell(
                    child: Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    Text('iOS 파트',
                        style: headlineSmall.copyWith(color: grayScale[30])),
                  ],
                )),
                onTap: () {
                  launchAppNotion();
                },
              )
            ],
            Divider(
              thickness: 0.5,
              height: 0,
              color: grayScale[30],
            ),
            SizedBox(
              height: 32.h,
            ),
            InkWell(
              onTap: () {
                launchFeedback();
              },
              child: Container(
                padding: EdgeInsets.only(left: 20.w),
                decoration: const BoxDecoration(
                  color: Color(0XFF2A2A2A),
                ),
                child: GradientText(
                  '피드백',
                  style: headlineMedium,
                  colors: const [
                    primaryBlue,
                    primaryPurple,
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Divider(
              thickness: 0.5,
              height: 0,
              color: grayScale[30],
            ),
            InkWell(
              onTap: launchSeminar,
              child: SizedBox(
                width: 200.w,
                height: 60.h,
                child: Row(
                  children: [
                    SizedBox(
                      width: 24.w,
                    ),
                    Image.asset(
                      'assets/images/googleSheet.png',
                      width: 13.w,
                      height: 18.h,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text('세미나 구글폼', style: headlineSmall)
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              height: 0,
              color: grayScale[30],
            ),
            SizedBox(height: 32.h),
            Container(
              padding: EdgeInsets.only(left: 20.w),
              decoration: const BoxDecoration(
                color: Color(0XFF2A2A2A),
              ),
              child: GradientText(
                '공식 채널',
                style: headlineMedium,
                colors: const [
                  primaryBlue,
                  primaryPurple,
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Divider(
              thickness: 0.5,
              height: 0,
              color: grayScale[30],
            ),
            SizedBox(
              width: 200.w,
              height: 150.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 60.h,
                    child: InkWell(
                      onTap: launchInstaURL,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24.w,
                          ),
                          Image.asset(
                            "assets/images/ig.png",
                            width: 16.w,
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text('인스타그램', style: headlineSmall)
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    height: 0,
                    color: grayScale[30],
                  ),
                  SizedBox(
                    height: 60.h,
                    child: InkWell(
                      onTap: launchPardWebURL,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 24.w,
                          ),
                          Image.asset("assets/images/logo.png",
                              width: 43.7.w, height: 9.h),
                          SizedBox(width: 8.w),
                          Text(
                            '웹사이트',
                            style: headlineSmall,
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    height: 0,
                    color: grayScale[30],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
