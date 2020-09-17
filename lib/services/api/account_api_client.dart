import 'dart:convert';

import 'package:dr_app/configs/api_config.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/models/remote/results.dart';
import 'package:dr_app/services/api/base_api_client.dart';
import 'package:flutter/foundation.dart';

/// Service client layer for accessing the /account API resource.
/// Enables authenticating or creating a new account
class AccountApiClient extends BaseApiClient {
  static const _PATH = ApiConfig.ACCOUNT_RESOURCE;

  /// Creates a new account and authenticates if operation is successful
  Future<Results<User>> signUp(String email, String password) async {
    assert(email.isNotEmpty, 'Email cannot be empty');
    assert(password.isNotEmpty, 'Password cannot be empty');
    final responseBody = await postRequest(
      _PATH + '/signup',
      body: jsonEncode({'email': email, 'password': password}),
    );
    return compute(_parseResults, responseBody);
  }

  /// Authenticates the user with the given credentials
  Future<Results<User>> login(String email, String password) async {
    assert(email.isNotEmpty, 'Email cannot be empty');
    assert(password.isNotEmpty, 'Password cannot be empty');
    final responseBody = await postRequest(
      _PATH + '/login',
      body: jsonEncode({'email': email, 'password': password}),
    );
    return compute(_parseResults, responseBody);
  }
}

/// Top-level function to transform a response body into [Results].
Results<User> _parseResults(String responseBody) {
  final parsedJson = jsonDecode(responseBody);
  return Results.fromJson(parsedJson, User.fromJson);
}
