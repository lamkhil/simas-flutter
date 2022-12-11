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
        appBar: AppBar(
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
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 165,
                    height: 1,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  const Text("Dinas Lingkungan Hidup Kota Batu",
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal)),
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
              Get.offAllNamed(Routes.LOGIN);
            }
          },
          child: const Icon(Icons.add),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: const [BerandaTab(), TitikPantauTab(), LaporanTab()],
        ));
  }
}
