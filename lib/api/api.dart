import "package:http/http.dart" as http;

// Is there a way to grab a value from ENV for this?
const String endpoint = "http://localhost:8000/api";

Future<http.Response> get(path) async {
  final url = [endpoint, path].join("/");
  final response = await http.get(Uri.parse(url));
  return response;
}

Future<http.Response> post(path, requestBody) async {
  final url = [endpoint, path].join("/");
  final response = await http.get(Uri.parse(url));
  return response;
}