import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gaskeun_mobile/models/Pesanan.dart';

Future<List<Order>> fetchOrders(int userId) async {
  final response = await http
      .get(Uri.parse('https://gaskeun.shop/api/pesanan/byUser/$userId'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((order) => Order.fromJson(order)).toList();
  } else {
    throw Exception('Failed to load orders');
  }
}
