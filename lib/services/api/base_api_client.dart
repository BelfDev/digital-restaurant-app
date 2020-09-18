import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/session_interceptor.dart';
import 'network_exception.dart';

/// Base class that abstracts http operations shared among API services.
abstract class BaseApiClient {
  // static const _BASE_URL = ApiConfig.BASE_HOST;
  // ignore: non_constant_identifier_names
  final _BASE_URL = Platform.isIOS ? '127.0.0.1:5000' : '10.0.2.2:5000';

  final Client _client =
      HttpClientWithInterceptor.build(interceptors: [SessionInterceptor()]);

  /// Abstracts GET http request boilerplate.
  @protected
  Future<String> getRequest(String path, [Object params]) async {
    try {
      final uri = Uri.http(_BASE_URL, path, params);
      debugPrint('GET request to ${_BASE_URL + path} with params $params');
      final response = await _client.get(uri);
      return _filterResponseBody(response);
    } catch (e) {
      debugPrint(e);
      throw FetchDataException('GET request failed');
    }
  }

  /// Abstracts POST http request boilerplate.
  @protected
  Future<String> postRequest(
    String path, {
    Object params,
    Object body,
  }) async {
    try {
      final uri = Uri.http(_BASE_URL, path, params);
      debugPrint('POST request to ${_BASE_URL + path} with params $params');
      debugPrint('\n=== REQUEST BODY ===\n');
      _decodeAndPrintJson(body);
      final response = await _client.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      return _filterResponseBody(response);
    } catch (e) {
      debugPrint(e.toString());
      throw FetchDataException('POST request failed');
    }
  }

  /// Returns the response body if the request has been completed successfully.
  /// Otherwise, throws exceptions relevant to the http status code.
  dynamic _filterResponseBody(Response response) {
    debugPrint('Response status: ${response.statusCode}');
    switch (response.statusCode) {
      case 201:
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

  /// Abstracts DELETE http request boilerplate.
  /// Allows DELETE requests with body payloads.
  @protected
  Future<String> deleteRequest(
    String path, {
    Object params,
    Object body,
  }) async {
    try {
      final uri = Uri.http(_BASE_URL, path, params);

      final interceptor = SessionInterceptor();

      Request rawRequest = Request("DELETE", uri);
      final basicHeaders = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };

      rawRequest.headers.addAll(basicHeaders);
      if (body != null) {
        rawRequest.body = jsonEncode(body);
      }
      final requestData = await interceptor.interceptRequest(
        data: RequestData.fromHttpRequest(rawRequest),
      );
      final request = requestData.toHttpRequest();

      debugPrint('DELETE request to ${_BASE_URL + path} with params $params');
      debugPrint('\n=== REQUEST BODY ===\n');

      _decodeAndPrintJson(request.body);

      final responseStream = await request.send();
      final response = await Response.fromStream(responseStream);

      final responseData = await interceptor.interceptResponse(
          data: ResponseData.fromHttpResponse(response));
      final enhancedResponse = responseData.toHttpResponse();

      return _filterResponseBody(enhancedResponse);
    } catch (e) {
      debugPrint(e.toString());
      throw FetchDataException('DELETE request failed');
    }
  }
}

/// Logs the json response in the console if running in development mode.
void _decodeAndPrintJson(String responseBody) {
  final jsonString = json.decode(responseBody);
  final encoder = JsonEncoder.withIndent("     ");
  final prettyJson = encoder.convert(jsonString);
  debugPrint('JSON: $prettyJson');
}
