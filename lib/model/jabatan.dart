class Jabatan {
  final int id;
  final String jabatan;
  final String hakAkses;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Jabatan({
    this.id = 0,
    this.jabatan = "",
    this.hakAkses = "",
    this.createdAt,
    this.updatedAt,
  });

  factory Jabatan.fromJson(Map<String, dynamic> json) {
    return Jabatan(
      id: json['data']['jabatan']['id'],
      jabatan: json['data']['jabatan']['jabatan'],
      hakAkses: json['data']['jabatan']['hak_akses'],
      createdAt: json['data']['jabatan']['created_at'],
      updatedAt: json['data']['jabatan']['updated_at'],
    );
  }
}