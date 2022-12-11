import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialog {
  ErrorDialog._();

  static void basic(String? message) {
    Get.dialog(AlertDialog(
      title: Text(
        "Oops!",
        style: Get.textTheme.headline3,
      ),
      content: Text(
        message ?? 'Server Error',
        style: Get.textTheme.bodyText1,
      ),
      actions: [
        ElevatedButton(onPressed: () => Get.back(), child: const Text("Close"))
      ],
    ));
  }
}
