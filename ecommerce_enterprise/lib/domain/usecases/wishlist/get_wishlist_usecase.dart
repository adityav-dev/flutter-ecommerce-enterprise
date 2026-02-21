import '../../repositories/wishlist_repository.dart';
import '../../../core/utils/result.dart';
import '../../entities/product.dart';

class GetWishlistUseCase {
  GetWishlistUseCase(this._repository);
  final WishlistRepository _repository;

  Future<Result<List<Product>>> call() => _repository.getWishlist();
}
