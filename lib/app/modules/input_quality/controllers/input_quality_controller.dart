import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:simas/app/data/models/input_kualitas_model.dart';
import 'package:simas/app/data/models/titik_pantau_model.dart';
import 'package:simas/app/data/services/admin_services.dart';
import 'package:simas/app/global/controller/controller.dart';
import 'package:simas/app/global/widget/error.dart';
import 'package:simas/app/global/widget/loading.dart';

class InputQualityController extends GetxController {
  final titikPantau = Get.find<ControllerApp>().titikPantau;

  final selectedTitikPantau = Rx<TitikPantau?>(null);
  final selectedTahap = Rx<String?>(null);

  TextEditingController waktuSamplingController = TextEditingController();
  TextEditingController temperaturController = TextEditingController();
  TextEditingController tdsController = TextEditingController();
  TextEditingController tssController = TextEditingController();
  TextEditingController warnaController = TextEditingController();
  TextEditingController pHController = TextEditingController();
  TextEditingController bodController = TextEditingController();
  TextEditingController codController = TextEditingController();
  TextEditingController doController = TextEditingController();
  TextEditingController phospatController = TextEditingController();
  TextEditingController nitratController = TextEditingController();
  TextEditingController amoniaController = TextEditingController();
  TextEditingController arsenController = TextEditingController();
  TextEditingController kobaltController = TextEditingController();
  TextEditingController boronController = TextEditingController();
  TextEditingController seleniumController = TextEditingController();
  TextEditingController kadmiumController = TextEditingController();
  TextEditingController tembagaController = TextEditingController();
  TextEditingController timbalController = TextEditingController();
  TextEditingController merkuriController = TextEditingController();
  TextEditingController sengController = TextEditingController();
  TextEditingController sianidaController = TextEditingController();
  TextEditingController flouridaController = TextEditingController();
  TextEditingController nitritController = TextEditingController();
  TextEditingController khlorinController = TextEditingController();
  TextEditingController belerangController = TextEditingController();
  TextEditingController kloridaController = TextEditingController();
  TextEditingController sulfatController = TextEditingController();
  TextEditingController minyakController = TextEditingController();
  TextEditingController deterjenController = TextEditingController();
  TextEditingController phenolController = TextEditingController();
  TextEditingController nikelController = TextEditingController();
  TextEditingController nTotalController = TextEditingController();
  TextEditingController kromiumController = TextEditingController();
  TextEditingController totalKoliformController = TextEditingController();
  TextEditingController fecalKoliformController = TextEditingController();

  @override
  void onClose() {
    waktuSamplingController.dispose();
    temperaturController.dispose();
    tdsController.dispose();
    tssController.dispose();
    warnaController.dispose();
    pHController.dispose();
    bodController.dispose();
    codController.dispose();
    doController.dispose();
    phospatController.dispose();
    nitratController.dispose();
    amoniaController.dispose();
    arsenController.dispose();
    kobaltController.dispose();
    boronController.dispose();
    seleniumController.dispose();
    kadmiumController.dispose();
    tembagaController.dispose();
    timbalController.dispose();
    merkuriController.dispose();
    sengController.dispose();
    sianidaController.dispose();
    flouridaController.dispose();
    nitritController.dispose();
    khlorinController.dispose();
    belerangController.dispose();
    kloridaController.dispose();
    sulfatController.dispose();
    minyakController.dispose();
    deterjenController.dispose();
    phenolController.dispose();
    nikelController.dispose();
    nTotalController.dispose();
    kromiumController.dispose();
    totalKoliformController.dispose();
    fecalKoliformController.dispose();
    super.onClose();
  }

  Future<void> onSave() async {
    if (selectedTahap.value == null) {
      return;
    }
    if (selectedTitikPantau.value == null) {
      return;
    }
    LoadingDialog.basic();
    final result = await AdminServices.addKualitas(
        kualitasAir: KualitasAir(
      waktu: waktuSamplingController.text,
      tahap: int.parse(selectedTahap.value!),
      titik_pantau_id: selectedTitikPantau.value!.id,
      suhu: double.tryParse(temperaturController.text.replaceAll(',', '.')),
      tds: double.tryParse(tdsController.text.replaceAll(',', '.')),
      warna: double.tryParse(warnaController.text.replaceAll(',', '.')),
      tss: double.tryParse(tssController.text.replaceAll(',', '.')),
      ph: double.tryParse(pHController.text.replaceAll(',', '.')),
      bod: double.tryParse(bodController.text.replaceAll(',', '.')),
      cod: double.tryParse(codController.text.replaceAll(',', '.')),
      do_: double.tryParse(doController.text.replaceAll(',', '.')),
      phospat: double.tryParse(phospatController.text.replaceAll(',', '.')),
      nitrat: double.tryParse(nitratController.text.replaceAll(',', '.')),
      amonia: double.tryParse(amoniaController.text.replaceAll(',', '.')),
      arsen: double.tryParse(arsenController.text.replaceAll(',', '.')),
      kobalt: double.tryParse(kobaltController.text.replaceAll(',', '.')),
      boron: double.tryParse(boronController.text.replaceAll(',', '.')),
      selenium: double.tryParse(seleniumController.text.replaceAll(',', '.')),
      kadium: double.tryParse(kadmiumController.text.replaceAll(',', '.')),
      tembaga: double.tryParse(tembagaController.text.replaceAll(',', '.')),
      timbal: double.tryParse(timbalController.text.replaceAll(',', '.')),
      merkuri: double.tryParse(merkuriController.text.replaceAll(',', '.')),
      seng: double.tryParse(sengController.text.replaceAll(',', '.')),
      sianida: double.tryParse(sianidaController.text.replaceAll(',', '.')),
      flourida: double.tryParse(flouridaController.text.replaceAll(',', '.')),
      khlorin: double.tryParse(khlorinController.text.replaceAll(',', '.')),
      nitrit: double.tryParse(nitritController.text.replaceAll(',', '.')),
      belerang: double.tryParse(belerangController.text.replaceAll(',', '.')),
      klorida: double.tryParse(kloridaController.text.replaceAll(',', '.')),
      minyak: double.tryParse(minyakController.text.replaceAll(',', '.')),
      sulfat: double.tryParse(sulfatController.text.replaceAll(',', '.')),
      phenol: double.tryParse(phenolController.text.replaceAll(',', '.')),
      deterjen: double.tryParse(deterjenController.text.replaceAll(',', '.')),
      n_total: double.tryParse(nTotalController.text.replaceAll(',', '.')),
      nikel: double.tryParse(nikelController.text.replaceAll(',', '.')),
      total_koliform:
          double.tryParse(totalKoliformController.text.replaceAll(',', '.')),
      fecal_kolifom:
          double.tryParse(fecalKoliformController.text.replaceAll(',', '.')),
    ));
    if (result.success) {
      //refresh data
      Get.back();
      Get.back();
    } else {
      Get.back();
      ErrorDialog.basic(result.message);
    }
  }
}
