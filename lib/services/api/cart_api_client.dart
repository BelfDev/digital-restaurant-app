import 'dart:convert';

import 'package:dr_app/configs/api_config.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/data/models/remote/results.dart';
import 'package:dr_app/services/api/base_api_client.dart';
import 'package:flutter/foundation.dart';

/// Service client layer for accessing the /carts API resource.
/// Enables fetching all carts or a specific cart by id.
class CartApiClient extends BaseApiClient {
  static const _PATH = ApiConfig.CARTS_RESOURCE;

  /// Retrieves a cart entity for the given [id]
  /// The [id] must be an integer
  Future<Results<Cart>> getCartById(int id) async {
    assert(id >= 0, 'Cart ID must be a positive value');
    final responseBody = await getRequest(_PATH + '/$id');
    return compute(_parseCartResults, responseBody);
  }

  /// Creates a new cart associated with the given [outletId]
  /// The [outletId] must be an integer referring to the checked-in [Outlet]
  Future<Results<Cart>> createCart({@required int outletId}) async {
    assert(outletId >= 0, 'Outlet ID must be a positive value');
    final responseBody = await postRequest(
      _PATH,
      body: jsonEncode(<String, int>{
        'outletId': outletId,
      }),
    );
    return compute(_parseCartResults, responseBody);
  }

  /// Creates or updates a cart item
  /// [id] must be an integer referring to the cart id
  /// [productId] must be an integer
  /// [quantity] must be an integer
  ///
  /// If the combination of cart id and product id does not exist
  /// a new cart item entry is created
  Future<Results<Cart>> createOrUpdateCartItem(
    int id, {
    @required int productId,
    @required int quantity,
  }) async {
    assert(id >= 0, 'Cart ID must be a positive value');
    assert(productId >= 0, 'Product ID must be a positive value');
    assert(quantity >= 0, 'Quantity ID must be a positive value');

    final Map<String, dynamic> requestBody = {
      'items': [
        {
          'productId': productId,
          'quantity': quantity,
        }
      ]
    };

    final responseBody = await postRequest(
      _PATH + '/$id/items',
      body: jsonEncode(requestBody),
    );
    return compute(_parseCartResults, responseBody);
  }

  /// Deletes a cart item
  /// [id] must be an integer referring to the cart id
  /// [productId] must be an integer
  Future<bool> deleteCartItem(int id, {@required int productId}) async {
    assert(productId >= 0, 'Product ID must be a positive value');

    final Map<String, dynamic> requestBody = {
      'items': [
        {
          'productId': productId,
        }
      ]
    };

    final responseBody =
        await deleteRequest(_PATH + '/$id/items', body: requestBody);
    final parsedJson = jsonDecode(responseBody);
    final result = parsedJson['result'] > 0;
    return result;
  }
}

/// Top-level function to transform a response body into [Results].
Results<Cart> _parseCartResults(String responseBody) {
  final parsedJson = jsonDecode(responseBody);
  return Results.fromJson(parsedJson, Cart.fromJson);
}
