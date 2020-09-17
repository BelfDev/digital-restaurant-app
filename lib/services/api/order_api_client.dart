import 'dart:convert';

import 'package:dr_app/configs/api_config.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:flutter/foundation.dart';

import 'base_api_client.dart';

/// Service client layer for accessing the /orders API resource.
/// Enables fetching all cuisines or a specific cuisine by id.
class OrderApiClient extends BaseApiClient {
  static const _PATH = ApiConfig.ORDERS_RESOURCE;

  Future<Results<Order>> getOrdersById(int id) async {
    assert(id >= 0, 'Order ID must be a positive value');
    final responseBody = await getRequest(_PATH + '/$id');
    return compute(_parseResults, responseBody);
  }

  Future<Results<Order>> createOrderWithCart(int cartId) async {
    assert(cartId >= 0, 'Cart ID must be a positive value');
    final responseBody = await postRequest(
      _PATH + '/carts',
      body: jsonEncode({
        'carts': [
          {'id': cartId}
        ]
      }),
    );
    return compute(_parseResults, responseBody);
  }

  Future<Results<Order>> addCart(int id, {@required int cartId}) async {
    assert(id >= 0, 'Order ID must be a positive value');
    assert(cartId >= 0, 'Cart ID must be a positive value');
    final responseBody = await postRequest(
      _PATH + '/$id/carts',
      body: jsonEncode({
        'carts': [
          {'id': cartId}
        ]
      }),
    );
    return compute(_parseResults, responseBody);
  }
}

/// Top-level function to transform a response body into [Results].
Results<Order> _parseResults(String responseBody) {
  final parsedJson = jsonDecode(responseBody);
  return Results.fromJson(parsedJson, Order.fromJson);
}
