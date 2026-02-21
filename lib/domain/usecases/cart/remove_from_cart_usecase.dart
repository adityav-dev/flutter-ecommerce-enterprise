import '../../repositories/cart_repository.dart';
import '../../../core/utils/result.dart';
import '../../entities/cart.dart';

class RemoveFromCartUseCase {
  RemoveFromCartUseCase(this._repository);
  final CartRepository _repository;

  Future<Result<Cart>> call(String productId) => _repository.removeFromCart(productId);
}
