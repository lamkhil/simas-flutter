import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simas/app/data/models/titik_pantau_model.dart';

import '../../../global/const/colors.dart';
import '../controllers/input_quality_controller.dart';

class InputQualityView extends GetView<InputQualityController> {
  const InputQualityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          backgroundColor: ColorsApp.primary,
          title: const Text(
            'Tambah Data',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputTitikPantau(),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            label: "Waktu Sampling",
                            controller: controller.waktuSamplingController,
                            onTap: () async {
                              final result = await showDatePicker(
                                  context: context,
                                  initialDate: controller
                                          .waktuSamplingController
                                          .text
                                          .isNotEmpty
                                      ? DateFormat('dd-MM-yyyy').parse(
                                          controller
                                              .waktuSamplingController.text)
                                      : DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime.now());
                              if (result != null) {
                                controller.waktuSamplingController.text =
                                    DateFormat('dd-MM-yyyy').format(result);
                              }
                            },
                            prefix: Icons.calendar_month)),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Tahap",
                                style: Get.textTheme.bodyText1!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Obx(
                                () => DropdownButtonFormField<String>(
                                    value: controller.selectedTahap.value,
                                    hint: const Text("Tahap"),
                                    items: ["1", "2"]
                                        .map((element) => DropdownMenuItem(
                                              value: element,
                                              child: Text(
                                                element,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (val) {
                                      controller.selectedTahap.value = val;
                                    }),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "A. Fisika",
                    style: Get.textTheme.headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            label: "Suhu",
                            suffix: "°C",
                            controller: controller.temperaturController)),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            label: "TDS",
                            controller: controller.tdsController,
                            hint: "Residu Terlarut",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            label: "Warna",
                            suffix: "TCU",
                            controller: controller.warnaController)),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.tssController,
                            label: "TSS",
                            hint: "Padatan Tersuspensi",
                            suffix: "mg/L")),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "B. Kimia",
                    style: Get.textTheme.headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.pHController, label: "pH")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.bodController,
                            label: "BOD",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.codController,
                            label: "COD",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.doController,
                            label: "DO",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.phospatController,
                            label: "Phospat(P)",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.nitratController,
                            label: "Nitrat (NO3-N)",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.amoniaController,
                            label: "Amonia (NH3-N)",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.arsenController,
                            label: "Arsen (As)",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.kobaltController,
                            label: "Kobalt (Co)",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.boronController,
                            label: "Boron (Bo)",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.seleniumController,
                            label: "Selenium (Se)",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.kadmiumController,
                            label: "Kadmium (Cd)",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.tembagaController,
                            label: "Tembaga (Cu)",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.timbalController,
                            label: "Timbal (Pb)",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.merkuriController,
                            label: "Merkuri (Hg)",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.sengController,
                            label: "Seng (Zn)",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.sianidaController,
                            label: "Sianida (CN)",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.flouridaController,
                            label: "Flourida (F)",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.khlorinController,
                            label: "Khlorin Bebas",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.nitritController,
                            label: "Nitrit (NO2-N)",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.belerangController,
                            label: "Belerang H2S",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.kloridaController,
                            label: "Klorida (Cl)",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.sulfatController,
                            label: "Sulfat (SO4)",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.minyakController,
                            label: "Minyak dan Lemak",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.deterjenController,
                            label: "Deterjen",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.phenolController,
                            label: "Phenol",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.nikelController,
                            label: "Nikel (Ni)",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.nTotalController,
                            label: "N-Total",
                            suffix: "mg/L")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: inputField(
                            controller: controller.kromiumController,
                            label: "Kromium VI (Cr6+)",
                            suffix: "mg/L")),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "C. Mikro Biologi",
                    style: Get.textTheme.headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.totalKoliformController,
                            label: "Total Koliform",
                            suffix: "mg/L")),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 1,
                        child: inputField(
                            controller: controller.fecalKoliformController,
                            label: "Fecal Koliform",
                            suffix: "mg/L")),
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsApp.primary),
                    onPressed: () {
                      controller.onSave();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Simpan",
                            style: Get.textTheme.headline5!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  Padding inputField(
      {required String label,
      String? suffix,
      IconData? prefix,
      String? hint,
      TextInputType textInputType =
          const TextInputType.numberWithOptions(decimal: true),
      Function()? onTap,
      TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style:
                Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: controller,
            keyboardType: textInputType,
            onTap: onTap,
            readOnly: onTap != null,
            decoration: InputDecoration(
                hintText: hint,
                prefixIcon: prefix != null ? Icon(prefix) : null,
                hintStyle: const TextStyle(fontSize: 10),
                suffixIcon: suffix != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(suffix),
                        ],
                      )
                    : null),
          )
        ],
      ),
    );
  }

  Padding inputTitikPantau() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Lokus",
            style:
                Get.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(() => DropdownButtonFormField<TitikPantau>(
              value: controller.selectedTitikPantau.value,
              hint: const Text("Pilih Lokasi Fokus"),
              items: controller.titikPantau
                  .map((element) => DropdownMenuItem(
                        value: element,
                        child: SizedBox(
                          width: Get.width * 0.7,
                          child: Text(
                            element.nama!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (val) {
                controller.selectedTitikPantau.value = val;
              }))
        ],
      ),
    );
  }
}
