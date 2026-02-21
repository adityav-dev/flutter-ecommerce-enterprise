import '../../repositories/cart_repository.dart';
import '../../../core/utils/result.dart';
import '../../entities/cart.dart';
import '../../entities/product.dart';

class AddToCartUseCase {
  AddToCartUseCase(this._repository);
  final CartRepository _repository;

  Future<Result<Cart>> call(Product product, int quantity) {
    return _repository.addToCart(product, quantity);
  }
}
