import 'dart:convert';

import 'package:dr_app/configs/api_config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'network_exception.dart';

/// Base class that abstracts http operations shared among API services.
abstract class BaseApiService {
  static const _BASE_URL = ApiConfig.BASE_URL;

  final http.Client _client = http.Client();

  /// Abstracts GET http request boilerplate.
  @protected
  Future<String> getRequest(String path) async {
    try {
      final url = _BASE_URL + path;
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
        if (!kReleaseMode) {
          compute(_decodeAndPrintJson, response.body);
        }
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
}

/// Logs the json response in the console if running in development mode.
void _decodeAndPrintJson(String responseBody) {
  final jsonString = json.decode(responseBody.toString());
  final encoder = JsonEncoder.withIndent("     ");
  final prettyJson = encoder.convert(jsonString);
  debugPrint('JSON response: $prettyJson');
}
