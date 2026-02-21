import '../../core/network/api_client.dart';
import '../../domain/entities/product.dart';
import '../models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart();
  Future<CartModel> addToCart(Product product, int quantity);
  Future<CartModel> updateQuantity(String productId, int quantity);
  Future<CartModel> removeFromCart(String productId);
  Future<void> clearCart();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  CartRemoteDataSourceImpl(this._client);
  final ApiClient _client;

  @override
  Future<CartModel> getCart() async {
    final response = await _client.get<Map<String, dynamic>>('/cart');
    if (response.data == null) return const CartModel();
    return CartModel.fromJson(response.data!);
  }

  @override
  Future<CartModel> addToCart(Product product, int quantity) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/cart/items',
      data: {
        'product_id': product.id,
        'quantity': quantity,
      },
    );
    if (response.data == null) return const CartModel();
    return CartModel.fromJson(response.data!);
  }

  @override
  Future<CartModel> updateQuantity(String productId, int quantity) async {
    final response = await _client.put<Map<String, dynamic>>(
      '/cart/items/$productId',
      data: {'quantity': quantity},
    );
    if (response.data == null) return const CartModel();
    return CartModel.fromJson(response.data!);
  }

  @override
  Future<CartModel> removeFromCart(String productId) async {
    final response = await _client.delete<Map<String, dynamic>>('/cart/items/$productId');
    if (response.data == null) return const CartModel();
    return CartModel.fromJson(response.data!);
  }

  @override
  Future<void> clearCart() async {
    await _client.delete<void>('/cart');
  }
}
