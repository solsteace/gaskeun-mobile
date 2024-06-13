import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gaskeun_mobile/models/CarList.dart';

class ApiService {
  static const String baseUrl = "https://gaskeun.shop/api";

  static Future<List<Car>> fetchCars() async {
    final response = await http.get(Uri.parse("$baseUrl/mobil"));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Car> cars = body.map((dynamic item) => Car.fromJson(item)).toList();
      return cars;
    } else {
      throw Exception("Failed to load cars");
    }
  }
}
