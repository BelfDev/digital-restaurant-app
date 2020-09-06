import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/services/api/cart_api_client.dart';
import 'package:meta/meta.dart';

/// This class is the only data source for the Cart entity.
/// It should be seen as the single source of truth for fetching
/// or storing data.
class CartRepository {
  final _cartApiClient = CartApiClient();

  /// Retrieves a single Cart entity by the given identifier
  Future<Cart> fetchCart(int id) async {
    final body = await _cartApiClient.getCartById(id);
    return body.results.length > 0 ? body.results[0] : null;
  }

  /// Creates a cart associated with thee given [outletId]
  Future<Cart> createCart({@required int outletId}) async {
    final body = await _cartApiClient.createCart(outletId: outletId);
    return body.results.length > 0 ? body.results[0] : null;
  }

  /// Adds or updates a cart item
  /// [id] must be an integer referring to the cart id
  /// [productId] must be an integer
  /// [quantity] must be an integer
  Future<Cart> addCartItem(
    int id, {
    @required int productId,
    @required int quantity,
  }) async {
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
}
