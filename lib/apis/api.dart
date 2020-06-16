import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  String _baseURL = 'https://universal-school-system.herokuapp.com/api/v1';
  String get baseURL => _baseURL;

  Future<http.Response> post(String endpoint,
      {Map<String, dynamic> body,
      Map<String, String> headers = const {
        'Content-Type': 'application/json'
      }}) async {
    return http.post("$baseURL/$endpoint",
        body: json.encode(body), headers: headers);
  }

  Future<http.Response> get(String endpoint,
      {Map<String, String> headers = const {
        'Content-Type': 'application/json'
      }}) async {
    return http.get("$baseURL/$endpoint", headers: headers);
  }

  Future<http.Response> put(String endpoint,
      {Map<String, dynamic> body,
      Map<String, String> headers = const {
        'Content-Type': 'application/json'
      }}) async {
    return http.put("$baseURL/$endpoint", body: body, headers: headers);
  }

  Future<http.Response> delete(String endpoint,
      {Map<String, dynamic> body,
      Map<String, String> headers = const {
        'Content-Type': 'application/json'
      }}) async {
    return http.delete("$baseURL/$endpoint", headers: headers);
  }
}
