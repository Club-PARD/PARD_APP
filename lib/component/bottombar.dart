import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  bool fbSelect = false;

  void _onItemTapped(int index) {
    setState(() {
    _selectedIndex = index;
    fbSelect = (index == 1);
  });
  switch (index) {
    case 0 : Get.offNamed('/home');
    break;
    case 2 : Get.offNamed('/mypage');
    break;
  }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        BottomNavigationBar(
          backgroundColor: const Color(0xFF2A2A2A),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home,), label: ''),
            BottomNavigationBarItem(icon: Icon(null), label: ''), 
            BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined,), label: ''),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromRGBO(82, 98, 245, 1),
          onTap: _onItemTapped,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
              // 활성화, 비활 만들어야 함 
            },
            backgroundColor: const Color.fromRGBO(42, 42, 42, 1),
            child: Icon(
              Icons.qr_code_scanner_outlined,
              color: _selectedIndex == 1
                  ? const Color.fromRGBO(82, 98, 245, 1)
                  : Colors.white,
            ),
          ),
        ),
      ],
    );

  }
}