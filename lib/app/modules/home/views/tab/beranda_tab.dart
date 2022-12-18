import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simas/app/modules/home/controllers/home_controller.dart';
import 'package:simas/app/modules/home/controllers/tab/beranda_controller.dart';
import 'package:simas/app/modules/home/views/tab/widget/chart.dart';

import 'widget/chart_2.dart';

class BerandaTab extends StatefulWidget {
  const BerandaTab({super.key});

  @override
  State<BerandaTab> createState() => _BerandaTabState();
}

class _BerandaTabState extends State<BerandaTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _BerandaTab();
  }

  @override
  bool get wantKeepAlive => true;
}

class _BerandaTab extends GetView<BerandaController> {
  const _BerandaTab();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getDataBeranda();
      },
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: controller.obx((state) => successState(state!),
            onLoading: loadingState(),
            onError: (err) => Center(
                  child: Text(
                    "Server Error",
                    style: Get.textTheme.headline4,
                  ),
                )),
      )),
    );
  }

  Column successState(Map<String, dynamic> state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Data Statistik Sungai",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Data Kualitas & Kuantitas air seluruh sungai kota Batu /tahun",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: cardStatus(
                    title: "Indeks Kualitas Air",
                    subtitle: "IKA",
                    value: double.tryParse(state['ika']?.toString() ?? '')
                            ?.toStringAsFixed(2) ??
                        "Belum ada data",
                    isUpper: state['ika_compare'] != null
                        ? (state['ika_compare'].toString() != "Turun")
                        : null)),
            Expanded(
              flex: 1,
              child: cardStatus(
                  title: "IKA Terendah",
                  subtitle: state['ika_terendah']['nama']?.toString() ??
                      "Belum ada data",
                  value: double.tryParse(
                              state['ika_terendah']['ika']?.toString() ?? '')
                          ?.toStringAsFixed(2) ??
                      "Belum ada data",
                  isUpper: state['ika_terendah']['ika_compare'] == 0
                      ? null
                      : state['ika_terendah']['ika_compare'].toString() !=
                          "Turun"),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: cardStatus(
                  title: "Ketinggian Air",
                  subtitle: "cm",
                  value:
                      double.tryParse(state['ketinggan_air']?.toString() ?? '')
                              ?.toStringAsFixed(2) ??
                          "Belum ada data",
                  isUpper: state['ketinggian_compare'] == null
                      ? null
                      : state['ketinggian_compare'].toString() != "Turun"),
            ),
            Expanded(
              flex: 1,
              child: cardStatus(
                  title: "Tingkat Kecemaran",
                  subtitle: " ",
                  value: state['tingkat_kecemaran'] ?? "Belum ada data"),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          "Indeks Kualitas Air",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 12,
        ),
        BarIndeksKualitasAir(data: state['grafik_ika']),
        const SizedBox(
          height: 12,
        ),
        const Text(
          "Indikator Indeks Kualitas Air",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12)),
              child: Obx(
                () => DropdownButton(
                    value: controller.parameter.value,
                    elevation: 0,
                    underline: const SizedBox.shrink(),
                    hint:
                        const Text("Parameter", style: TextStyle(fontSize: 12)),
                    items: controller.parameterListView
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child:
                                Text(e, style: const TextStyle(fontSize: 12))))
                        .toList(),
                    onChanged: (val) {
                      controller.parameter.value = val;
                      int index =
                          controller.parameterListView.indexOf(val ?? '');
                      controller.indexParameter.value = index;
                    }),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () {
                Get.dialog(
                  AlertDialog(
                    content: SingleChildScrollView(
                        child: Column(
                      children: List.generate(
                          Get.find<HomeController>().titikPantau.length,
                          (index) => Obx(() => CheckboxListTile(
                                value:
                                    controller.titikPantauShowParameter[index],
                                onChanged: (val) {
                                  controller.titikPantauShowParameter[index] =
                                      val ?? false;
                                  controller.indexParameter.refresh();
                                },
                                title: Text(Get.find<HomeController>()
                                        .titikPantau[index]
                                        .nama ??
                                    ''),
                              ))),
                    )),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            controller.indexParameter.refresh();
                            Get.back();
                          },
                          child: const Text("Simpan"))
                    ],
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12)),
                child: DropdownButton(
                  value: null,
                  elevation: 0,
                  underline: const SizedBox.shrink(),
                  hint: const Text(
                    "Titik Pantau",
                    style: TextStyle(fontSize: 12),
                  ),
                  iconDisabledColor: Get.theme.textTheme.bodyText1!.color,
                  items: [
                    "Brantas Sengguruh",
                  ]
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e, style: const TextStyle(fontSize: 12))))
                      .toList(),
                  onChanged: null,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => Text(
            controller.parameter.value ?? 'Pilih Parameter',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(() {
          return LineChartSample1(
              data: state['grafik_parameter'],
              parameter: controller.indexParameter.value >= 0
                  ? controller.parameterList[controller.indexParameter.value]
                  : null,
              listShow: controller.titikPantauShowParameter);
        })
      ],
    );
  }

  Column loadingState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Data Statistik Sungai",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Data Kualitas & Kuantitas air seluruh sungai kota Batu /tahun",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: cardStatusShimmer(title: "Indeks Kualitas Air")),
            Expanded(flex: 1, child: cardStatusShimmer(title: "IKA Terendah"))
          ],
        ),
        Row(
          children: [
            Expanded(
                flex: 1, child: cardStatusShimmer(title: "Ketinggian Air")),
            Expanded(
                flex: 1, child: cardStatusShimmer(title: "Tingkat Kecemaran"))
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          "Indeks Kualitas Air",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          width: double.infinity,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                width: double.infinity,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          "Indikator Indeks Kualitas Air",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          width: double.infinity,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: AspectRatio(
              aspectRatio: 0.75,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                width: double.infinity,
              ),
            ),
          ),
        ),
      ],
    );
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

  Card cardStatusShimmer({required String title}) {
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
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 18,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 18,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
