// ignore_for_file: non_constant_identifier_names

import 'package:simas/app/data/models/titik_pantau_model.dart';

class KualitasAir {
  int? id;
  String? waktu;
  String? status;
  int? tahap;
  int? titik_pantau_id;
  double? ika;
  double? ipj;
  double? kromium;
  double? suhu;
  double? tds;
  double? warna;
  double? tss;
  double? ph;
  double? bod;
  double? cod;
  double? do_;
  double? phospat;
  double? nitrat;
  double? amonia;
  double? arsen;
  double? kobalt;
  double? boron;
  double? selenium;
  double? kadium;
  double? tembaga;
  double? timbal;
  double? merkuri;
  double? seng;
  double? sianida;
  double? flourida;
  double? khlorin;
  double? nitrit;
  double? belerang;
  double? klorida;
  double? minyak;
  double? sulfat;
  double? phenol;
  double? deterjen;
  double? n_total;
  double? nikel;
  double? total_koliform;
  double? fecal_kolifom;
  TitikPantau? titikPantau;

  KualitasAir(
      {this.waktu,
      this.tahap,
      this.titik_pantau_id,
      this.suhu,
      this.tds,
      this.warna,
      this.tss,
      this.ph,
      this.bod,
      this.cod,
      this.do_,
      this.phospat,
      this.nitrat,
      this.amonia,
      this.arsen,
      this.kobalt,
      this.boron,
      this.selenium,
      this.kadium,
      this.tembaga,
      this.timbal,
      this.merkuri,
      this.seng,
      this.sianida,
      this.flourida,
      this.status,
      this.khlorin,
      this.nitrit,
      this.belerang,
      this.klorida,
      this.minyak,
      this.sulfat,
      this.phenol,
      this.deterjen,
      this.n_total,
      this.nikel,
      this.total_koliform,
      this.fecal_kolifom,
      this.id,
      this.titikPantau,
      this.ika,
      this.ipj,
      this.kromium});

  factory KualitasAir.fromJson(Map<String, dynamic> json) => KualitasAir(
      id: json['id'],
      waktu: json['waktu'] is String ? json['waktu'] : json['waktu']['date'],
      tahap: json['tahap'],
      titik_pantau_id: int.tryParse(json['titik_pantau_id'].toString()),
      suhu: double.tryParse(json['suhu'].toString()),
      tds: double.tryParse(json['tds'].toString()),
      warna: double.tryParse(json['warna'].toString()),
      tss: double.tryParse(json['tss'].toString()),
      ph: double.tryParse(json['ph'].toString()),
      bod: double.tryParse(json['bod'].toString()),
      cod: double.tryParse(json['cod'].toString()),
      do_: double.tryParse(json['do'].toString()),
      phospat: double.tryParse(json['phospat'].toString()),
      nitrat: double.tryParse(json['nitrat'].toString()),
      amonia: double.tryParse(json['amonia'].toString()),
      arsen: double.tryParse(json['arsen'].toString()),
      kobalt: double.tryParse(json['kobalt'].toString()),
      boron: double.tryParse(json['boron'].toString()),
      selenium: double.tryParse(json['selenium'].toString()),
      kadium: double.tryParse(json['kadium'].toString()),
      tembaga: double.tryParse(json['tembaga'].toString()),
      timbal: double.tryParse(json['timbal'].toString()),
      merkuri: double.tryParse(json['merkuri'].toString()),
      seng: double.tryParse(json['seng'].toString()),
      sianida: double.tryParse(json['sianida'].toString()),
      flourida: double.tryParse(json['flourida'].toString()),
      khlorin: double.tryParse(json['khlorin'].toString()),
      nitrit: double.tryParse(json['nitrit'].toString()),
      belerang: double.tryParse(json['belerang'].toString()),
      klorida: double.tryParse(json['klorida'].toString()),
      minyak: double.tryParse(json['minyak'].toString()),
      sulfat: double.tryParse(json['sulfat'].toString()),
      phenol: double.tryParse(json['phenol'].toString()),
      deterjen: double.tryParse(json['deterjen'].toString()),
      n_total: double.tryParse(json['n_total'].toString()),
      nikel: double.tryParse(json['nikel'].toString()),
      total_koliform: double.tryParse(json['total_koliform'].toString()),
      fecal_kolifom: double.tryParse(json['fecal_kolifom'].toString()),
      kromium: double.tryParse(json['kromium6'].toString()),
      status: json['status'],
      titikPantau: json['titik_pantau'] != null
          ? TitikPantau.fromJson(json['titik_pantau'])
          : null,
      ika: double.tryParse(json['ika'].toString()),
      ipj: double.tryParse(json['ipj'].toString()));

  toJson() => {
        "waktu": waktu,
        "tahap": tahap,
        "titik_pantau_id": titik_pantau_id,
        "suhu": suhu,
        "tds": tds,
        "warna": warna,
        "tss": tss,
        "ph": ph,
        "bod": bod,
        "cod": cod,
        "do": do_,
        "phospat": phospat,
        "nitrat": nitrat,
        "amonia": amonia,
        "arsen": arsen,
        "kobalt": kobalt,
        "boron": boron,
        "selenium": selenium,
        "kadium": kadium,
        "tembaga": tembaga,
        "timbal": timbal,
        "merkuri": merkuri,
        "seng": seng,
        "sianida": sianida,
        "flourida": flourida,
        "khlorin": khlorin,
        "nitrit": nitrit,
        "belerang": belerang,
        "klorida": klorida,
        "minyak": minyak,
        "sulfat": sulfat,
        "phenol": phenol,
        "deterjen": deterjen,
        "n_total": n_total,
        "nikel": nikel,
        "total_koliform": total_koliform,
        "fecal_kolifom": fecal_kolifom,
        "kromium6": kromium,
        "status": status,
        'titik_pantau': titikPantau?.toJson(),
        "id": id,
      };
}
