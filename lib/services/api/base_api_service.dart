import 'dart:convert';

import 'package:dr_app/configs/api_config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'network_exception.dart';

/// Base class that abstracts http operations shared among API services.
abstract class BaseApiService {
  final String _baseUrl = ApiConfig.BASE_URL;
  final http.Client _client = http.Client();

  /// Abstracts GET http request boilerplate.
  Future<dynamic> get(String path) async {
    try {
      final url = _baseUrl + path;
      debugPrint('GET request to $url');
      final response = await _client.get(url);
      return _filterResponseBody(response);
    } catch (e) {
      debugPrint(e);
      throw FetchDataException('GET request failed');
    }
  }

  /// Returns the response body if the request has been completed successfully.
  /// Otherwise, throws exceptions relevant to the http status code.
  dynamic _filterResponseBody(http.Response response) {
    debugPrint('Response status: ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        compute(_printDecodedJson, response.body);
        return response.body;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  /// Logs the json response in the console if running in development mode.
  void _printDecodedJson(String responseBody) {
    final jsonString = json.decode(responseBody.toString());
    debugPrint('JSON response: $jsonString');
  }
}
