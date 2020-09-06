import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/services/api/cart_api_client.dart';
import 'package:dr_app/services/api/network_exception.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class is the only data source for the Cart entity.
/// It should be seen as the single source of truth for fetching
/// or storing data.
class CartRepository {
  static const _cartIdKey = 'cart-id';
  final _cartApiClient = CartApiClient();

  int _cartId;

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  /// Retrieves a single Cart based on the stored cart id
  Future<Cart> fetchCart() async {
    final id = await _getCartId();
    if (id == null) throw FetchDataException('Not cart id was found');

    final body = await _cartApiClient.getCartById(id);
    return body.results.length > 0 ? body.results[0] : null;
  }

  /// Removes the cart id from memory and local storage
  Future<bool> clearCart() async {
    final prefs = await _prefs;
    if (prefs.containsKey(_cartIdKey)) {
      _cartId = null;
      return prefs.remove(_cartIdKey);
    }
    return false;
  }

  /// Creates a cart associated with thee given [outletId]
  Future<Cart> createCart({@required int outletId}) async {
    final body = await _cartApiClient.createCart(outletId: outletId);
    final result = body.results.length > 0 ? body.results[0] : null;
    if (result != null) {
      _cartId = result.id;
      _setCartIdOnLocalStorage(result.id);
    }
    return result;
  }

  /// Adds or updates a cart item
  /// [productId] must be an integer
  /// [quantity] must be an integer
  Future<Cart> addCartItem({
    @required int productId,
    @required int quantity,
  }) async {
    final id = await _getCartId();
    if (id == null) throw FetchDataException('Not cart id was found');

    final body = await _cartApiClient.createOrUpdateCartItem(
      id,
      productId: productId,
      quantity: quantity,
    );
    return body.results.length > 0 ? body.results[0] : null;
  }

  /// Delete a cart item from an existing cart
  /// [id] must be an integer referring to the cart id
  /// [productId] must be an integer
  Future<bool> removeCartItem(
    int id, {
    @required int productId,
  }) async {
    return await _cartApiClient.deleteCartItem(
      id,
      productId: productId,
    );
  }

  Future<int> _getCartId() async {
    if (_cartId == null) {
      final prefs = await _prefs;
      if (prefs.containsKey(_cartIdKey)) {
        _cartId = prefs.getInt(_cartIdKey);
      }
    }
    return _cartId;
  }

  Future<bool> _setCartIdOnLocalStorage(int id) async {
    final prefs = await _prefs;
    final isSuccessful = await prefs.setInt(_cartIdKey, id);
    debugPrint('Refreshed cart id: $id');
    return isSuccessful;
  }
}
