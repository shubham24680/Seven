import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:seven/app/app.dart';

enum ResponseType { GET, POST, PUT, DELETE }

class BaseService {
  static BaseService? _instance;
  BaseService._();
  static BaseService get instance => _instance ??= BaseService._();

  Map<String, String> _headers() {
    return {
      'Authorization': ApiConstants.BEARER_TOKEN,
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }

  Future<dynamic> fetchData(
      {required String apiHost,
      required String endPoint,
      required ResponseType responseType,
      Map<String, String>? body,
      Map<String, String>? queryParams}) {
    String baseUrl = "$apiHost$endPoint";
    switch (responseType) {
      case ResponseType.GET:
        return _get(baseUrl, queryParams: queryParams);
      case ResponseType.POST:
        return _post(baseUrl, body: body);
      case ResponseType.PUT:
        return _put(baseUrl, body: body);
      case ResponseType.DELETE:
        return _delete(baseUrl);
    }
  }

  // GET
  Future<dynamic> _get(String baseUrl,
      {Map<String, String>? queryParams}) async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    log("uri -> $uri");
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

    log("Status code [$statusCode] -> ${body?["status_message"]}");
    return body;
  }
}
