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
      backgroundColor: const Color(0xFF1A1A1A),
      body: Column(
        children: [
          Container(
            width: width,
            height: height / 2.15,
            decoration: const ShapeDecoration(
              color: Color(0xFF242424),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height / 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width / 15,
                    ),
                    Image.asset(
                      "assets/logo.png",
                      width: 120,
                      height: 25,
                    ),
                    SizedBox(
                      width: width / 2,
                    ),
                    Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        iconSize: 40,
                      );
                    }),
                  ],
                ),
                SizedBox(height: height / 26),
                Row(
                  children: [
                    SizedBox(width: width / 15),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pretendart',
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
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
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    Container(
                      width: 45,
                      height: 24,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF5262F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        /** generation값으로 대체 */
                        '2기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 90,
                      height: 24,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(1.00, -0.03),
                          end: Alignment(-1, 0.03),
                          colors: [Color(0xFF5262F5), Color(0xFF7B3FEF)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        /** part값으로 대체 */
                        '디자인 파트',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 80,
                      height: 24,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF7B3EEF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        /** member값으로 대체 */
                        '거친 파도',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                    ),
                  ],
                ),
                Row(
                  /** 캐릭터랑 박스 stack으로  */
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: width / 1.3,
            height: height / 5.8,
            decoration: ShapeDecoration(
              color: const Color(0xFF2A2A2A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height/81,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      '🏄🏻‍♂️ PARDNERSHIP 🏄🏻‍♂️ ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          '더보기',
                          style: TextStyle(
                            color: Color(0xFFE4E4E4),
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            height: 1.33,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: height/162,
                ),
                Container(
                  width: 279,
                  height: 1,
                  color: const Color.fromRGBO(163, 163, 163, 1),
                ),
                Row(
                  children: [
                    Container(
                      width: width / 2.6,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height / 40,
                          ),
                          Text(
                            '파드 포인트',
                            style: TextStyle(
                              color: Color(0xFFE4E4E4),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.33,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                            /** User의 point로 변경 */
                          Text(
                            '+7점',
                            style: TextStyle(
                              color: Color(0xFF64C59A),
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              height: 1.25,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                  width: 1,
                  height: height/18,
                  color: const Color.fromRGBO(163, 163, 163, 1),
                ),
                Container(
                      width: width / 2.6 - 2,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height / 40,
                          ),
                          Text(
                            '벌점',
                            style: TextStyle(
                              color: Color(0xFFE4E4E4),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.33,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                            /** User의 point로 변경 */
                          Text(
                            '컨트롤러에서 ㅋ',
                            style: TextStyle(
                              color: Color(0xFFFF5A5A),
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              height: 1.25,
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: height / 33.8,
          ),
          Container(
            width: width / 1.3,
            height: height / 5,
            decoration: ShapeDecoration(
              color: const Color(0xFF2A2A2A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height / 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      '🗓 UPCOMING EVENT 🗓 ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          '더보기',
                          style: TextStyle(
                            color: Color(0xFFE4E4E4),
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            height: 1.33,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: height / 52.4,
                ),
                Container(
                  width: 279,
                  height: 1,
                  color: const Color.fromRGBO(163, 163, 163, 1),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
