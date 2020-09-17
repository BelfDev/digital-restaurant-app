import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/services/api/order_api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class is the only data source for the Order entity.
/// It should be seen as the single source of truth for fetching
/// or storing data.
class OrderRepository {
  static const _orderIdKey = 'order-id';
  final _orderApiClient = OrderApiClient();

  int _orderId;

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  /// Removes the order id from memory and local storage
  Future<bool> clearOrder() async {
    final prefs = await _prefs;
    if (prefs.containsKey(_orderIdKey)) {
      _orderId = null;
      return prefs.remove(_orderIdKey);
    }
    return false;
  }

  /// Adds a cart to an order
  /// A new [Order] is created if none active order is found
  /// [cartId] must be an integer
  Future<Order> addCart({int cartId}) async {
    final id = await getOrderId();
    if (id == null) {
      final body = await _orderApiClient.createOrderWithCart(cartId);
      if (body.results.length > 0) {
        final order = body.results[0];
        _setOrderIdOnLocalStorage(order.id);
        return order;
      }
    } else {
      final body = await _orderApiClient.addCart(id, cartId: cartId);
      return body.results.length > 0 ? body.results[0] : null;
    }
    return null;
  }

  Future<int> getOrderId() async {
    if (_orderId == null) {
      final prefs = await _prefs;
      if (prefs.containsKey(_orderIdKey)) {
        _orderId = prefs.getInt(_orderIdKey);
      }
    }
    return _orderId;
  }

  Future<bool> _setOrderIdOnLocalStorage(int id) async {
    final prefs = await _prefs;
    final isSuccessful = await prefs.setInt(_orderIdKey, id);
    debugPrint('Refreshed order id: $id');
    return isSuccessful;
  }
}
