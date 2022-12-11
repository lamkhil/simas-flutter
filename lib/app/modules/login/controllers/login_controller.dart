import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:simas/app/data/services/admin_services.dart';
import 'package:simas/app/global/widget/error.dart';
import 'package:simas/app/global/widget/loading.dart';
import 'package:simas/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final _showPassword = false.obs;
  bool get showPassword => _showPassword.value;

  void passwordToogle() => _showPassword.value = !_showPassword.value;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    LoadingDialog.basic();
    final result = await AdminServices.login(
        email: emailController.text, password: passwordController.text);
    Get.back();
    if (result.success) {
      Get.offNamed(Routes.INPUT_HOME);
    } else {
      ErrorDialog.basic(result.message);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
