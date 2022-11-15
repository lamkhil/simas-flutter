import 'package:get/get.dart';

import '../controllers/input_home_controller.dart';

class InputHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputHomeController>(
      () => InputHomeController(),
    );
  }
}
