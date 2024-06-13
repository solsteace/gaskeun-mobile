import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://gaskeun.shop/api';

  static Future<int?> createPayment() async {
    final response = await http.post(
      Uri.parse('$baseUrl/pembayaran'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': 'belum_lunas'}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['insertID'];
    } else {
      throw Exception('Failed to create payment');
    }
  }

  static Future<int?> createOrder(
      int idPemesan,
      int idMobil,
      int idPembayaran,
      String namaPeminjam,
      String tanggalPeminjaman,
      String tanggalPengembalian,
      String simPath,
      {String? titikAntar,
      String? titikJemput}) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/pesanan'),
    );
    request.fields['id_pemesan'] = idPemesan.toString();
    request.fields['id_mobil'] = idMobil.toString();
    request.fields['id_pembayaran'] = idPembayaran.toString();
    request.fields['nama_peminjam'] = namaPeminjam;
    request.fields['tanggal_peminjaman'] = tanggalPeminjaman;
    request.fields['tanggal_pengembalian'] = tanggalPengembalian;
    if (titikAntar != null) request.fields['titik_antar'] = titikAntar;
    if (titikJemput != null) request.fields['titik_jemput'] = titikJemput;
    request.files
        .add(await http.MultipartFile.fromPath('SIM_peminjam', simPath));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonData = jsonDecode(responseData);
      return jsonData['insertID'];
    } else {
      throw Exception('Failed to create order');
    }
  }
}
