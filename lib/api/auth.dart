import "dart:convert";
import "package:gaskeun_mobile/api/api.dart" as api;

class APIAuth {
  void login(String data, Function onSuccess, Function onFail) async {
    final headers = <String, String> {
      "Content-Type": "application/json; charset=UTF-8"
    };

    final response = await api.post("login", headers, data);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success']) {
        onSuccess();
      } else { // Handle the error based on the API response
        onFail(responseData['message']);
      }
    } else { // Handle the error based on the HTTP status code
      onFail('Login failed. Please try again.');
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