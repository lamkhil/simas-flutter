import 'dart:io';

import 'package:get/get.dart';

import 'package:dio/adapter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simas/app/data/models/titik_pantau_model.dart';
import 'package:simas/app/data/services/home_services.dart';

import '../../data/models/user_model.dart';
import '../../network/config.dart';

class ControllerApp extends GetxController {
  final Rx<User?> userRx = Rx(null);
  User? get user => userRx.value;
  Stream<User?> get userStream => userRx.stream;

  RxList<TitikPantau> titikPantau = RxList([]);

  void saveGlobalUser(User? user) {
    userRx.value = user;
  }

  void getUserSaved() {
    final user = GetStorage().read('user');
    if (user != null) {
      saveGlobalUser(User.fromJson(user));
    }
  }

  @override
  void onInit() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    super.onInit();
  }

  @override
  void onReady() {
    getUserSaved();
    getAllTitikPantau();
    super.onReady();
  }

  Future<void> getAllTitikPantau() async {
    final result = await HomeServices.getTitikPantauAll();
    if (result.success) {
      titikPantau.addAll(result.data!);
    }
  }
}
