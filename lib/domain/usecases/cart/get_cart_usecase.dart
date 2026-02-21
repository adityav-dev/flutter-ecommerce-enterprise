import '../../repositories/cart_repository.dart';
import '../../../core/utils/result.dart';
import '../../entities/cart.dart';

class GetCartUseCase {
  GetCartUseCase(this._repository);
  final CartRepository _repository;

  Future<Result<Cart>> call() => _repository.getCart();
}
