import 'dart:convert';

import 'package:dr_app/configs/api_config.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:flutter/foundation.dart';

import 'base_api_client.dart';

/// Service client layer for accessing the /outlets API resource.
/// Enables fetching all outlets, all featured outlets, or
/// a specific outlet by id.
class OutletApiClient extends BaseApiClient {
  static const _PATH = ApiConfig.OUTLETS_RESOURCE;
  static const _FEATURED_OUTLETS_PATH = '/featured';

  Future<Results<Outlet>> getOutlets({String city, String cuisine}) async {
    Object params = _generateQueryParams(city: city, cuisine: cuisine);
    final responseBody = await getRequest(_PATH, params);
    return compute(_parseOutletResults, responseBody);
  }

  Future<Results<Outlet>> getFeaturedOutlets([String city]) async {
    Object params = _generateQueryParams(city: city);
    final responseBody =
        await getRequest(_PATH + _FEATURED_OUTLETS_PATH, params);
    return compute(_parseOutletResults, responseBody);
  }

  Future<Results<Outlet>> getOutletById(int id) async {
    assert(id >= 0, 'Outlet ID must be a positive value');
    final responseBody = await getRequest(_PATH + '/$id');
    return compute(_parseOutletResults, responseBody);
  }

  Future<Results<Product>> getOutletProducts(int id) async {
    assert(id >= 0, 'Outlet ID must be a positive value');
    final responseBody = await getRequest(_PATH + '/$id/products');
    return compute(_parseProductResults, responseBody);
  }

  Future<Results<Product>> getOutletFeaturedProducts(int id) async {
    assert(id >= 0, 'Outlet ID must be a positive value');
    final responseBody = await getRequest(_PATH + '/$id/products/featured');
    return compute(_parseProductResults, responseBody);
  }

  Object _generateQueryParams({String city, String cuisine}) {
    Map<String, String> params = {};
    if (city != null) params['city'] = city;
    if (cuisine != null) params['cuisine'] = cuisine;

    return params;
  }
}

/// Top-level function to transform a response body into [Results<Outlet>].
Results<Outlet> _parseOutletResults(String responseBody) {
  final parsedJson = jsonDecode(responseBody);
  return Results.fromJson(parsedJson, Outlet.fromJson);
}

/// Top-level function to transform a response body into [Results<Product>].
Results<Product> _parseProductResults(String responseBody) {
  final parsedJson = jsonDecode(responseBody);
  return Results.fromJson(parsedJson, Product.fromJson);
}
