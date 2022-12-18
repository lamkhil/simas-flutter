import 'package:intl/intl.dart';
import 'package:simas/app/data/models/input_kualitas_model.dart';

class WaktuSampling {
  final int id;
  final String waktu;
  final int tahun;
  final int tahap;
  final List<KualitasAir> kualitas;

  WaktuSampling(
      {required this.waktu,
      required this.tahun,
      required this.tahap,
      required this.kualitas,
      required this.id});

  factory WaktuSampling.fromJson(Map<String, dynamic> json) => WaktuSampling(
      waktu: DateFormat('dd-MM-yyyy')
          .format(DateFormat('yyyy-MM-dd').parse(json['waktu'])),
      tahun: int.tryParse(json['tahun'].toString()) ?? 0,
      tahap: int.tryParse(json['tahap'].toString()) ?? 0,
      kualitas: json['kualitas'] != null
          ? (json['kualitas'] as List)
              .map((e) => KualitasAir.fromJson(e))
              .toList()
          : [],
      id: json['id']);
}
