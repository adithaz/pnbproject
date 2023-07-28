import 'package:http/http.dart' as http;

class Absen {
  final int nip;
  final String hadir;

  Absen({
    this.nip = 0,
    this.hadir = "",
  });

  Map<String, dynamic> toJson() => {
    'nip': nip,
    'hadir': hadir,
  };

  Future<bool> kirimAbsen(int nip, String hadir, String token) async {
    try {
      final uri = Uri.http('10.0.2.2:8000', '/api/absen');
      final headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      final body = {
        'nip': '210040017',
        'hadir': 'hadir',
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