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

  static Future<List<Car>> fetchCarsWithFilter({
    String? brand,
    String? transmission,
    int? numPassengers,
    int? minPrice,
    int? maxPrice,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var url = Uri.parse("$baseUrl/mobilFilter");

    var payload = jsonEncode({
      "brand": brand,
      "transmission": transmission,
      "numPassengers": numPassengers,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
      "startDate": startDate,
      "endDate": endDate,
    });

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: payload,
    );

/*
    final response = await http.post(
      Uri.parse("$baseUrl/mobilFilter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'brand': brand,
        'transmission': transmission,
        'numPassengers': numPassengers,
        'minPrice': minPrice,
        'maxPrice': maxPrice,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
      }),
    );
*/

    if (response.statusCode == 200) {
      print('POST request successful');
      print('Response: ${response.body}');
      List<dynamic> body = jsonDecode(response.body);
      List<Car> cars = body.map((dynamic item) => Car.fromJson(item)).toList();
      print(cars);
      return cars;
    } else {
      throw Exception("Failed to load cars");
    }
  }
}
