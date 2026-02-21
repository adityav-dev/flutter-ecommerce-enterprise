import '../entities/order.dart';
import '../../core/utils/result.dart';

abstract class OrderRepository {
  Future<Result<Order>> placeOrder({
    required String shippingAddressId,
    String? paymentIntentId,
  });
  Future<Result<List<Order>>> getMyOrders({int page = 1, int limit = 20});
  Future<Result<Order>> getOrderById(String id);
  Future<Result<Order>> cancelOrder(String orderId);
}
