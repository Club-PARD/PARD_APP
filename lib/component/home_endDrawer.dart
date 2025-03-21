import 'package:cloud_firestore/cloud_firestore.dart';
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

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
// 파베에 있는 insta 필드에 있는 url값 가져온다
Future<void> fetchInstaUrl() async {
  try {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('url').get();

    for (var document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      if (data.containsKey('instagram')) {
        String url = data['instagram'];
        if (url.isNotEmpty) {
          final Uri instaUrl = Uri.parse(url);
          try {
            await launchUrl(instaUrl);
          } catch (e) {}
          return;
        }
      }
    }
    print('파베에서 url 값 찾을 수 없음~~');
  } catch (e) {
    print('Error fetching URL: $e');
  }
}

Future<void> fetchPardWebUrl() async {
  try {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('url').get();

    for (var document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      if (data.containsKey('pardweb')) {
        String url = data['pardweb'];
        if (url.isNotEmpty) {
          final Uri pardWebUrl = Uri.parse(url);
          try {
            await launchUrl(pardWebUrl);
          } catch (e) {}
          return;
        }
      }
    }
    print('파베에서 url 값 찾을 수 없음~~');
  } catch (e) {
    print('Error fetching URL: $e');
  }
}

Future<void> fetchPardNotion() async {
  try {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('url').get();

    for (var document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      if (data.containsKey('notion')) {
        String url = data['notion'];
        if (url.isNotEmpty) {
          final Uri pardNotionUrl = Uri.parse(url);
          try {
            await launchUrl(pardNotionUrl);
          } catch (e) {}
          return;
        }
      }
    }
    print('파베에서 url 값 찾을 수 없음~~');
  } catch (e) {
    print('Error fetching URL: $e');
  }
}

Future<void> fetchSeminarFeedback() async {
  try {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('url').get();

    for (var document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      if (data.containsKey('피드백')) {
        String url = data['피드백'];
        if (url.isNotEmpty) {
          final Uri pardSeminarFeedbackUrl = Uri.parse(url);
          try {
            await launchUrl(pardSeminarFeedbackUrl);
          } catch (e) {}
          return;
        }
      }
    }
    print('파베에서 url 값 찾을 수 없음~~');
  } catch (e) {
    print('Error fetching URL: $e');
  }
}

Future<void> fetchPMNotion() async {
  try {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('url').get();

    for (var document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      if (data.containsKey('기획')) {
        String url = data['기획'];
        if (url.isNotEmpty) {
          final Uri pardPMUrl = Uri.parse(url);
          try {
            await launchUrl(pardPMUrl);
          } catch (e) {}
          return;
        }
      }
    }
    print('파베에서 url 값 찾을 수 없음~~');
  } catch (e) {
    print('Error fetching URL: $e');
  }
}

Future<void> fetchDesignNotion() async {
  try {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('url').get();

    for (var document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      if (data.containsKey('디자인')) {
        String url = data['디자인'];
        if (url.isNotEmpty) {
          final Uri pardDesignUrl = Uri.parse(url);
          try {
            await launchUrl(pardDesignUrl);
          } catch (e) {}
          return;
        }
      }
    }
    print('파베에서 url 값 찾을 수 없음~~');
  } catch (e) {
    print('Error fetching URL: $e');
  }
}

Future<void> fetchWebNotion() async {
  try {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('url').get();

    for (var document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      if (data.containsKey('웹')) {
        String url = data['웹'];
        if (url.isNotEmpty) {
          final Uri pardWebPartUrl = Uri.parse(url);
          try {
            await launchUrl(pardWebPartUrl);
          } catch (e) {}
          return;
        }
      }
    }
    print('파베에서 url 값 찾을 수 없음~~');
  } catch (e) {
    print('Error fetching URL: $e');
  }
}

Future<void> fetchiOSNotion() async {
  try {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('url').get();

    for (var document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      if (data.containsKey('iOS')) {
        String url = data['iOS'];
        if (url.isNotEmpty) {
          final Uri pardiOSNotionUrl = Uri.parse(url);
          try {
            await launchUrl(pardiOSNotionUrl);
          } catch (e) {}
          return;
        }
      }
    }
    print('파베에서 url 값 찾을 수 없음~~');
  } catch (e) {
    print('Error fetching URL: $e');
  }
}

