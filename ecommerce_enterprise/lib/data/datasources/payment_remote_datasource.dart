import '../../core/network/api_client.dart';

/// Phase 1: Mock structure for Stripe payment intent.
/// Replace with real Stripe SDK integration in Phase 2.
abstract class PaymentRemoteDataSource {
  Future<String> createPaymentIntent({
    required double amount,
    required String currency,
    String? orderId,
  });
  Future<bool> confirmPayment(String paymentIntentId);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  PaymentRemoteDataSourceImpl(this._client);
  final ApiClient _client;

  @override
  Future<String> createPaymentIntent({
    required double amount,
    required String currency,
    String? orderId,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/payments/create-intent',
      data: {
        'amount': (amount * 100).round(),
        'currency': currency,
        if (orderId != null) 'order_id': orderId,
      },
    );
    final data = response.data;
    if (data == null) throw Exception('Failed to create payment intent');
    return data['client_secret'] as String? ?? data['paymentIntentId'] as String? ?? '';
  }

  @override
  Future<bool> confirmPayment(String paymentIntentId) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/payments/confirm',
      data: {'payment_intent_id': paymentIntentId},
    );
    final data = response.data;
    return data?['status'] == 'succeeded' || data?['success'] == true;
  }
}
