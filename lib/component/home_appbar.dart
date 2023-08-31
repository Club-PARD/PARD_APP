import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
<<<<<<< Updated upstream
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';
=======
import 'package:pard_app/Views/mypage.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'package:url_launcher/url_launcher.dart';
>>>>>>> Stashed changes

class HomeBar extends StatefulWidget {
  const HomeBar({super.key});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

<<<<<<< Updated upstream
=======
void launchInstaURL() async {
    final Uri pardInstaUrl = Uri.parse('https://www.instagram.com/official_pard_/');
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
    final Uri pardNotion = Uri.parse('https://pardhgu.notion.site/PARD-1-a26b1363b86a4740936a92e254876205');
    try {
  await launchUrl(pardNotion);
} catch (e) {
  print("Could not launch $pardNotion: $e");
}
  }

  void launchSeminar() async {
    final Uri SeminarFeedback = Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSdvXT0iaH6dXNdzsSf-eZuLcgcrTD5c8Upw3LfTKitixUp3uw/viewform?usp=sf_link');
    try {
  await launchUrl(SeminarFeedback);
} catch (e) {
  print("Could not launch $SeminarFeedback: $e");
}
  }

  void launchPMNotion() async {
    final Uri pardPMNotion = Uri.parse('https://mercurial-nymphea-2ab.notion.site/PARD-1-3ea9e2fa106e4323a539e9a377c2d106');
    try {
  await launchUrl(pardPMNotion);
} catch (e) {
  print("Could not launch $pardPMNotion: $e");
}
  }

  void launchDesignNotion() async {
    final Uri pardDesignNotion = Uri.parse('https://pardhgu.notion.site/PARD-1-a3ea2c327c944fac8651af8143b5ec0c');
    try {
  await launchUrl(pardDesignNotion);
} catch (e) {
  print("Could not launch $pardDesignNotion: $e");
}
  }

  void launchWebNotion() async {
    final Uri pardWebNotion = Uri.parse('https://pardhgu.notion.site/bb6cc47609c844efab77c8910338dca2');
    try {
  await launchUrl(pardWebNotion);
} catch (e) {
  print("Could not launch $pardWebNotion: $e");
}
  }

  void launchAppNotion() async {
    final Uri pardAppNotionUrl = Uri.parse('https://pardhgu.notion.site/PARD-1-79c6436b9f9243b3a4b5e1ef5e04ff23');
    try {
  await launchUrl(pardAppNotionUrl);
} catch (e) {
  print("Could not launch $pardAppNotionUrl: $e");
}
  }

