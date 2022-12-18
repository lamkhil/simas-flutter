import 'package:get/get.dart';

import '../modules/detail_kualitas/bindings/detail_kualitas_binding.dart';
import '../modules/detail_kualitas/views/detail_kualitas_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/input_home/bindings/input_home_binding.dart';
import '../modules/input_home/views/input_home_view.dart';
import '../modules/input_quality/bindings/input_quality_binding.dart';
import '../modules/input_quality/views/input_quality_view.dart';
import '../modules/input_quantity/bindings/input_quantity_binding.dart';
import '../modules/input_quantity/views/input_quantity_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.INPUT_HOME,
      page: () => InputHomeView(),
      binding: InputHomeBinding(),
    ),
    GetPage(
      name: _Paths.INPUT_QUANTITY,
      page: () => InputQuantityView(),
      binding: InputQuantityBinding(),
    ),
    GetPage(
      name: _Paths.INPUT_QUALITY,
      page: () => InputQualityView(),
      binding: InputQualityBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_KUALITAS,
      page: () => DetailKualitasView(),
      binding: DetailKualitasBinding(),
    ),
  ];
}
