import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:pnbproject/model/pegawai.dart';
import 'package:pnbproject/model/user.dart';
import 'package:http/http.dart' as http;

class Gaji {
  final int id;
  final int nip;
  final int gajiPokok;
  final int tunjanganTetap;
  final int tunjanganTransportasi;
  final int total;
  final String periode;
  final Pegawai? pegawai;

  Gaji({
    this.id = 0,
    this.nip = 0,
    this.gajiPokok = 0,
    this.tunjanganTetap = 0,
    this.tunjanganTransportasi = 0,
    this.total = 0,
    this.periode = '',
    this.pegawai,
  });

  factory Gaji.fromJson(Map<String, dynamic> json) {
    return Gaji(
      id: json['data'][0]['id'],
      nip: json['data'][0]['nip'],
      gajiPokok: json['data'][0]['gaji_pokok'],
      tunjanganTetap: json['data'][0]['tunjangan_tetap'],
      tunjanganTransportasi: json['data'][0]['tunjangan_transportasi'],
      total: json['data'][0]['total'],
      periode: json['data'][0]['periode'],
      pegawai: Pegawai(
        nip: json['data'][0]['data-diri']['nip'],
        idJabatan: json['data'][0]['data-diri']['id_jabatan'],
        idGolongan: json['data'][0]['data-diri']['id_golongan'],
        nama: json['data'][0]['data-diri']['nama'],
        user: User(
          email: json['data'][0]['data-diri']['email'],
          password: json['data'][0]['data-diri']['password'],
        ),
        jk: json['data'][0]['data-diri']['password'],
        tanggalLahir: DateTime.tryParse(json['data'][0]['data-diri']['tanggal_lahir']),
        tanggalMasuk: DateTime.tryParse(json['data'][0]['data-diri']['tanggal_masuk']),
        noHp: json['data'][0]['data-diri']['no_hp'],
        alamat: json['data'][0]['data-diri']['alamat'],
        status: json['data'][0]['data-diri']['status'],
        foto: json['data'][0]['data-diri']['foto'],
      ),
    );
  }

  Future<Gaji?> getDataGaji() async {
    var box = Hive.box('userData');
    try {
      final uri = Uri.http('10.0.2.2:8000', '/api/gaji');
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
        Gaji gaji = Gaji.fromJson(output);
        return gaji;
      } else {
        return null;
      }
    } catch(e) {
      rethrow;
    }
  }
}