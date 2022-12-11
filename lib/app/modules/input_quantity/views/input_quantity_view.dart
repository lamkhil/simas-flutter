import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/input_quantity_controller.dart';

class InputQuantityView extends GetView<InputQuantityController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InputQuantityView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'InputQuantityView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
