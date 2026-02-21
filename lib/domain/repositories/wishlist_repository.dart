import '../entities/product.dart';
import '../../core/utils/result.dart';

abstract class WishlistRepository {
  Future<Result<List<Product>>> getWishlist();
  Future<Result<void>> addToWishlist(String productId);
  Future<Result<void>> removeFromWishlist(String productId);
  Future<Result<bool>> isInWishlist(String productId);
}
