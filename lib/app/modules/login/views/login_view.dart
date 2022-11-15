import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
          "assets/bg_login.png",
          fit: BoxFit.cover,
        )),
        Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              width: Get.width * 0.7,
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 82,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const Text(
                    "Sistem Monitoring Air",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: Get.width * 0.5,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 1,
                    color: const Color(0xFF2E2E2E),
                  ),
                  const Text(
                    "Dinas Lingkungan Hidup Kota Batu",
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Neumorphic(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: -5,
                        lightSource: LightSource.topLeft,
                        color: Colors.white),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: InputBorder.none, label: Text("Email")),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Neumorphic(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: -5,
                        lightSource: LightSource.topLeft,
                        color: Colors.white),
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => TextFormField(
                              obscureText: !controller.showPassword,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  label: Text("Password")),
                            ),
                          ),
                        ),
                        Obx(() => IconButton(
                            onPressed: controller.passwordToogle,
                            icon: Icon(controller.showPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined)))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              controller.login();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: const Color(0xFF03486F),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 50),
                              child: const Text(
                                "Masuk",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
