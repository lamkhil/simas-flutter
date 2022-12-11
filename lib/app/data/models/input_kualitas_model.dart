// ignore_for_file: non_constant_identifier_names

class KualitasAir {
  int? id;
  String? waktu;
  int? tahap;
  int? titik_pantau_id;
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
      this.id});

  factory KualitasAir.fromJson(Map<String, dynamic> json) => KualitasAir(
        id: json['id'],
        waktu: json['waktu'],
        tahap: json['tahap'],
        titik_pantau_id: json['titik_pantau_id'],
        suhu: json['suhu'],
        tds: json['tds'],
        warna: json['warna'],
        tss: json['tss'],
        ph: json['ph'],
        bod: json['bod'],
        cod: json['cod'],
        do_: json['do_'],
        phospat: json['phospat'],
        nitrat: json['nitrat'],
        amonia: json['amonia'],
        arsen: json['arsen'],
        kobalt: json['kobalt'],
        boron: json['boron'],
        selenium: json['selenium'],
        kadium: json['kadium'],
        tembaga: json['tembaga'],
        timbal: json['timbal'],
        merkuri: json['merkuri'],
        seng: json['seng'],
        sianida: json['sianida'],
        flourida: json['flourida'],
        khlorin: json['khlorin'],
        nitrit: json['nitrit'],
        belerang: json['belerang'],
        klorida: json['klorida'],
        minyak: json['minyak'],
        sulfat: json['sulfat'],
        phenol: json['phenol'],
        deterjen: json['deterjen'],
        n_total: json['n_total'],
        nikel: json['nikel'],
        total_koliform: json['total_koliform'],
        fecal_kolifom: json['fecal_kolifom'],
      );

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
        "do_": do_,
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
        "fecal_kolifom": fecal_kolifom
      };
}
