import 'dart:convert';

import 'package:dr_app/configs/api_config.dart';
import 'package:dr_app/data/models/remote/cuisine.dart';
import 'package:dr_app/data/models/remote/results.dart';
import 'package:dr_app/services/api/base_api_client.dart';
import 'package:flutter/foundation.dart';

/// Service client layer for accessing the /cuisines API resource.
/// Enables fetching all cuisines or a specific cuisine by id.
class CuisineApiClient extends BaseApiClient {
  static const _PATH = ApiConfig.CUISINES_RESOURCE;

  Future<Results<Cuisine>> getCuisines() async {
    final responseBody = await getRequest(_PATH);
    return compute(_parseResults, responseBody);
  }

  Future<Results<Cuisine>> getCuisineById(int id) async {
    assert(id >= 0, 'Cuisine ID must be a positive value');
    final responseBody = await getRequest(_PATH + '/$id');
    return compute(_parseResults, responseBody);
  }
}

/// Top-level function to transform a response body into [Results].
Results<Cuisine> _parseResults(String responseBody) {
  final parsedJson = jsonDecode(responseBody);
  return Results.fromJson(parsedJson, Cuisine.fromJson);
}
