import 'package:get/get.dart';

import '../controllers/input_quantity_controller.dart';

class InputQuantityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputQuantityController>(
      () => InputQuantityController(),
    );
  }
}
