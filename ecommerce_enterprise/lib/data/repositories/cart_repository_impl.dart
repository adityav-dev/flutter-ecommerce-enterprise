import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl(this._remote);
  final CartRemoteDataSource _remote;

  @override
  Future<Result<Cart>> getCart() async {
    try {
      final cart = await _remote.getCart();
      return Success(cart.toEntity());
    } on AppException catch (e) {
      return Error(_mapException(e));
    }
  }

  @override
  Future<Result<Cart>> addToCart(Product product, int quantity) async {
    try {
      final cart = await _remote.addToCart(product, quantity);
      return Success(cart.toEntity());
    } on AppException catch (e) {
      return Error(_mapException(e));
    }
  }

  @override
  Future<Result<Cart>> updateQuantity(String productId, int quantity) async {
    try {
      final cart = await _remote.updateQuantity(productId, quantity);
      return Success(cart.toEntity());
    } on AppException catch (e) {
      return Error(_mapException(e));
    }
  }

  @override
  Future<Result<Cart>> removeFromCart(String productId) async {
    try {
      final cart = await _remote.removeFromCart(productId);
      return Success(cart.toEntity());
    } on AppException catch (e) {
      return Error(_mapException(e));
    }
  }

  @override
  Future<Result<void>> clearCart() async {
    try {
      await _remote.clearCart();
      return const Success(null);
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
