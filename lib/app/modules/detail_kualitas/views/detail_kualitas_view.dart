import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_kualitas_controller.dart';

class DetailKualitasView extends GetView<DetailKualitasController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailKualitasView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailKualitasView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
