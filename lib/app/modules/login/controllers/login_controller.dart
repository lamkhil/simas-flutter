import 'package:get/get.dart';
import 'package:simas/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final _showPassword = false.obs;
  bool get showPassword => _showPassword.value;

  void passwordToogle() => _showPassword.value = !_showPassword.value;

  void login() {
    Get.offAllNamed(Routes.HOME);
  }
}
