import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:pnbproject/model/golongan.dart';
import 'package:pnbproject/model/jabatan.dart';
import 'package:pnbproject/model/user.dart';
import 'package:http/http.dart' as http;

class Pegawai {
  final int nip;
  final int idJabatan;
  final int idGolongan;
  final String nama;
  final String jk;
  final String noHp;
  final String status;
  final String alamat;
  final String foto;
  final DateTime? tanggalLahir;
  final DateTime? tanggalMasuk;
  final User? user;
  final Jabatan? jabatan;
  final Golongan? golongan;

  Pegawai({
    this.nip = 0,
    this.idJabatan = 0,
    this.idGolongan = 0,
    this.nama = "",
    this.jk = "",
    this.noHp = "",
    this.status = "",
    this.alamat = "",
    this.foto = "",
    this.tanggalLahir,
    this.tanggalMasuk,
    this.user,
    this.jabatan,
    this.golongan,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    var box = Hive.box('userData');
    return Pegawai(
      nip: json['data']['nip'],
      idJabatan: json['data']['id_jabatan'],
      idGolongan: json['data']['id_golongan'],
      nama: json['data']['nama'],
      jk: json['data']['jk'],
      noHp: json['data']['no_hp'],
      status: json['data']['status'],
      alamat: json['data']['alamat'],
      foto: json['data']['foto'],
      tanggalLahir: DateTime.tryParse(json['data']['tanggal_lahir']),
      tanggalMasuk: DateTime.tryParse(json['data']['tanggal_masuk']),
      user: User.fromJson(json, box.get('token')),
      jabatan: Jabatan.fromJson(json),
      golongan: Golongan.fromJson(json),
    );
  }

  Future<Pegawai?> getPegawaiData() async {
    var box = Hive.box('userData');
    try {
      final uri = Uri.http('10.0.2.2:8000', '/api/pegawai/1');
      final headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${box.get('token')}"
      };

      var response = await http.get(
        uri,
        headers: headers,
      );

      final output = jsonDecode(response.body);
      if(response.statusCode == 200) {
        Pegawai pegawai = Pegawai.fromJson(output);
        return pegawai;
      } else {
        return null;
      }
    } catch(e) {
      rethrow;
    }
  }

  Future<bool> updateFoto(String foto) async {
    var box = Hive.box('userData');
    try {
      final uri = Uri.http('10.0.2.2:8000', '/api/pegawai/1');
      final headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${box.get('token')}"
      };

      final body = {
        'foto': foto,
        '_method': 'PUT',
      };

      var response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if(response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      rethrow;
    }
  }
}