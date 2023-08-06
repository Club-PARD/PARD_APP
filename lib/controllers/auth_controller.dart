import 'package:get/get.dart';

class AuthControler extends GetxController {
  var _counter = 0.obs;

  int get counter => _counter.value;

  void increment() => _counter.value++;
}
