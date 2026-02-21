import '../../repositories/order_repository.dart';
import '../../../core/utils/result.dart';
import '../../entities/order.dart';

class PlaceOrderUseCase {
  PlaceOrderUseCase(this._repository);
  final OrderRepository _repository;

  Future<Result<Order>> call({
    required String shippingAddressId,
    String? paymentIntentId,
  }) {
    return _repository.placeOrder(
      shippingAddressId: shippingAddressId,
      paymentIntentId: paymentIntentId,
    );
  }
}
