import 'package:get/get.dart';
import 'package:simas/app/data/models/waktu_sampling_model.dart';
import 'package:simas/app/data/services/home_services.dart';

class InputHomeController extends GetxController
    with StateMixin<List<WaktuSampling>> {
  final count = 0.obs;
  @override
  void onInit() {
    getKualitas();
    super.onInit();
  }

  getKualitas() async {
    change(null, status: RxStatus.loading());
    final result = await HomeServices.getKualitasAll();
    if (result.success) {
      change(result.data, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(result.message));
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
