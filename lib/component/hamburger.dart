import 'package:flutter/material.dart';

class Hamburger extends StatefulWidget {
  const Hamburger({super.key});

  @override
  State<Hamburger> createState() => _HamburgerState();
}

class _HamburgerState extends State<Hamburger> {
  bool _areItemsVisible = false;
  @override
  Widget build(BuildContext context) {
    /** 반응형으로 */
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: const Color(0XFF2A2A2A),
      width: width/1.8,
      child: Drawer(
        backgroundColor: const Color(0XFF2A2A2A),
        child: ListView(
         // padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          children: <Widget>[
            SizedBox(height: height/12,),
            Container(
              padding: const EdgeInsets.only(left: 20),
              decoration: const BoxDecoration(
                color: Color(0XFF2A2A2A),
              ),
              child: const Text('공지 및 자료', style: TextStyle(color: Color.fromRGBO(82, 98, 245, 1), fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _areItemsVisible = !_areItemsVisible;
                });
              },
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/Notion.png',
                      width: 22,
                      height: 22,
                    ),
                    const Text('PARD 노션',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      width: 40,
                    ),
                    IconButton(
                      icon: Icon(
                        _areItemsVisible
                            ? Icons.keyboard_arrow_down_sharp
                            : Icons.keyboard_arrow_right_sharp,
                        size: 19,
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
                  title: const Text('전체', style: TextStyle(color: Color.fromRGBO(163,163,163,1))),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('기획 파트', style: TextStyle(color: Color.fromRGBO(163,163,163,1))),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('다저안 파트', style: TextStyle(color: Color.fromRGBO(163,163,163,1))),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('서버 파트', style: TextStyle(color: Color.fromRGBO(163,163,163,1))),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('웹 파트', style: TextStyle(color: Color.fromRGBO(163,163,163,1))),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('iOS 파트', style: TextStyle(color: Color.fromRGBO(163,163,163,1))),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
            ],
            SizedBox(height: height/25,),
            Container(
              padding: const EdgeInsets.only(left: 20),
              decoration: const BoxDecoration(
                color: Color(0XFF2A2A2A),
              ),
              child: const Text('피드백', style: TextStyle(color: Color.fromRGBO(82, 98, 245, 1), fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              width: width/2,
              height: 60,
              // decoration: BoxDecoration(border: Border.all(
              //   color: const Color.fromRGBO(163, 163, 163, 1),
              // )),
              child: Row(
                children: [
                  const SizedBox(width: 20,),
                  Image.asset('assets/googleSheet.png', width: 22,height: 22,),
                  const SizedBox(width: 8,),
                  const Text('세미나 구글폼',style: TextStyle(color: Color(0XFFE4E4E4), fontSize: 14,fontWeight: FontWeight.w600),)
                ],
              ),
            ),
            SizedBox(height: height/25,),
            Container(
              padding: const EdgeInsets.only(left: 20),
              decoration: const BoxDecoration(
                color: Color(0XFF2A2A2A),
              ),
              child: const Text('공식 채널', style: TextStyle(color: Color.fromRGBO(82, 98, 245, 1), fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              width: width/2,
              height: 150,
              // decoration: BoxDecoration(border: Border.all(
              //   color: const Color.fromRGBO(163, 163, 163, 1),
              // )),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        const SizedBox(width: 20,),
                        Image.asset("assets/ig.png", width: 22,height: 22,),
                        const SizedBox(width: 8,),
                        const Text('인스타그램',style: TextStyle(color: Color(0XFFE4E4E4), fontSize: 14,fontWeight: FontWeight.w600),)
                      ],
                    ),
                  ),
                  const SizedBox(height: 1,),
                  SizedBox(
              //       decoration: BoxDecoration(border: Border.all(
              //   color: const Color.fromRGBO(163, 163, 163, 1),
              // )),
                    height: 60,
                    child: Row(
                      children: [
                        const SizedBox(width: 20,),
                        Image.asset("assets/logo.png", width: 22,height: 22,),
                        const SizedBox(width: 8,),
                        const Text('웹사이트',style: TextStyle(color: Color(0XFFE4E4E4), fontSize: 14,fontWeight: FontWeight.w600),)
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