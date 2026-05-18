import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/errors/app_exceptions.dart';
import 'api_constants.dart';

class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await client.get(
        Uri.parse(ApiConstants.baseUrl + endpoint),
      );

      return _processResponse(response);
    } catch (e) {
      throw AppExceptions("Network error");
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.baseUrl + endpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      return _processResponse(response);
    } catch (e) {
      throw AppExceptions("Network error");
    }
  }

  dynamic _processResponse(http.Response response) {
    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw AppExceptions(data["message"] ?? "Server error");
    }
  }
}