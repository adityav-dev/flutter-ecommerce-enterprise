import '../../repositories/wishlist_repository.dart';
import '../../../core/utils/result.dart';

class AddToWishlistUseCase {
  AddToWishlistUseCase(this._repository);
  final WishlistRepository _repository;

  Future<Result<void>> call(String productId) => _repository.addToWishlist(productId);
}
