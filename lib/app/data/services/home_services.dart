import 'package:get_storage/get_storage.dart';
import 'package:simas/app/data/models/response_api.dart';
import 'package:simas/app/data/models/titik_pantau_model.dart';

import '../../network/config.dart';

class HomeServices {
  HomeServices._();

  static const _titikPantauUrl = '/titik-pantau/';

  static Future<ResponseApi<List<TitikPantau>?>> getTitikPantauAll() async {
    try {
      final result = await dio.get(_titikPantauUrl);
      if (result.data['status']) {
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
    } catch (e) {
      return ResponseApi(data: null, message: "Server Error", success: false);
    }
  }
}
