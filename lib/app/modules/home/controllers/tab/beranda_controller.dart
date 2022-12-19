import 'package:get/get.dart';
import 'package:simas/app/data/services/home_services.dart';

class BerandaController extends GetxController
    with StateMixin<Map<String, dynamic>> {
  Rx<String?> parameter = Rx(null);

  RxList<bool> titikPantauShowParameter =
      List.generate(20, (index) => false).obs;

  final Rx<int> indexParameter = (-1).obs;

  List<String> parameterList = [
    "tss",
    "suhu",
    "tds",
    "warna",
    "ph",
    "bod",
    "cod",
    "do",
    "phospat",
    "nitrat",
    "amonia",
    "arsen",
    "kobalt",
    "boron",
    "selenium",
    "kadium",
    "tembaga",
    "timbal",
    "merkuri",
    "seng",
    "sianida",
    "flourida",
    "khlorin",
    "nitrit",
    "belerang",
    "klorida",
    "minyak",
    "sulfat",
    "phenol",
    "deterjen",
    "n_total",
    "nikel",
    "total_koliform",
    "fecal_kolifom",
    "kromium6",
  ];
  List<String> parameterListView = [
    "TSS",
    "Suhu",
    "TDS",
    "Warna",
    "pH",
    "BOD",
    "COD",
    "DO",
    "Phospat",
    "Nitrat",
    "Amonia",
    "Arsen",
    "Kobalt",
    "Boron",
    "Selenium",
    "Kadium",
    "Tembaga",
    "Timbal",
    "Merkuri",
    "Seng",
    "Sianida",
    "Flourida",
    "Khlorin",
    "Nitrit",
    "Belerang",
    "Klorida",
    "Minyak",
    "Sulfat",
    "Phenol",
    "Deterjen",
    "N Total",
    "Nikel",
    "Total Kolifom",
    "Fecal Kolifom",
    "Kromium6+",
  ];

  @override
  void onInit() {
    titikPantauShowParameter[0] = true;
    super.onInit();
  }

  Future<void> getDataBeranda() async {
    change(null, status: RxStatus.loading());
    final result = await HomeServices.getDataBeranda();
    if (result.success) {
      change(result.data, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error(result.message));
    }
  }
}
