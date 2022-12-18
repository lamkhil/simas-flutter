import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:simas/app/data/models/response_api.dart';
import 'package:simas/app/data/models/titik_pantau_model.dart';
import 'package:simas/app/data/models/waktu_sampling_model.dart';

import '../../network/config.dart';

class HomeServices {
  HomeServices._();

  static const _titikPantauUrl = '/titik-pantau';
  static const _kualitasUrl = '/kualitas';
  static const _berandaUrl = '/beranda';
  static const _laporanUrl = '/laporan';

  static Future<ResponseApi<List<TitikPantau>?>> getTitikPantauAll() async {
    try {
      final result = await dio.get(_titikPantauUrl);
      if (result.data['status'] ?? false) {
        GetStorage().write('titikPantau', result.data['data']);
        return ResponseApi(
            data: (result.data['data'] as List)
                .map((e) => TitikPantau.fromJson(e))
                .toList(),
            success: true);
      } else {
        return ResponseApi(
            data: null, message: result.data['message'], success: false);
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return ResponseApi(data: null, message: "Server Error", success: false);
    }
  }

  static Future<ResponseApi<List<WaktuSampling>?>> getKualitasAll() async {
    try {
      final result = await dio.get(_kualitasUrl);
      if (result.data['status'] ?? false) {
        GetStorage().write('kualitas', result.data['data']);
        return ResponseApi(
            data: (result.data['data'] as List)
                .map((e) => WaktuSampling.fromJson(e))
                .toList(),
            success: true);
      } else {
        return ResponseApi(
            data: null, message: result.data['message'], success: false);
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return ResponseApi(data: null, message: "Server Error", success: false);
    }
  }

  static Future<ResponseApi<Map<String, dynamic>?>> getDataBeranda() async {
    try {
      final result = await dio.get(_berandaUrl);
      if (result.data['status'] ?? false) {
        GetStorage().write('beranda', result.data['data']);
        return ResponseApi(data: result.data['data'], success: true);
      } else {
        return ResponseApi(
            data: null, message: result.data['message'], success: false);
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return ResponseApi(data: null, message: "Server Error", success: false);
    }
  }

  static Future<ResponseApi<Map<String, dynamic>?>> getLaporan(
      {String? url}) async {
    try {
      final result = await dio.get(url ?? _laporanUrl);

      GetStorage().write('laporan', result.data);
      return ResponseApi(data: result.data, success: true);
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return ResponseApi(data: null, message: "Server Error", success: false);
    }
  }
}
