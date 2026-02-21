import '../entities/product.dart';
import '../entities/category.dart';
import '../../core/utils/result.dart';

abstract class ProductRepository {
  Future<Result<List<Product>>> getProducts({
    String? categoryId,
    int page = 1,
    int limit = 20,
  });
  Future<Result<Product>> getProductById(String id);
  Future<Result<List<Category>>> getCategories();
}
