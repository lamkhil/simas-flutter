import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simas/app/global/controller/controller.dart';
import 'package:simas/app/modules/home/views/tab/beranda_tab.dart';
import 'package:simas/app/modules/home/views/tab/laporan_tab.dart';
import 'package:simas/app/modules/home/views/tab/titik_pantau_tab.dart';
import 'package:simas/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: Color(0xFF03486F),
                ),
                child: Obx(() => controller.selectedTitikPantau.value != null
                    ? Image.network(
                        controller.selectedTitikPantau.value!.foto!,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox.shrink()),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                          controller.selectedTitikPantau.value?.nama ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.pin_drop),
                          const SizedBox(
                            width: 8,
                          ),
                          Obx(() => Text(
                              controller.selectedTitikPantau.value?.desa ??
                                  '')),
                          Obx(() => Text(
                              ", ${controller.selectedTitikPantau.value?.kecamatan ?? ''}"))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.pin_invoke),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text('Titik Pantau '),
                          Obx(() => Text(
                              "${controller.titikPantau.indexOf(controller.titikPantau.firstWhere((element) => element.nama == controller.selectedTitikPantau.value?.nama))}"))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          const Text('Status '),
                          const SizedBox(
                            width: 12,
                          ),
                          Obx(() {
                            var kualitas =
                                controller.selectedTitikPantau.value?.kualitas;

                            if (kualitas?.isEmpty ?? true) {
                              return const Text("Belum ada data kualitas");
                            }

                            var status = kualitas![0].status;
                            late Color color;
                            switch (status) {
                              case "Sangat Bersih":
                                color = Colors.green;
                                break;
                              case "Bersih":
                                color = Colors.green.shade300;
                                break;
                              case "Cemar Ringan":
                                color = Colors.yellow;
                                break;
                              case "Cemar Berat":
                                color = Colors.pink;
                                break;
                              case "Sangat Tercemar":
                                color = Colors.red;
                                break;
                              default:
                            }
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                status!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      controller.drawerIndex.value = 0;
                    },
                    child: Column(
                      children: [
                        const Text(
                          "Kualitas",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Obx(
                          () => controller.drawerIndex.value == 0
                              ? Container(
                                  width: 80,
                                  height: 4,
                                  color: const Color(0xFF03486F),
                                )
                              : const SizedBox.shrink(),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      controller.drawerIndex.value = 1;
                    },
                    child: Column(
                      children: [
                        const Text(
                          "Kuantitas",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Obx(
                          () => controller.drawerIndex.value == 1
                              ? Container(
                                  width: 80,
                                  height: 4,
                                  color: const Color(0xFF03486F),
                                )
                              : const SizedBox.shrink(),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Obx(
                  () {
                    var kualitas =
                        controller.selectedTitikPantau.value?.kualitas;
                    var kuantitas =
                        controller.selectedTitikPantau.value?.kuantitas;

                    if (controller.drawerIndex.value == 0) {
                      if (kualitas?.isEmpty ?? true) {
                        return const Text("Belum ada data kualitas");
                      }
                    }

                    if (controller.drawerIndex.value == 1) {
                      if (kuantitas?.isEmpty ?? true) {
                        return const Text("Belum ada data kuantitas");
                      }
                    }
                    var ketinggianBefore = 0.0;
                    var ikaBefore = 0.0;
                    var kualitasBefore;
                    if (kualitas!.length > 1) {
                      ikaBefore = kualitas[1].ika!;
                      kualitasBefore = kualitas[1];
                    }
                    if (kuantitas!.length > 1) {
                      ketinggianBefore = (double.tryParse(
                              kuantitas[1]['ketinggian'].toString()) ??
                          0);
                    }
                    return controller.drawerIndex.value == 0
                        ? Column(
                            children: [
                              cardStatus(
                                  title: "Indeks Kualitas Air",
                                  subtitle: "IKA",
                                  value: kualitas[0].ika!.toStringAsFixed(2),
                                  isUpper: kualitas[0].ika! > ikaBefore),
                              cardStatus(
                                  title: "DO",
                                  subtitle: "mg/L",
                                  value: kualitas[0].do_!.toStringAsFixed(2),
                                  isUpper: kualitas[0].do_! >
                                      (kualitasBefore?.do_ ?? 0)),
                              // ElevatedButton(
                              //     onPressed: () {},
                              //     child: const Text("Detail Kualitas Air"))
                            ],
                          )
                        : Column(
                            children: [
                              cardStatus(
                                  title: "Ketinggian Air",
                                  subtitle: "centimeter",
                                  value: kuantitas[0]['ketinggian'],
                                  isUpper: (double.tryParse(kuantitas[0]
                                                  ['ketinggian']!
                                              .toString()) ??
                                          0) >
                                      ketinggianBefore),
                              cardStatus(
                                  title: "Kecepatan Air",
                                  subtitle: "centimeter per second",
                                  value: kuantitas[0]['kecepatan']),
                            ],
                          );
                  },
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF03486F),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 30,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sistem Monitoring Air",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Container(
                    width: 165,
                    height: 1,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  const Text("Dinas Lingkungan Hidup Kota Batu",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: Colors.white)),
                ],
              ),
            ],
          ),
          bottom: TabBar(
              controller: controller.tabController,
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicator: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                color: Colors.white,
              ),
              labelColor: const Color(0xFF03486F),
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(
                  text: "Beranda",
                ),
                Tab(
                  text: "Titik Pantau",
                ),
                Tab(
                  text: "Laporan",
                )
              ]),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF03486F),
          onPressed: () {
            if (Get.find<ControllerApp>().user != null) {
              Get.toNamed(Routes.INPUT_HOME);
            } else {
              Get.toNamed(Routes.LOGIN);
            }
          },
          child: const Icon(Icons.add),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [BerandaTab(), TitikPantauTab(), LaporanTab()],
        ));
  }

  Card cardStatus(
      {required String title,
      required String subtitle,
      required String value,
      bool? isUpper,
      Widget? customUpper}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                title,
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            FittedBox(
              child: Text(
                subtitle,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                customUpper ??
                    (isUpper == null
                        ? const SizedBox.shrink()
                        : isUpper
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.trending_up,
                                    color: Colors.green,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Naik",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.trending_down,
                                    color: Colors.red,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Turun",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ],
                              ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
