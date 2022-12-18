import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:simas/app/data/services/home_services.dart';

import '../../controllers/tab/laporan_controller.dart';

class LaporanTab extends GetView<LaporanController> {
  LaporanTab({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => successState(state!),
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        onError: (err) => Center(
              child: Text(err ?? 'Server Error'),
            ));
  }

  Padding successState(Map<String, dynamic> state) {
    List<Map<String, dynamic>> data = <Map<String, dynamic>>[];
    for (var sampling in (state['data'] as List)) {
      for (Map<String, dynamic> kualitas in (sampling['kualitas'] as List)) {
        data.add(kualitas
          ..['tahap'] = sampling['tahap']
          ..['titikpantau'] = kualitas['titik_pantau']['nama']);
      }
    }
    List<PlutoColumn> columns = <PlutoColumn>[
      PlutoColumn(
          title: 'Titik Pantau',
          field: 'titikpantau',
          type: PlutoColumnType.text(),
          readOnly: true),
      PlutoColumn(
        title: 'Tahap',
        field: 'tahap',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Waktu Sampling',
        field: 'waktu',
        type: PlutoColumnType.text(),
        readOnly: true,
      ),
      PlutoColumn(
          title: 'IKA',
          field: 'ika',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'STATUS',
          field: 'status',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Suhu (°C)',
          field: 'suhu',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Residu Terlarut (TDS)',
          field: 'tds',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Padatan Tersuspensi (TSS)',
          field: 'tss',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Warna*)',
          field: 'warna',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'pH',
          field: 'ph',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'BOD5',
          field: 'bod',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'COD',
          field: 'cod',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'DO',
          field: 'do',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Phospat total sebagai P*',
          field: 'phospat',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Nitrat (NO3-N) total',
          field: 'nitrat',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Amonia (NH3-N) total',
          field: 'amonia',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Arsen (As)',
          field: 'arsen',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Kobalt (Co)',
          field: 'kobalt',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Boron (Bo)',
          field: 'boron',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Selenium (Se)',
          field: 'selenium',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Kadmium (Cd)',
          field: 'kadium',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Tembaga (Cu)',
          field: 'tembaga',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Timbal (Pb)',
          field: 'timbal',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Merkuri (Hg)*)',
          field: 'merkuri',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Seng (Zn)',
          field: 'seng',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Sianida (CN)*)',
          field: 'sianida',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Flourida (F)',
          field: 'flourida',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Nitrit (NO2-N)',
          field: 'nitrit',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Khlorin Bebas*)',
          field: 'khlorin',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Belerang sebagai H2S*)',
          field: 'belerang',
          readOnly: true,
          type: PlutoColumnType.text(),
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Klorida (Cl)',
          field: 'klorida',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Sulfat (SO4)',
          field: 'sulfat',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Minyak dan Lemak*)',
          field: 'minyak',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Deterjen sebagai MBAS*)',
          field: 'deterjen',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Phenol',
          field: 'phenol',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Nikel (Ni)',
          field: 'nikel',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'N-Total*)',
          field: 'n_total',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Kromium VI (Cr6+)*)',
          field: 'kromium6',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Total Koliform*)',
          field: 'total_koliform',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
      PlutoColumn(
          title: 'Fecal Koliform*)',
          field: 'fecal_kolifom',
          type: PlutoColumnType.text(),
          readOnly: true,
          textAlign: PlutoColumnTextAlign.center),
    ];
    List<PlutoRow> rows = [
      ...data
          .map(
            (e) => PlutoRow(
              cells: {
                for (var col in columns)
                  col.field: PlutoCell(value: e[col.field])
              },
            ),
          )
          .toList()
    ];

    /// columnGroups that can group columns can be omitted.
    List<PlutoColumnGroup> columnGroups = [];
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await controller.getLaporan();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Laporan",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          controller.downloadExcel();
                        },
                        child: Row(
                          children: [
                            const Text(
                              "Download File",
                              style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.underline),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            SizedBox(
                                height: 36,
                                width: 36,
                                child: Image.asset('assets/excel.png'))
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: PlutoGrid(
            columns: columns,
            rows: rows,
            columnGroups: columnGroups,
            onLoaded: (PlutoGridOnLoadedEvent event) {},
            onChanged: (PlutoGridOnChangedEvent event) {},
            configuration: const PlutoGridConfiguration(),
          )),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: state['next_page_url'] != null
                      ? () {
                          controller.getLaporan(url: state['next_page_url']);
                        }
                      : null,
                  child: const Text("<")),
              const SizedBox(
                width: 12,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.getLaporan();
                  },
                  child: Text(state['data'][0]['tahun'])),
              const SizedBox(
                width: 12,
              ),
              ElevatedButton(
                  onPressed: state['prev_page_url'] != null
                      ? () {
                          controller.getLaporan(url: state['prev_page_url']);
                        }
                      : null,
                  child: const Text(">")),
            ],
          )
        ],
      ),
    );
  }
}
