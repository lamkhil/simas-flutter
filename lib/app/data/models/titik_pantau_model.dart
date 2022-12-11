class TitikPantau {
  int? id;
  String? nama;
  String? desa;
  String? kecamatan;
  double? longitude;
  double? latitude;
  String? createdAt;
  String? updatedAt;

  TitikPantau(
      {this.id,
      this.nama,
      this.desa,
      this.kecamatan,
      this.longitude,
      this.latitude,
      this.createdAt,
      this.updatedAt});

  TitikPantau.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    desa = json['desa'];
    kecamatan = json['kecamatan'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
