import '../../repositories/order_repository.dart';
import '../../../core/utils/result.dart';
import '../../entities/order.dart';

class GetMyOrdersUseCase {
  GetMyOrdersUseCase(this._repository);
  final OrderRepository _repository;

  Future<Result<List<Order>>> call({int page = 1, int limit = 20}) {
    return _repository.getMyOrders(page: page, limit: limit);
  }
}
