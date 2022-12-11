import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../const/colors.dart';

class LoadingDialog {
  LoadingDialog._();

  static void basic() {
    Get.dialog(Center(
      child: Container(
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: ColorsApp.backgroundColors,
            borderRadius: BorderRadius.circular(12)),
        child: const CircularProgressIndicator(
          color: ColorsApp.primary3,
        ),
      ),
    ));
  }
}
