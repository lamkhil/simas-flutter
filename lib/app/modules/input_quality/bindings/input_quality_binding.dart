import 'package:get/get.dart';

import '../controllers/input_quality_controller.dart';

class InputQualityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputQualityController>(
      () => InputQualityController(),
    );
  }
}
