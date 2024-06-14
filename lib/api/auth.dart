import "dart:convert";
import "package:gaskeun_mobile/api/api.dart" as api;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class APIAuth {
  void login(String data, Function(int, String, String, String, String) onSuccess, Function(String) onFail) async {
    final headers = <String, String>{
      "Content-Type": "application/json; charset=UTF-8"
    };

    try {
      final response = await api.post("login", headers, data);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success']) {
          final FlutterSecureStorage _storage = FlutterSecureStorage();

          try {
            // Optimizable
            // await _storage.write(key: "user_id", value: responseData["data"]["id"].toString());
            // await _storage.write(key: "user_name", value: responseData["data"]["name"]);
            // await _storage.write(key: "user_email", value: responseData["data"]["email"]);
            // await _storage.write(key: "user_role", value: responseData["data"]["role"]);
            // await _storage.write(key: "user_token", value: responseData["data"]["token"]);

            onSuccess(
              responseData["data"]["id"],
              responseData["data"]["name"],
              responseData["data"]["email"],
              responseData["data"]["role"],
              responseData["data"]["token"],
            );
          } catch (e) {
            onFail('Failed to save data securely: $e');
          }
        } else {
          // Handle the error based on the API response
          onFail(responseData['message']);
        }
      } else {
        // Handle the error based on the HTTP status code
        onFail('Login failed. Please try again.');
      }
    } catch (e) {
      onFail('An error occurred: $e');
    }
  }


  void register(String data, Function onSuccess, Function onFail) async {
    final headers = <String, String> {
      "Content-Type": "application/json; charset=UTF-8"
    };

    final response = await api.post("register", headers, data);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success']) {
        onSuccess();
      } else { // Handle the error based on the API response
        if(responseData["message"].containsKey("email")) {
          onFail(responseData["message"].containsKey("email"));
        } else {
          onFail("Unknown error happened");
        }
      }
    } else { // Handle the error based on the HTTP status code
      onFail('Registration failed. Please try again.');
    }
  }
}