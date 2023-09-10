import 'package:get/get.dart';

class BottomBarController extends GetxController {
  static BottomBarController get to => Get.find();

  final RxInt _selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  RxInt get selectedIndex => _selectedIndex;

  void onItemTapped(int index) {
    _selectedIndex(index);
    print(index);
  }
}
