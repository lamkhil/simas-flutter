import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simas/app/modules/home/controllers/home_controller.dart';
import 'package:simas/app/modules/home/views/tab/widget/chart.dart';

import 'widget/chart_2.dart';

class BerandaTab extends GetView<HomeController> {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
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
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color(0xFF444444)),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: cardStatus(
                    title: "Indeks Kualitas Air",
                    subtitle: "IKA",
                    value: "52.32",
                    isUpper: true),
              ),
              Expanded(
                flex: 1,
                child: cardStatus(
                    title: "IKA Terendah",
                    subtitle: "Jembatan Metro",
                    value: "68.98",
                    isUpper: false),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: cardStatus(
                    title: "Ketinggian Air",
                    subtitle: "meter",
                    value: "3.2",
                    isUpper: false),
              ),
              Expanded(
                flex: 1,
                child: cardStatus(
                    title: "Tingkat Kecemaran",
                    subtitle: " ",
                    value: "Cemar Ringan"),
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
          const BarChartSample2(),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Indeks Pencemaran Air",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const BarChartSample2(),
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
                child: DropdownButton(
                    value: null,
                    elevation: 0,
                    underline: const SizedBox.shrink(),
                    hint:
                        const Text("Parameter", style: TextStyle(fontSize: 12)),
                    items: ["TSS", "BOD", "No2", "DHL"]
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child:
                                Text(e, style: const TextStyle(fontSize: 12))))
                        .toList(),
                    onChanged: (val) {}),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
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
                    items: [
                      "Sumber Brantas",
                      "Jembatan Metro",
                      "Brantas Sengguruh",
                      "Brantas 2"
                    ]
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child:
                                Text(e, style: const TextStyle(fontSize: 12))))
                        .toList(),
                    onChanged: (val) {}),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "TSS",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          const LineChartSample1()
        ],
      ),
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
