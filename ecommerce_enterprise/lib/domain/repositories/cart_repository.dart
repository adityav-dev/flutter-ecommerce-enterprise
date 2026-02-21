import '../entities/cart.dart';
import '../entities/product.dart';
import '../../core/utils/result.dart';

abstract class CartRepository {
  Future<Result<Cart>> getCart();
  Future<Result<Cart>> addToCart(Product product, int quantity);
  Future<Result<Cart>> updateQuantity(String productId, int quantity);
  Future<Result<Cart>> removeFromCart(String productId);
  Future<Result<void>> clearCart();
}