  void launchServerNotion() async {
    final Uri pardServerNotionUrl = Uri.parse('https://pardhgu.notion.site/c32944fa18d042caa150a1ba1de306bd');
    try {
  await launchUrl(pardServerNotionUrl);
} catch (e) {
  print("Could not launch $pardServerNotionUrl: $e");
}
  }

>>>>>>> Stashed changes
class _HomeBarState extends State<HomeBar> {
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
<<<<<<< Updated upstream
            SizedBox(height: 64.h),
=======
            SizedBox(height: 20.h),
>>>>>>> Stashed changes
            Container(
              padding: EdgeInsets.only(left: 24.w),
              decoration: const BoxDecoration(
                color: Color(0XFF2A2A2A),
              ),
              child: Text('공지 및 자료', style: headlineMedium.copyWith(color: const Color.fromRGBO(82, 98, 245, 1))),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _areItemsVisible = !_areItemsVisible;
                });
              },
              child: Container(
                padding:EdgeInsets.only(left: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/Notion.png',
                      width: 22.w,
                      height: 22.h,
                    ),
                    Text('PARD 노션',
                        style: headlineSmall),
                    SizedBox(
                      width: 40.w
                    ),
                    IconButton(
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
<<<<<<< Updated upstream
                  title: Text('전체', style: headlineSmall.copyWith(color:grayScale[30])),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title:  Text('기획 파트', style: headlineSmall.copyWith(color:grayScale[30])),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title:  Text('다저안 파트', style: headlineSmall.copyWith(color:grayScale[30])),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title:  Text('서버 파트', style:headlineSmall.copyWith(color:grayScale[30])),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title:  Text('웹 파트', style: headlineSmall.copyWith(color:grayScale[30])),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title:  Text('iOS 파트', style: headlineSmall.copyWith(color:grayScale[30])),
                  onTap: () {
                    Navigator.pop(context);
=======
                  title: InkWell( child: Row(
                    children: [
                      SizedBox(width: 22.w,),
                      Text('전체', style: headlineSmall.copyWith(color:grayScale[30])),
                    ],
                  )),
                  onTap: () {
                    launchNotion();
                  },
                ),
                ListTile(
                  title:  InkWell(child: Row(
                    children: [
                      SizedBox(width: 20.w,),
                      Text('기획 파트', style: headlineSmall.copyWith(color:grayScale[30])),
                    ],
                  )),
                  onTap: () {
                    launchPMNotion();
                  },
                ),
                ListTile(
                  title:  InkWell(child: Row(
                    children: [
                      SizedBox(width: 20.w),
                      Text('디자인 파트', style: headlineSmall.copyWith(color:grayScale[30])),
                    ],
                  )),
                  onTap: () {
                    launchDesignNotion();
                  },
                ),
                ListTile(
                  title:  InkWell(child: Row(
                    children: [
                      SizedBox(width: 20.w,),
                      Text('서버 파트', style:headlineSmall.copyWith(color:grayScale[30])),
                    ],
                  )),
                  onTap: () {
                    launchServerNotion();
                  },
                ),
                ListTile(
                  title:  InkWell(child: Row(
                    children: [
                      SizedBox(width: 20.w,),
                      Text('웹 파트', style: headlineSmall.copyWith(color:grayScale[30])),
                    ],
                  )),
                  onTap: () {
                    launchWebNotion();
                  },
                ),
                ListTile(
                  title:  InkWell(child: Row(
                    children: [
                      SizedBox(width: 20.w,),
                      Text('iOS 파트', style: headlineSmall.copyWith(color:grayScale[30])),
                    ],
                  )),
                  onTap: () {
                    launchAppNotion();
>>>>>>> Stashed changes
                  },
                )
            ],
            SizedBox(height: 32.h,),
<<<<<<< Updated upstream
            Container(
              padding: EdgeInsets.only(left: 20.w),
              decoration: const BoxDecoration(
                color: Color(0XFF2A2A2A),
              ),
              child:  Text('피드백', style: headlineMedium.copyWith(color: const Color.fromRGBO(82, 98, 245, 1))),
            ),
            SizedBox(
              width: 200.w,
              height: 60.h,
             
              child: Row(
                children: [
                  SizedBox(width: 24.w,),
                  Image.asset('assets/images/googleSheet.png', width: 13.w,height: 18.h,),
                  SizedBox(width: 8.w,),
                   Text('세미나 구글폼',style: headlineSmall)
                ],
=======
            InkWell(
              onTap: () {
                launchFeedback();
              },
              child: Container(
                padding: EdgeInsets.only(left: 20.w),
                decoration: const BoxDecoration(
                  color: Color(0XFF2A2A2A),
                ),
                child:  Text('피드백', style: headlineMedium.copyWith(color: const Color.fromRGBO(82, 98, 245, 1))),
              ),
            ),
            InkWell(
              onTap: launchSeminar,
              child: SizedBox(
                width: 200.w,
                height: 60.h,
               
                child: Row(
                  children: [
                    SizedBox(width: 24.w,),
                    Image.asset('assets/images/googleSheet.png', width: 13.w,height: 18.h,),
                    SizedBox(width: 8.w,),
                     Text('세미나 구글폼',style: headlineSmall)
                  ],
                ),
>>>>>>> Stashed changes
              ),
            ),
            SizedBox(height: 32.h),
            Container(
              padding: EdgeInsets.only(left: 20.w),
              decoration: const BoxDecoration(
                color: Color(0XFF2A2A2A),
              ),
              child: Text('공식 채널', style: headlineMedium.copyWith(color: const Color.fromRGBO(82, 98, 245, 1))),
            ),
            SizedBox(
              width: 200.w,
              height: 150.h,
              
              child: Column(
                children: [
                  SizedBox(
                    height: 60.h,
<<<<<<< Updated upstream
                    child: Row(
                      children: [
                        SizedBox(width: 24.w,),
                        Image.asset("assets/images/ig.png", width: 16.w,height: 16.h,),
                        SizedBox(width: 8.w,),
                        Text('인스타그램',style: headlineSmall)
                      ],
=======
                    child: InkWell(
                      onTap: launchInstaURL,
                      child: Row(
                        children: [
                          SizedBox(width: 24.w,),
                          Image.asset("assets/images/ig.png", width: 16.w,height: 16.h,),
                          SizedBox(width: 8.w,),
                          Text('인스타그램',style: headlineSmall)
                        ],
                      ),
>>>>>>> Stashed changes
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  SizedBox(
                    height: 60.h,
<<<<<<< Updated upstream
                    child: Row(
                      children: [
                         SizedBox(width: 24.w,),
                        Image.asset("assets/images/logo.png", width: 43.7.w,height: 9.h),
                         SizedBox(width: 8.w),
                         Text('웹사이트',style: headlineSmall,)
                      ],
=======
                    child: InkWell(
                      onTap: launchPardWebURL,
                      child: Row(
                        children: [
                           SizedBox(width: 24.w,),
                          Image.asset("assets/images/logo.png", width: 43.7.w,height: 9.h),
                           SizedBox(width: 8.w),
                           Text('웹사이트',style: headlineSmall,)
                        ],
                      ),
>>>>>>> Stashed changes
                    ),
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