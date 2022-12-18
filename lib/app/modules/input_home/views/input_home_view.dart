import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simas/app/data/models/waktu_sampling_model.dart';
import 'package:simas/app/global/const/colors.dart';
import 'package:simas/app/routes/app_pages.dart';

import '../../../global/controller/controller.dart';
import '../controllers/input_home_controller.dart';

class InputHomeView extends GetView<InputHomeController> {
  const InputHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          backgroundColor: ColorsApp.primary,
          title: Text(
            '${Get.find<ControllerApp>().user?.name}',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                // PopupMenuItem 1
                PopupMenuItem(
                  value: 1,
                  // row with 2 children
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Get.theme.textTheme.bodyText1!.color!,
                      ),
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
                    children: [
                      Icon(
                        Icons.logout,
                        color: Get.theme.textTheme.bodyText1!.color!,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Log Out")
                    ],
                  ),
                ),
              ],
              elevation: 2,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              // on selected we show the dialog box
              onSelected: (value) {
                // if value 1 show dialog
                if (value == 1) {
                  showAboutDialog(
                      context: context,
                      applicationName:
                          "${Get.find<ControllerApp>().user?.name}",
                      applicationVersion:
                          "${Get.find<ControllerApp>().user?.email}\n\ncreated by Muhammad Lamkhil Bashor",
                      applicationIcon: const Icon(Icons.person));
                  // if value 2 show dialog
                } else if (value == 2) {
                  Get.back();
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
                    style: Get.textTheme.headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsApp.primary),
                      onPressed: () {
                        Get.toNamed(Routes.INPUT_QUALITY);
                      },
                      child: const Text(
                        "Tambah Data",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {
                  controller.getKualitas();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: controller.obx(
                    (state) {
                      return Column(
                        children: state?.map((e) => itemTime(e)).toList() ?? [],
                      );
                    },
                    onLoading: SizedBox(
                      height: Get.height * 0.8,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    onError: (error) {
                      return SizedBox(
                        height: Get.height * 0.8,
                        child: Center(
                          child: Text(error ?? ''),
                        ),
                      );
                    },
                  ),
                ),
              ))
            ],
          ),
        ));
  }

  Card itemTime(WaktuSampling item) {
    return Card(
      child: Theme(
        data: Get.theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            "${item.tahun} Tahap ${item.tahap}",
            style:
                Get.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
          ),
          children: [
            ...item.kualitas
                .map(
                  (e) => InkWell(
                    onTap: () {
                      Get.toNamed(Routes.INPUT_QUALITY, arguments: {
                        'kualitas': e,
                        'waktu': item.waktu,
                        'tahap': item.tahap
                      });
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          e.titikPantau?.nama ?? 'Server Error',
                          style: Get.textTheme.bodyText2!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_right,
                            color: Get.theme.textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
