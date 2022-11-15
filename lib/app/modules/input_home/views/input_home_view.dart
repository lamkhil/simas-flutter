import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/input_home_controller.dart';

class InputHomeView extends GetView<InputHomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InputHomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'InputHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
