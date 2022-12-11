// ignore_for_file: non_constant_identifier_names

class Summary {
  String? ika;
  String? ika_comparison;
  String? ketinggan_air;
  Map<String, dynamic>? ika_terendah;
  String? ketinggian_comparison;
  String? tingkat_kecemaran;

  Summary(
      {this.tingkat_kecemaran,
      this.ketinggian_comparison,
      this.ketinggan_air,
      this.ika_terendah,
      this.ika_comparison,
      this.ika});

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        ika: json['ika'].toString(),
        ika_comparison: json['ika_comparison'].toString(),
        ketinggan_air: json['ketinggan_air'].toString(),
        ika_terendah: json['ika_terendah'],
        ketinggian_comparison: json['ketinggian_comparison'].toString(),
        tingkat_kecemaran: json['tingkat_kecemaran'].toString(),
      );
}
