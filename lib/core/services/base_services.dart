import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:seven/app/app.dart';

enum ResponseType { GET, POST, PUT, DELETE }

class BaseService {
  Map<String, String> _headers({bool isJson = true}) {
    return {
      "Authorization": "Bearer ${ApiConstants.API_KEY}",
      if (isJson) "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }

  Future<dynamic> fetchData(
      {required String apiHost,
      required String endPoint,
      required ResponseType responseType,
      Map<String, String>? para}) {
    String baseUrl = apiHost + endPoint;
    switch (responseType) {
      case ResponseType.GET:
        return _get(baseUrl, queryParams: para);
      case ResponseType.POST:
        return _post(baseUrl, body: para);
      case ResponseType.PUT:
        return _put(baseUrl, body: para);
      case ResponseType.DELETE:
        return _delete(baseUrl);
    }
  }

  // GET
  Future<dynamic> _get(String baseUrl,
      {Map<String, String>? queryParams}) async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: _headers());

    return _processResponse(response);
  }

  /// POST
  Future<dynamic> _post(String baseUrl, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse(baseUrl);
    final response = await http.post(
      uri,
      headers: _headers(),
      body: jsonEncode(body),
    );

    return _processResponse(response);
  }

  /// PUT
  Future<dynamic> _put(String baseUrl, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse(baseUrl);
    final response = await http.put(
      uri,
      headers: _headers(),
      body: jsonEncode(body),
    );

    return _processResponse(response);
  }

  /// DELETE
  Future<dynamic> _delete(String baseUrl) async {
    final uri = Uri.parse(baseUrl);
    final response = await http.delete(uri, headers: _headers());

    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (statusCode >= 200 && statusCode < 300) {
      return body;
    } else {
      throw ApiException(
        statusCode: statusCode,
        message: body?["status_message"] ?? "Something went wrong",
      );
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => "ApiException($statusCode): $message";
}
