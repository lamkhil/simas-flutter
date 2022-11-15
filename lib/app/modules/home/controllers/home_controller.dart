import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  final _currentTab = 0.obs;
  int get currentTab => _currentTab.value;
  final taboffset = (0.0).obs;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
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
    super.onClose();
  }
}
