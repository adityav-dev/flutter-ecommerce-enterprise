import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl(this._remote);
  final OrderRemoteDataSource _remote;

  @override
  Future<Result<Order>> placeOrder({
    required String shippingAddressId,
    String? paymentIntentId,
  }) async {
    try {
      final order = await _remote.placeOrder(
        shippingAddressId: shippingAddressId,
        paymentIntentId: paymentIntentId,
      );
      return Success(order.toEntity());
    } on AppException catch (e) {
      return Error(_mapException(e));
    }
  }

  @override
  Future<Result<List<Order>>> getMyOrders({int page = 1, int limit = 20}) async {
    try {
      final list = await _remote.getMyOrders(page: page, limit: limit);
      return Success(list.map((e) => e.toEntity()).toList());
    } on AppException catch (e) {
      return Error(_mapException(e));
    }
  }

  @override
  Future<Result<Order>> getOrderById(String id) async {
    try {
      final order = await _remote.getOrderById(id);
      return Success(order.toEntity());
    } on AppException catch (e) {
      return Error(_mapException(e));
    }
  }

  @override
  Future<Result<Order>> cancelOrder(String orderId) async {
    try {
      final order = await _remote.cancelOrder(orderId);
      return Success(order.toEntity());
    } on AppException catch (e) {
      return Error(_mapException(e));
    }
  }

  Failure _mapException(AppException e) {
    if (e is NetworkException) return NetworkFailure(message: e.message, code: e.code);
    if (e is AuthException) return AuthFailure(message: e.message, code: e.code);
    return ServerFailure(message: e.message, code: e.code);
  }
}
