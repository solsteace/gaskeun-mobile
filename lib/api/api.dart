import "package:http/http.dart" as http;

// Is there a way to grab a value from ENV for this?
// There kinda is? https://stackoverflow.com/questions/44250184/setting-environment-variables-in-flutter
const String endpoint = String.fromEnvironment("DOMAIN", defaultValue: "https://gaskeun.shop/api");

 Future<http.Response> get(path) async {
  final url = [endpoint, path].join("/");
  final response = await http.get(Uri.parse(url));
  return response;
}

Future<http.Response> post(path, headers, body) async {
  final url = [endpoint, path].join("/");
  final response = await http.post(
    Uri.parse(url), headers: headers, body: body
  );
  return response;
}