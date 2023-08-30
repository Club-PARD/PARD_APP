import 'package:get/get.dart';

class BottomBarController extends GetxController {
  static BottomBarController get to => Get.find();

  final RxInt selectedIndex = 0.obs;
  // var fbSelect = false.obs;

  void onItemTapped(int index) {
    selectedIndex(index);
    // selectedIndex.value = index;
    // fbSelect.value = (index == 1);
    print(index);

    // switch (index) {
    //   case 0:
    //     Get.offNamed('/home');
    //     break;
    //   case 2:
    //     Get.offNamed('/mypage');
    //     break;
    //   default:
    //      Get.offNamed('/home');
    // }
  }
}
