import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';

class HomeBar extends StatefulWidget {
  const HomeBar({super.key});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

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
            SizedBox(height: 64.h),
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
                  },
                )
            ],
            SizedBox(height: 32.h,),
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
                    child: Row(
                      children: [
                        SizedBox(width: 24.w,),
                        Image.asset("assets/images/ig.png", width: 16.w,height: 16.h,),
                        SizedBox(width: 8.w,),
                        Text('인스타그램',style: headlineSmall)
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  SizedBox(
                    height: 60.h,
                    child: Row(
                      children: [
                         SizedBox(width: 24.w,),
                        Image.asset("assets/images/logo.png", width: 43.7.w,height: 9.h),
                         SizedBox(width: 8.w),
                         Text('웹사이트',style: headlineSmall,)
                      ],
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