Future<void> fetchBackendNotion() async {
  try {
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('url').get();

    for (var document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>;
      if (data.containsKey('서버')) {
        String url = data['서버'];
        if (url.isNotEmpty) {
          final Uri pardBackendNotionUrl = Uri.parse(url);
          try {
            await launchUrl(pardBackendNotionUrl);
          } catch (e) {}
          return;
        }
      }
    }
    print('파베에서 url 값 찾을 수 없음~~');
  } catch (e) {
    print('Error fetching URL: $e');
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
              decoration: const BoxDecoration(color: Color(0XFF2A2A2A)),
              child: GradientText(
                '공지 및 자료',
                style: headlineMedium,
                colors: const [primaryBlue, primaryPurple],
              ),
            ),
            SizedBox(height: 8.h),
            Divider(thickness: 0.5, height: 0, color: grayScale[30]),
            GestureDetector(
              onTap: () {
                setState(() {
                  _areItemsVisible = !_areItemsVisible;
                });
              },

              child: Container(
                height: 60.h,
                padding: EdgeInsets.only(left: 24.w),
                color:
                    _areItemsVisible
                        ? const Color(0xFF3D3D3D)
                        : const Color(0XFF2A2A2A),
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
                        SizedBox(width: 4.w),
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
                      SizedBox(width: 22.w),
                      Text(
                        '전체',
                        style: headlineSmall.copyWith(color: grayScale[30]),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  fetchPardNotion();
                },
              ),
              ListTile(
                title: InkWell(
                  child: Row(
                    children: [
                      SizedBox(width: 20.w),
                      Text(
                        '기획 파트',
                        style: headlineSmall.copyWith(color: grayScale[30]),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  fetchPMNotion();
                },
              ),
              ListTile(
                title: InkWell(
                  child: Row(
                    children: [
                      SizedBox(width: 20.w),
                      Text(
                        '디자인 파트',
                        style: headlineSmall.copyWith(color: grayScale[30]),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  fetchDesignNotion();
                },
              ),
              ListTile(
                title: InkWell(
                  child: Row(
                    children: [
                      SizedBox(width: 20.w),
                      Text(
                        '서버 파트',
                        style: headlineSmall.copyWith(color: grayScale[30]),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  fetchBackendNotion();
                },
              ),
              ListTile(
                title: InkWell(
                  child: Row(
                    children: [
                      SizedBox(width: 20.w),
                      Text(
                        '웹 파트',
                        style: headlineSmall.copyWith(color: grayScale[30]),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  fetchWebNotion();
                },
              ),
              ListTile(
                title: InkWell(
                  child: Row(
                    children: [
                      SizedBox(width: 20.w),
                      Text(
                        'iOS 파트',
                        style: headlineSmall.copyWith(color: grayScale[30]),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  fetchiOSNotion();
                },
              ),
            ],
            Divider(thickness: 0.5, height: 0, color: grayScale[30]),
            SizedBox(height: 32.h),
            InkWell(
              onTap: () {
                launchFeedback();
              },
              child: Container(
                padding: EdgeInsets.only(left: 20.w),
                decoration: const BoxDecoration(color: Color(0XFF2A2A2A)),
                child: GradientText(
                  '피드백',
                  style: headlineMedium,
                  colors: const [primaryBlue, primaryPurple],
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Divider(thickness: 0.5, height: 0, color: grayScale[30]),
            InkWell(
              onTap: fetchSeminarFeedback,
              child: SizedBox(
                width: 200.w,
                height: 60.h,
                child: Row(
                  children: [
                    SizedBox(width: 24.w),
                    Image.asset(
                      'assets/images/googleSheet.png',
                      width: 13.w,
                      height: 18.h,
                    ),
                    SizedBox(width: 8.w),
                    Text('운영진 피드백 구글폼', style: headlineSmall),
                  ],
                ),
              ),
            ),
            Divider(thickness: 0.5, height: 0, color: grayScale[30]),
            SizedBox(height: 32.h),
            Container(
              padding: EdgeInsets.only(left: 20.w),
              decoration: const BoxDecoration(color: Color(0XFF2A2A2A)),
              child: GradientText(
                '공식 채널',
                style: headlineMedium,
                colors: const [primaryBlue, primaryPurple],
              ),
            ),
            SizedBox(height: 8.h),
            Divider(thickness: 0.5, height: 0, color: grayScale[30]),
            SizedBox(
              width: 200.w,
              height: 150.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 60.h,
                    child: InkWell(
                      onTap: fetchInstaUrl,
                      child: Row(
                        children: [
                          SizedBox(width: 24.w),
                          Image.asset(
                            "assets/images/ig.png",
                            width: 16.w,
                            height: 16.h,
                          ),
                          SizedBox(width: 8.w),
                          Text('인스타그램', style: headlineSmall),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 0.5, height: 0, color: grayScale[30]),
                  SizedBox(
                    height: 60.h,
                    child: InkWell(
                      onTap: fetchPardWebUrl,
                      child: Row(
                        children: [
                          SizedBox(width: 24.w),
                          Image.asset(
                            "assets/images/logo.png",
                            width: 43.7.w,
                            height: 9.h,
                          ),
                          SizedBox(width: 8.w),
                          Text('웹사이트', style: headlineSmall),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 0.5, height: 0, color: grayScale[30]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
