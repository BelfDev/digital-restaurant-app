import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/services/api/payment_api_client.dart';
import 'package:meta/meta.dart';

/// This class is the only data source for the Payment entity.
/// It should be seen as the single source of truth for fetching
/// or storing data.
class PaymentRepository {
  final _paymentApiClient = PaymentApiClient();

  /// Creates a payment
  Future<Payment> createPayment({
    @required int orderId,
    @required int paymentMethodId,
  }) async {
    final body = await _paymentApiClient.createPayment(
      orderId: orderId,
      paymentMethodId: paymentMethodId,
    );
    return body.results.length > 0 ? body.results[0] : null;
  }
}
