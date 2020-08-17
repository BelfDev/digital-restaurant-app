import 'dart:convert';

import 'package:dr_app/configs/api_config.dart';
import 'package:dr_app/data/models/remote/outlet.dart';
import 'package:dr_app/data/models/remote/results.dart';
import 'package:flutter/foundation.dart';

import 'base_api_client.dart';

/// Service client layer for accessing the /outlets API resource.
/// Enables fetching all outlets, all featured outlets, or
/// a specific outlet by id.
// TODO: Generify GET operations
class OutletApiClient extends BaseApiClient {
  static const _PATH = ApiConfig.OUTLETS_RESOURCE;
  static const _FEATURED_OUTLETS_PATH = '/featured';

  Future<Results<Outlet>> getOutlets([String city]) async {
    Object params = _generateQueryParams(city);
    final responseBody = await getRequest(_PATH, params);
    return compute(_parseResults, responseBody);
  }

  Future<Results<Outlet>> getFeaturedOutlets([String city]) async {
    Object params = _generateQueryParams(city);
    final responseBody =
        await getRequest(_PATH + _FEATURED_OUTLETS_PATH, params);
    return compute(_parseResults, responseBody);
  }

  Future<Results<Outlet>> getOutletById(int id) async {
    assert(id >= 0, 'Outlet ID must be a positive value');
    final responseBody = await getRequest(_PATH + '/$id');
    return compute(_parseResults, responseBody);
  }

  Object _generateQueryParams([String city]) {
    return city != null ? {'city': city} : {};
  }
}

/// Top-level function to transform a response body into [Results].
Results<Outlet> _parseResults(String responseBody) {
  final parsedJson = jsonDecode(responseBody);
  return Results.fromJson(parsedJson, Outlet.fromJson);
}
