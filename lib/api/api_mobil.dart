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

  static Future<List<int>> fetchCarIdsWithFilter({
    String? brand,
    String? transmission,
    int? numPassengers,
    int? minPrice,
    int? maxPrice,
    String? startDate,
    String? endDate,
  }) async {
    // Define the endpoint you want to send the request to
    var baseUrl = 'https://gaskeun.shop/api/mobilFilter';

    // Create a map to hold query parameters
    Map<String, String> queryParams = {};

    if (transmission != null  && transmission != '') queryParams['transmission'] = transmission;
    if (numPassengers != null)
      queryParams['numPassengers'] = numPassengers.toString();
    if (minPrice != null) queryParams['minPrice'] = minPrice.toString();
    if (maxPrice != null) queryParams['maxPrice'] = maxPrice.toString();
    if (startDate != null && startDate != '')
      queryParams['startDate'] = startDate;
    if (endDate != null && endDate != '')
      queryParams['endDate'] = endDate;

    // Add query parameters to the URL
    var uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    print(uri);

    // Make the POST request
    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({}), // Empty body or specific body if required
    );

    print(response.body);

    // Check if the request was successful
    if (response.statusCode == 200) {
      print('POST request successful');

      // Parse the response body
      try {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        List<int> carIds = [];
        responseBody.forEach((key, value) {
          carIds.add(value['id']);
        });
        return carIds;
      } catch (e) {
        try {
          List<dynamic> responseBody = jsonDecode(response.body);
          List<int> carIds = [];
          for (var item in responseBody) {
            carIds.add(item['id']);
          }
          return carIds;
        } catch(e) {
          print('Error decoding response body: $e');
          return [];
        }
      }
    } else {
      throw Exception("Failed to load cars");
    }
  }

  static Future<Car> fetchCarById(int id) async {
    var uri = Uri.parse('https://gaskeun.shop/api/mobil/$id');

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return Car.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load car with id $id");
    }
  }

  static Future<List<Car>> fetchCarsWithDetails({
    String? brand,
    String? transmission,
    int? numPassengers,
    int? minPrice,
    int? maxPrice,
    String? startDate,
    String? endDate,
  }) async {
    try {
      // Fetch car IDs that match the filter
      List<int> carIds = await fetchCarIdsWithFilter(
        brand: brand,
        transmission: transmission,
        numPassengers: numPassengers,
        minPrice: minPrice,
        maxPrice: maxPrice,
        startDate: startDate,
        endDate: endDate,
      );

      // Fetch details for each car ID
      if (carIds.isEmpty) {
        return [];
      } else {
        List<Car> cars = [];
        for (int id in carIds) {
          Car car = await fetchCarById(id);
          cars.add(car);
        }

        return cars;
      }
    } catch (e) {
      throw Exception("Failed to fetch car details: $e");
    }
  }
}
