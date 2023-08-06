import 'package:get/get.dart';

class PointController extends GetxController {
  var _counter = 0.obs;

  int get counter => _counter.value;

  void increment() => _counter.value++;
}
