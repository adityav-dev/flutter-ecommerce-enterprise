import '../../core/network/api_client.dart';
import '../models/product_model.dart';

abstract class WishlistRemoteDataSource {
  Future<List<ProductModel>> getWishlist();
  Future<void> addToWishlist(String productId);
  Future<void> removeFromWishlist(String productId);
  Future<bool> isInWishlist(String productId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  WishlistRemoteDataSourceImpl(this._client);
  final ApiClient _client;

  @override
  Future<List<ProductModel>> getWishlist() async {
    final response = await _client.get<Map<String, dynamic>>('/wishlist');
    final data = response.data;
    if (data == null) return [];
    final list = data['data'] as List<dynamic>? ?? data['products'] as List<dynamic>? ?? [];
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addToWishlist(String productId) async {
    await _client.post<void>('/wishlist', data: {'product_id': productId});
  }

  @override
  Future<void> removeFromWishlist(String productId) async {
    await _client.delete<void>('/wishlist/$productId');
  }

  @override
  Future<bool> isInWishlist(String productId) async {
    final list = await getWishlist();
    return list.any((p) => p.id == productId);
  }
}
