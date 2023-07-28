class Golongan {
  final int id;
  final int total;
  final int tunjanganTetap;
  final int tunjanganTransportasi;
  final int gajiPokok;
  final String golongan;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Golongan({
    this.id = 0,
    this.total = 0,
    this.tunjanganTetap = 0,
    this.tunjanganTransportasi = 0,
    this.gajiPokok = 0,
    this.golongan = "",
    this.createdAt,
    this.updatedAt,
  });

  factory Golongan.fromJson(Map<String, dynamic> json) {
    return Golongan(
      id: json['data']['golongan']['id'],
      total: json['data']['golongan']['total'],
      tunjanganTetap: json['data']['golongan']['tunjangan_tetap'],
      tunjanganTransportasi: json['data']['golongan']['tunjangan_transportasi'],
      gajiPokok: json['data']['golongan']['gaji_pokok'],
      golongan: json['data']['golongan']['golongan'],
      createdAt: json['data']['golongan']['created_at'],
      updatedAt: json['data']['golongan']['updated_at'],
    );
  }
}