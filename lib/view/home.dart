import 'package:flutter/material.dart';
import 'package:pard_app/component/bottombar.dart';
import 'package:pard_app/component/hamburger.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      endDrawer: const Hamburger(),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          SizedBox(height: height/15,),
          Row(
            children: [
               SizedBox(width: width/15,),
              Image.asset("assets/logo.png", width: 120, height: 25,),
              SizedBox(width: width/2,),
              Builder(
                builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer(); 
                  }, icon: const Icon(Icons.menu, color: Colors.white,), iconSize: 40,);
                }
              ),
            ],
          ),
          SizedBox(height: height/26),
           Row(
             children: [
              SizedBox(width: width/15),
               RichText(
               text: const TextSpan(
                 style: TextStyle(color: Colors.white, fontFamily: 'Pretendart', fontSize: 18, fontWeight: FontWeight.w600),
                 children: <TextSpan>[
                   TextSpan(text: '안녕하세요, '),
                                 TextSpan(
                        text: '조세희',
                                     style: TextStyle(color: Color(0XFF5262F5))),
                   TextSpan(text: '님\n오늘도 PARD에서 함께 협업해요!'),
                 ],
               ),
                      ),
             ],
           ),

        ],
        
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}