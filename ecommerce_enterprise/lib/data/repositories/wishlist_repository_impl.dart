import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_remote_datasource.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  WishlistRepositoryImpl(this._remote);
  final WishlistRemoteDataSource _remote;

  @override
  Future<Result<List<Product>>> getWishlist() async {
    try {
      final list = await _remote.getWishlist();
      return Success(list.map((e) => e.toEntity()).toList());
    } on AppException catch (e) {
      return Error(_mapException(e));
    }
  }

  @override
  Future<Result<void>> addToWishlist(String productId) async {
    try {
      await _remote.addToWishlist(productId);
      return const Success(null);
    } on AppException catch (e) {
      return Error(_mapException(e));
    }
  }

  @override
  Future<Result<void>> removeFromWishlist(String productId) async {
    try {
      await _remote.removeFromWishlist(productId);
      return const Success(null);
    } on AppException catch (e) {
      return Error(_mapException(e));
    }
  }

  @override
  Future<Result<bool>> isInWishlist(String productId) async {
    try {
      final ok = await _remote.isInWishlist(productId);
      return Success(ok);
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
