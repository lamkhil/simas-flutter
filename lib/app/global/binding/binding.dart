import 'package:get/get.dart';

import '../controller/controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ControllerApp());
  }
}
