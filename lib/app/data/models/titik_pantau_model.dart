import 'package:simas/app/data/models/input_kualitas_model.dart';

class TitikPantau {
  int? id;
  String? nama;
  String? desa;
  String? kecamatan;
  double? longitude;
  double? latitude;
  String? createdAt;
  String? updatedAt;
  String? foto;
  List<KualitasAir>? kualitas;
  List<dynamic>? kuantitas;
  TitikPantau(
      {this.id,
      this.nama,
      this.desa,
      this.kecamatan,
      this.longitude,
      this.latitude,
      this.createdAt,
      this.foto,
      this.updatedAt});

  TitikPantau.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    desa = json['desa'];
    kecamatan = json['kecamatan'];
    longitude = double.tryParse(json['longitude']);
    latitude = double.tryParse(json['latitude']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    foto = json['foto'] != null
        ? (json['foto'] as List).isNotEmpty
            ? "https://midtrans.takhruj.com${(json['foto'] as List).last['link']}"
            : null
        : null;
    kuantitas = json['kuantitas'];
    kualitas = json['kualitas'] != null
        ? (json['kualitas'] as List)
            .map((e) => KualitasAir.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['desa'] = desa;
    data['kecamatan'] = kecamatan;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
