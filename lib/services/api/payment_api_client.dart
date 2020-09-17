import 'dart:convert';

import 'package:dr_app/configs/api_config.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:flutter/foundation.dart';

import 'base_api_client.dart';

/// Service client layer for accessing the /payments API resource.
/// Enables fetching all cuisines or a specific cuisine by id.
class PaymentApiClient extends BaseApiClient {
  static const _PATH = ApiConfig.PAYMENTS_RESOURCE;

  Future<Results<Payment>> createPayment({
    @required int orderId,
    @required int paymentMethodId,
  }) async {
    assert(orderId >= 0, 'Order ID must be a positive value');
    assert(paymentMethodId >= 0, 'Payment method ID must be a positive value');
    final responseBody = await postRequest(
      _PATH,
      body:
          jsonEncode({'orderId': orderId, 'paymentMethodId': paymentMethodId}),
    );
    return compute(_parseResults, responseBody);
  }
}

/// Top-level function to transform a response body into [Results].
Results<Payment> _parseResults(String responseBody) {
  final parsedJson = jsonDecode(responseBody);
  return Results.fromJson(parsedJson, Payment.fromJson);
}
