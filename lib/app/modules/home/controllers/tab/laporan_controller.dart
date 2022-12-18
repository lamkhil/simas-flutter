import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simas/app/data/services/home_services.dart';
import 'package:simas/app/global/widget/error.dart';
import 'package:simas/app/global/widget/loading.dart';
import 'package:simas/app/modules/home/controllers/home_controller.dart';

class LaporanController extends GetxController
    with StateMixin<Map<String, dynamic>> {
  @override
  void onInit() {
    getLaporan();
    super.onInit();
  }

  Future<void> getLaporan({String? url}) async {
    change(null, status: RxStatus.loading());
    final result = await HomeServices.getLaporan(url: url);
    if (result.success) {
      change(result.data, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(result.message));
    }
  }

  Future<void> downloadExcel() async {
    if (value?['data'].isNotEmpty ?? false) {
      int tahun = int.tryParse(value!['data'][0]['tahun'].toString()) ?? 0;
      var excel = Excel.createExcel();
      Sheet s = excel['Sheet1'];
      // buat judul sheet =====================================================
      s.merge(CellIndex.indexByString('${column.first}1'),
          CellIndex.indexByString('${column.last}1'));
      s.cell(CellIndex.indexByString('${column.first}1')).value =
          "HASIL PENGUJIAN PEMANTAUAN KUALITAS AIR TAHUN $tahun TAHAP 1 & 2";

      s.cell(CellIndex.indexByString("A1")).cellStyle = CellStyle(
          horizontalAlign: HorizontalAlign.Center,
          verticalAlign: VerticalAlign.Center,
          fontSize: 20,
          bold: true);
      s.merge(CellIndex.indexByString("A3"), CellIndex.indexByString("A5"));
      s.cell(CellIndex.indexByString("A3")).value = "NO.";
      s.merge(CellIndex.indexByString("B3"), CellIndex.indexByString("B5"));
      s.cell(CellIndex.indexByString("B3")).value = "PARAMETER";
      s.merge(CellIndex.indexByString("C3"), CellIndex.indexByString("C5"));
      s.cell(CellIndex.indexByString("C3")).value = "SATUAN";
      s.merge(CellIndex.indexByString("D3"), CellIndex.indexByString("D5"));
      s.cell(CellIndex.indexByString("D3")).value = "BAKU MUTU**)";

      s.cell(CellIndex.indexByString("A3")).cellStyle = CellStyle(
          horizontalAlign: HorizontalAlign.Center,
          verticalAlign: VerticalAlign.Center,
          fontSize: 10,
          bold: true);
      s.cell(CellIndex.indexByString("B3")).cellStyle = CellStyle(
          horizontalAlign: HorizontalAlign.Center,
          verticalAlign: VerticalAlign.Center,
          fontSize: 10,
          bold: true);
      s.cell(CellIndex.indexByString("C3")).cellStyle = CellStyle(
          horizontalAlign: HorizontalAlign.Center,
          verticalAlign: VerticalAlign.Center,
          fontSize: 10,
          bold: true);
      s.cell(CellIndex.indexByString("D3")).cellStyle = CellStyle(
          horizontalAlign: HorizontalAlign.Center,
          verticalAlign: VerticalAlign.Center,
          fontSize: 10,
          bold: true);
      var titikPantauCell = 4;

      dynamic kualitas1 = (value!['data'] as List)
          .where((element) => element['tahap'].toString() == "1")
          .toList();
      dynamic kualitas2 = (value!['data'] as List)
          .where((element) => element['tahap'].toString() == "2")
          .toList();

      if (kualitas1.isEmpty) {
        kualitas1 = null;
      } else {
        kualitas1 = kualitas1.first;
      }
      if (kualitas2.isEmpty) {
        kualitas2 = null;
      } else {
        kualitas2 = kualitas2.first;
      }

//=============================================================
      s.merge(CellIndex.indexByString('${column.first}6'),
          CellIndex.indexByString('${column.last}6'));
      s.cell(CellIndex.indexByString('${column.first}6')).value = "A. FISIKA";
      s.cell(CellIndex.indexByString('${column.first}6')).cellStyle = CellStyle(
          verticalAlign: VerticalAlign.Center, fontSize: 10, bold: true);

      s.merge(CellIndex.indexByString('${column.first}12'),
          CellIndex.indexByString('${column.last}12'));
      s.cell(CellIndex.indexByString('${column.first}12')).value = "B. KIMIA";
      s.cell(CellIndex.indexByString('${column.first}12')).cellStyle =
          CellStyle(
              verticalAlign: VerticalAlign.Center, fontSize: 10, bold: true);

      s.merge(CellIndex.indexByString('${column.first}42'),
          CellIndex.indexByString('${column.last}42'));
      s.cell(CellIndex.indexByString('${column.first}42')).value =
          "C. MIKRO BIOLOGI";
      s.cell(CellIndex.indexByString('${column.first}42')).cellStyle =
          CellStyle(
              verticalAlign: VerticalAlign.Center, fontSize: 10, bold: true);
      //=============================================================
      // No. Fisika
      for (var i = 0; i < 5; i++) {
        s.cell(CellIndex.indexByString('${column.first}${7 + i}')).value =
            "${1 + i}";
        s.cell(CellIndex.indexByString('${column[1]}${7 + i}')).value =
            parameter[i];

        s.cell(CellIndex.indexByString('${column[2]}${7 + i}')).value =
            satuan[i];

        s.cell(CellIndex.indexByString('${column[3]}${7 + i}')).value =
            bakuMutu[i];
      }
//=============================================================
      // No. KIMIA
      for (var i = 0; i < 29; i++) {
        s.cell(CellIndex.indexByString('${column.first}${13 + i}')).value =
            "${1 + i}";

        s.cell(CellIndex.indexByString('${column[1]}${13 + i}')).value =
            parameter[5 + i];

        s.cell(CellIndex.indexByString('${column[2]}${13 + i}')).value =
            satuan[5 + i];
        s.cell(CellIndex.indexByString('${column[3]}${13 + i}')).value =
            bakuMutu[5 + i];
      }
      //=============================================================
      // No. Mikro Biologi
      for (var i = 0; i < 2; i++) {
        s.cell(CellIndex.indexByString('${column.first}${43 + i}')).value =
            "${1 + i}";

        s.cell(CellIndex.indexByString('${column[1]}${43 + i}')).value =
            parameter[34 + i];

        s.cell(CellIndex.indexByString('${column[2]}${43 + i}')).value =
            satuan[34 + i];
        s.cell(CellIndex.indexByString('${column[3]}${43 + i}')).value =
            bakuMutu[34 + i];
      }
      for (var i = 0; i < Get.find<HomeController>().titikPantau.length; i++) {
        final titikPantau = Get.find<HomeController>().titikPantau[i];
        s.merge(CellIndex.indexByString("${column[titikPantauCell++]}4"),
            CellIndex.indexByString("${column[titikPantauCell++]}4"));
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}4"))
            .value = Get.find<HomeController>().titikPantau[i].nama;

        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}5"))
            .value = "TAHAP 1";
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}5"))
            .value = "TAHAP 2";
        s
                .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}4"))
                .cellStyle =
            CellStyle(
                horizontalAlign: HorizontalAlign.Center,
                verticalAlign: VerticalAlign.Center,
                textWrapping: TextWrapping.WrapText,
                fontSize: 10,
                bold: true);

        s
                .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}5"))
                .cellStyle =
            CellStyle(
                horizontalAlign: HorizontalAlign.Center,
                verticalAlign: VerticalAlign.Center,
                fontSize: 10,
                bold: true);

        s
                .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}5"))
                .cellStyle =
            CellStyle(
                horizontalAlign: HorizontalAlign.Center,
                verticalAlign: VerticalAlign.Center,
                fontSize: 10,
                bold: true);

        dynamic kualitasT1 = kualitas1?['kualitas']
                .where((element) =>
                    element['titik_pantau_id'].toString() ==
                    titikPantau.id.toString())
                .toList() ??
            [];
        dynamic kualitasT2 = kualitas2?['kualitas']
                .where((element) =>
                    element['titik_pantau_id'].toString() ==
                    titikPantau.id.toString())
                .toList() ??
            [];
        if (kualitasT1.isEmpty) {
          kualitasT1 = null;
        } else {
          kualitasT1 = kualitasT1.first;
        }
        if (kualitasT2.isEmpty) {
          kualitasT2 = null;
        } else {
          kualitasT2 = kualitasT2.first;
        }

        // FISIKA field ===========================================
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}7"))
            .value = kualitasT1?['suhu'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}7"))
            .value = kualitasT2?['suhu'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}8"))
            .value = kualitasT1?['tds'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}8"))
            .value = kualitasT2?['tds'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}9"))
            .value = kualitasT1?['tss'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}9"))
            .value = kualitasT2?['tss'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}10"))
            .value = kualitasT1?['warna'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}10"))
            .value = kualitasT2?['warna'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}11"))
            .value = "Nihil";
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}11"))
            .value = "Nihil";

        // KIMIA field ===========================================
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}13"))
            .value = kualitasT1?['ph'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}13"))
            .value = kualitasT2?['ph'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}14"))
            .value = kualitasT1?['bod'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}14"))
            .value = kualitasT2?['bod'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}15"))
            .value = kualitasT1?['cod'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}15"))
            .value = kualitasT2?['cod'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}16"))
            .value = kualitasT1?['do'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}16"))
            .value = kualitasT2?['do'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}17"))
            .value = kualitasT1?['phospat'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}17"))
            .value = kualitasT2?['phospat'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}18"))
            .value = kualitasT1?['nitrat'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}18"))
            .value = kualitasT2?['nitrat'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}19"))
            .value = kualitasT1?['amonia'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}19"))
            .value = kualitasT2?['amonia'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}20"))
            .value = kualitasT1?['arsen'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}20"))
            .value = kualitasT2?['arsen'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}21"))
            .value = kualitasT1?['kobalt'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}21"))
            .value = kualitasT2?['kobalt'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}22"))
            .value = kualitasT1?['boron'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}22"))
            .value = kualitasT2?['boron'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}23"))
            .value = kualitasT1?['selenium'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}23"))
            .value = kualitasT2?['selenium'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}24"))
            .value = kualitasT1?['kadium'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}24"))
            .value = kualitasT2?['kadium'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}25"))
            .value = kualitasT1?['tembaga'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}25"))
            .value = kualitasT2?['tembaga'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}26"))
            .value = kualitasT1?['timbal'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}26"))
            .value = kualitasT2?['timbal'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}27"))
            .value = kualitasT1?['merkuri'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}27"))
            .value = kualitasT2?['merkuri'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}28"))
            .value = kualitasT1?['seng'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}28"))
            .value = kualitasT2?['seng'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}29"))
            .value = kualitasT1?['sianida'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}29"))
            .value = kualitasT2?['sianida'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}30"))
            .value = kualitasT1?['flourida'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}30"))
            .value = kualitasT2?['flourida'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}31"))
            .value = kualitasT1?['nitrit'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}31"))
            .value = kualitasT2?['nitrit'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}32"))
            .value = kualitasT1?['khlorin'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}32"))
            .value = kualitasT2?['khlorin'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}33"))
            .value = kualitasT1?['belerang'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}33"))
            .value = kualitasT2?['belerang'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}34"))
            .value = kualitasT1?['klorida'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}34"))
            .value = kualitasT2?['klorida'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}35"))
            .value = kualitasT1?['sulfat'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}35"))
            .value = kualitasT2?['sulfat'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}36"))
            .value = kualitasT1?['minyak'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}36"))
            .value = kualitasT2?['minyak'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}37"))
            .value = kualitasT1?['deterjen'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}37"))
            .value = kualitasT2?['deterjen'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}38"))
            .value = kualitasT1?['phenol'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}38"))
            .value = kualitasT2?['phenol'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}39"))
            .value = kualitasT1?['nikel'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}39"))
            .value = kualitasT2?['nikel'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}40"))
            .value = kualitasT1?['n_total'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}40"))
            .value = kualitasT2?['n_total'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}41"))
            .value = kualitasT1?['kromium6'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}41"))
            .value = kualitasT2?['kromium6'] ?? 'NaN';
        // C. Mikro Biologi ============================================
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}43"))
            .value = kualitasT1?['total_koliform'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}43"))
            .value = kualitasT2?['total_koliform'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 2]}44"))
            .value = kualitasT1?['fecal_kolifom'] ?? 'NaN';
        s
            .cell(CellIndex.indexByString("${column[titikPantauCell - 1]}44"))
            .value = kualitasT2?['fecal_kolifom'] ?? 'NaN';
      }

      var directory = Directory('');
      String label = tahun.toString();
      if (Platform.isAndroid) {
        try {
          if ((await Permission.storage.request()).isGranted) {
            Directory? tempPath = await getExternalStorageDirectory();
            String nwDirectory = "${tempPath!.path.split('Android')[0]}SIMAs";
            directory = Directory(nwDirectory);
          } else {
            ErrorDialog.basic("Izin tidak diberikan");
          }
        } catch (e) {
          ErrorDialog.basic("Terjadi kesalahan sistem");
        }
      }
      try {
        if ((await Permission.manageExternalStorage.request()).isGranted) {
          LoadingDialog.basic();
          var specialName = label.replaceAll('/', '');
          String path = "${directory.path}/Laporan SIMAs ($specialName).xlsx";
          if (await directory.exists()) {
            File(join(path))
              ..createSync(recursive: true)
              ..writeAsBytesSync(excel.encode()!);
            Get.back();
          } else {
            await directory.create(recursive: true);
            File(join(path))
              ..createSync(recursive: true)
              ..writeAsBytesSync(excel.encode()!);
            Get.back();
          }
          Get.snackbar("Sucess", "Data berhasil disimpan",
              snackPosition: SnackPosition.BOTTOM);
        } else {
          ErrorDialog.basic("Izin tidak diberikan");
        }
      } catch (e) {
        ErrorDialog.basic("Terjadi kesalahan sistem");
      }
    }
  }
}

