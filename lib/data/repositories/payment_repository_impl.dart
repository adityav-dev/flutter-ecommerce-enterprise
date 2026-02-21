import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl(this._remote);
  final PaymentRemoteDataSource _remote;

  @override
  Future<Result<String>> createPaymentIntent({
    required double amount,
    required String currency,
    String? orderId,
  }) async {
    try {
      final id = await _remote.createPaymentIntent(
        amount: amount,
        currency: currency,
        orderId: orderId,
      );
      return Success(id);
    } on AppException catch (e) {
      return Error(PaymentFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Result<bool>> confirmPayment(String paymentIntentId) async {
    try {
      final ok = await _remote.confirmPayment(paymentIntentId);
      return Success(ok);
    } on AppException catch (e) {
      return Error(PaymentFailure(message: e.message, code: e.code));
    }
  }
}
