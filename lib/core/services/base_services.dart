import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:seven/app/app.dart';

enum ResponseType { GET, POST, PUT, DELETE }

class BaseService {
  static BaseService? _instance;
  BaseService._();
  static BaseService get instance => _instance ??= BaseService._();

  http.Client get _client => http.Client();

  Map<String, String> _headers() {
    return {
      'Authorization': ApiConstants.BEARER_TOKEN,
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }

  Future<Map<String, dynamic>> fetchData(
      {required String apiHost,
      required String endPoint,
      required ResponseType responseType,
      String version = ApiConstants.VERSION_3,
      Map<String, String>? body,
      Map<String, String>? queryParams}) async {
    try {
      Uri uri = _buildUri(apiHost, version, endPoint, queryParams);
      log('$responseType Request: $uri', name: 'BaseService');

      switch (responseType) {
        case ResponseType.GET:
          return await _get(uri);
        case ResponseType.POST:
          return await _post(uri, body: body);
        case ResponseType.PUT:
          return await _put(uri, body: body);
        case ResponseType.DELETE:
          return await _delete(uri);
      }
    } on SocketException catch (e) {
      log('Network Error: $e', name: 'BaseService');
      throw NetworkException(message: 'Please check your internet connection');
    } on http.ClientException catch (e) {
      log('HTTP Client Error: $e', name: 'BaseService');
      throw NetworkException(message: 'Connection failed');
    } on FormatException catch (e) {
      log('Format Error: $e', name: 'BaseService');
      throw ApiException(
        message: 'Invalid response format',
        statusCode: null,
        error: e,
      );
    } catch (e) {
      log('Unexpected Error: $e', name: 'BaseService');
      rethrow;
    }
  }

  // GET
  Future<Map<String, dynamic>> _get(Uri uri) async {
    final response = await _client.get(uri, headers: _headers()).timeout(
        ApiConstants.CONNECTION_TIMEOUT,
        onTimeout: () => throw TimeoutException());

    return _processResponse(response);
  }

  /// POST
  Future<Map<String, dynamic>> _post(Uri uri,
      {Map<String, dynamic>? body}) async {
    final response = await _client
        .post(uri,
            headers: _headers(), body: body != null ? jsonEncode(body) : null)
        .timeout(ApiConstants.CONNECTION_TIMEOUT,
            onTimeout: () => throw TimeoutException());

    return _processResponse(response);
  }

  /// PUT
  Future<dynamic> _put(Uri uri, {Map<String, dynamic>? body}) async {
    final response = await _client
        .put(uri,
            headers: _headers(), body: body != null ? jsonEncode(body) : null)
        .timeout(ApiConstants.CONNECTION_TIMEOUT,
            onTimeout: () => throw TimeoutException());

    return _processResponse(response);
  }

  /// DELETE
  Future<Map<String, dynamic>> _delete(Uri uri) async {
    final response = await _client
        .delete(uri, headers: _headers())
        .timeout(ApiConstants.CONNECTION_TIMEOUT, onTimeout: () {
      throw TimeoutException();
    });

    return _processResponse(response);
  }

  Uri _buildUri(
    String apiHost,
    String version,
    String endPoint,
    Map<String, dynamic>? queryParams,
  ) {
    return Uri.parse('$apiHost$version$endPoint')
        .replace(queryParameters: queryParams);
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    final statusCode = response.statusCode;

    log('Response Status: $statusCode', name: 'BaseService');
    switch (statusCode) {
      case 200:
      case 201:
        try {
          final decodedData = jsonDecode(response.body);
          log('Response Success', name: 'BaseService');
          return decodedData as Map<String, dynamic>;
        } catch (e) {
          throw ApiException(
              message: 'Failed to parse response',
              statusCode: statusCode,
              error: e);
        }

      case 400:
        throw ApiException(
            message: 'Bad request',
            statusCode: statusCode,
            error: response.body);

      case 401:
        throw UnauthorizedException();

      case 403:
        throw ApiException(message: 'Forbidden access', statusCode: statusCode);

      case 404:
        throw ApiException(
            message: 'Resource not found', statusCode: statusCode);

      case 429:
        throw ApiException(
            message: 'Too many requests. Please try again later.',
            statusCode: statusCode);

      case 500:
      case 502:
      case 503:
        throw ServerException(
            statusCode: statusCode,
            message: 'Server error occurred. Please try again later.');

      default:
        throw ApiException(
            message: 'Request failed with status: $statusCode',
            statusCode: statusCode,
            error: response.body);
    }
  }
}
