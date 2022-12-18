import 'package:get/get.dart';

import '../controllers/detail_kualitas_controller.dart';

class DetailKualitasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailKualitasController>(
      () => DetailKualitasController(),
    );
  }
}
