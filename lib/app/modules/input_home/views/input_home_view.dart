import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simas/app/global/const/colors.dart';
import 'package:simas/app/routes/app_pages.dart';

import '../../../global/controller/controller.dart';
import '../controllers/input_home_controller.dart';

class InputHomeView extends GetView<InputHomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsApp.primary,
          title: const Text('Data'),
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                // PopupMenuItem 1
                PopupMenuItem(
                  value: 1,
                  // row with 2 children
                  child: Row(
                    children: [
                      const Icon(Icons.person, color: ColorsApp.primary),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${Get.find<ControllerApp>().user?.name}")
                    ],
                  ),
                ),
                // PopupMenuItem 2
                PopupMenuItem(
                  value: 2,
                  // row with two children
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        color: ColorsApp.primary,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Log Out")
                    ],
                  ),
                ),
              ],
              color: Colors.white,
              elevation: 2,
              // on selected we show the dialog box
              onSelected: (value) {
                // if value 1 show dialog
                if (value == 1) {
                  showAboutDialog(
                      context: context,
                      applicationName:
                          "${Get.find<ControllerApp>().user?.name}",
                      applicationVersion:
                          "${Get.find<ControllerApp>().user?.email}",
                      applicationIcon: const Icon(Icons.person));
                  // if value 2 show dialog
                } else if (value == 2) {
                  Get.offAllNamed(Routes.HOME);
                  Get.find<ControllerApp>().saveGlobalUser(null);
                  GetStorage().erase();
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Data Kualitas Air",
                    style: Get.textTheme.headline6!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsApp.primary),
                      onPressed: () {
                        Get.toNamed(Routes.INPUT_QUALITY);
                      },
                      child: const Text("Tambah Data"))
                ],
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [itemTime(), itemTime()],
                ),
              ))
            ],
          ),
        ));
  }

  Card itemTime() {
    return Card(
      child: Theme(
        data: Get.theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            "2022 Tahap 2",
            style:
                Get.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
          ),
          children: [
            Card(
              child: ListTile(
                title: Text(
                  "Mata Air Sumber Brantas",
                  style: Get.textTheme.bodyText2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  "Mata Air Sumber Brantas",
                  style: Get.textTheme.bodyText2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
