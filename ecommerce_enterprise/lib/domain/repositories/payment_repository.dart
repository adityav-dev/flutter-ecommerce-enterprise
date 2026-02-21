import '../../core/utils/result.dart';

/// Abstraction for payment (Stripe) integration.
/// Phase 1: mock structure; implement with Stripe SDK when ready.
abstract class PaymentRepository {
  Future<Result<String>> createPaymentIntent({
    required double amount,
    required String currency,
    String? orderId,
  });
  Future<Result<bool>> confirmPayment(String paymentIntentId);
}
