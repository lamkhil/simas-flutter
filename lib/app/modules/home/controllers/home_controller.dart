import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simas/app/modules/home/controllers/tab/beranda_controller.dart';
import 'package:simas/app/modules/home/controllers/tab/laporan_controller.dart';
import 'package:simas/app/modules/home/controllers/tab/titik_pantau_controller.dart';

import '../../../data/models/titik_pantau_model.dart';
import '../../../data/services/home_services.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  late TabController tabDrawerController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final drawerIndex = 0.obs;

  final Rx<TitikPantau?> selectedTitikPantau = Rx(null);

  void openDrawer(TitikPantau titikpantau) {
    selectedTitikPantau.value = titikpantau;
    scaffoldKey.currentState!.openDrawer();
  }

  final _currentTab = 0.obs;
  int get currentTab => _currentTab.value;
  final taboffset = (0.0).obs;
  RxList<TitikPantau> titikPantau = RxList([]);

  final berandaController = Get.put(BerandaController());
  final laporanController = Get.put(LaporanController());
  final titikPantauController = Get.put(TitikPantauController());

  Future<void> getAllTitikPantau() async {
    final result = await HomeServices.getTitikPantauAll();
    if (result.success) {
      titikPantau.addAll(result.data!);
    }
  }

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabDrawerController = TabController(length: 2, vsync: this);
    getAllTitikPantau();
    tabController.addListener(() {
      _currentTab.value = tabController.index;
    });
    tabController.animation!.addListener(() {
      taboffset.value = tabController.offset;
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    tabDrawerController.dispose();
    Get.delete<BerandaController>();
    Get.delete<TitikPantauController>();
    Get.delete<LaporanController>();
    super.onClose();
  }
}
