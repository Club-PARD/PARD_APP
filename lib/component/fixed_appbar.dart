import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeFixedBar extends StatelessWidget {
  const HomeFixedBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF242424),
      child: Column(
        children: [
          SizedBox(height: 10.h,),
          Row(
            children: [
              SizedBox(width: 20.w,),
              Image.asset(
                              "assets/images/logo.png",
                              width: 120.w,
                              height: 25.h,
                            ),
              const Spacer(),
              IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openEndDrawer();
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                                iconSize: 40.w,
                              ),
                            
                            SizedBox(
                              width: 20.w,
                            ),
            ],
          ),
        ],
      ),
    );
  }
}