final satuan = [
  "°C",
  "mg/L",
  "mg/L",
  "TCU",
  "-",
  "-",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "mg/L",
  "MPN / 100 ml",
  "MPN / 100 ml",
];

final bakuMutu = [
  "Deviasi 3***)",
  "1000",
  "50",
  "50",
  "Nihil",
  "6-9",
  "3",
  "25",
  "4**)",
  "0.2",
  "10",
  "0.2",
  "0.05",
  "0.2",
  "1",
  "0.05",
  "0.01",
  "0.02",
  "0.03",
  "0.002",
  "0.05",
  "0.02",
  "1.5",
  "0.06",
  "0.03",
  "0.002",
  "300",
  "300",
  "1",
  "0.2",
  "0.005",
  "0.05",
  "15",
  "0.05",
  "5000",
  "1000"
];

final parameter = [
  "Suhu",
  "Residu Terlarut (TDS)",
  "Padatan Tersuspensi (TSS)",
  "Warna*)",
  "Sampah",
  "pH",
  "BOD5",
  "COD",
  "DO",
  "Phospat total sebagai P*",
  "Nitrat (NO3-N) total",
  "Amonia (NH3-N) total",
  "Arsen (As)",
  "Kobalt (Co)",
  "Boron (Bo)",
  "Selenium (Se)",
  "Kadmium (Cd)",
  "Tembaga (Cu)",
  "Timbal (Pb)",
  "Merkuri (Hg)*)",
  "Seng (Zn)",
  "Sianida (CN)*)",
  "Flourida (F)",
  "Nitrit (NO2-N)",
  "Khlorin Bebas*)",
  "Belerang sebagai H2S*)",
  "Klorida (Cl)",
  "Sulfat (SO4)",
  "Minyak dan Lemak*)",
  "Deterjen sebagai MBAS*)",
  "Phenol",
  "Nikel (Ni)",
  "N-Total*)",
  "Kromium VI (Cr6+)*)",
  "Total Koliform*)",
  "Fecal Koliform*)"
];

final column = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
  'AA',
  'AB',
  'AC',
  'AD',
  'AE',
  'AF',
  'AG',
  'AH',
  'AI',
  'AJ',
  'AK',
  'AL',
  'AM',
  'AN',
  'AO',
  'AP',
  'AQ',
  'AR'
];
