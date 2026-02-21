import '../../core/network/api_client.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    String? categoryId,
    int page = 1,
    int limit = 20,
  });
  Future<ProductModel> getProductById(String id);
  Future<List<CategoryModel>> getCategories();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl(this._client);
  final ApiClient _client;

  @override
  Future<List<ProductModel>> getProducts({
    String? categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    final query = <String, dynamic>{'page': page, 'limit': limit};
    if (categoryId != null) query['category_id'] = categoryId;
    final response = await _client.get<Map<String, dynamic>>(
      '/products',
      queryParameters: query,
    );
    final data = response.data;
    if (data == null) return [];
    final list = data['data'] as List<dynamic>? ?? data['products'] as List<dynamic>? ?? [];
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await _client.get<Map<String, dynamic>>('/products/$id');
    if (response.data == null) throw Exception('Product not found');
    return ProductModel.fromJson(response.data!);
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _client.get<Map<String, dynamic>>('/categories');
    final data = response.data;
    if (data == null) return [];
    final list = data['data'] as List<dynamic>? ?? data['categories'] as List<dynamic>? ?? [];
    return list
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
