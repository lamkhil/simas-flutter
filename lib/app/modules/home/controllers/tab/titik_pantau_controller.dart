import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:simas/app/data/models/titik_pantau_model.dart';
import 'package:simas/app/data/services/home_services.dart';

class TitikPantauController extends GetxController
    with StateMixin<List<TitikPantau>> {
  final isMap = false.obs;

  Future<void> getTitikPantau() async {
    change(null, status: RxStatus.loading());
    final result = await HomeServices.getTitikPantauAll();
    if (result.success) {
      change(result.data, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(result.message));
    }
  }

  @override
  void onInit() {
    getTitikPantau();
    super.onInit();
  }
}
