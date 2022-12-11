import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simas/app/data/models/input_kualitas_model.dart';
import 'package:simas/app/data/models/response_api.dart';
import 'package:simas/app/data/models/user_model.dart';
import 'package:simas/app/network/config.dart';

class AdminServices {
  AdminServices._();

  static const _loginUrl = '/login';
  static const _kualitasAddUrl = '/kualitas/add';

  static Future<ResponseApi<User?>> login(
      {required String email, required String password}) async {
    try {
      final result = await dio
          .post(_loginUrl, data: {'email': email, 'password': password});
      if (result.data['status']) {
        GetStorage().write('user', result.data['data']);
        GetStorage().write('token', result.data['data']['token']);
        return ResponseApi(
            data: User.fromJson(result.data['data']), success: true);
      } else {
        return ResponseApi(
            data: null, message: result.data['message'], success: false);
      }
    } catch (e) {
      return ResponseApi(data: null, message: "Server Error", success: false);
    }
  }

  static Future<ResponseApi<KualitasAir?>> addKualitas(
      {required KualitasAir kualitasAir}) async {
    try {
      final result =
          await dio.post(_kualitasAddUrl, data: kualitasAir.toJson());
      if (result.data['status']) {
        return ResponseApi(
            data: KualitasAir.fromJson(result.data['data']), success: true);
      } else {
        return ResponseApi(
            data: null, message: result.data['message'], success: false);
      }
    } catch (e) {
      return ResponseApi(data: null, message: "Server Error", success: false);
    }
  }
}
