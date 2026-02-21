import '../../repositories/product_repository.dart';
import '../../../core/utils/result.dart';
import '../../entities/product.dart';

class GetProductsUseCase {
  GetProductsUseCase(this._repository);
  final ProductRepository _repository;

  Future<Result<List<Product>>> call({
    String? categoryId,
    int page = 1,
    int limit = 20,
  }) {
    return _repository.getProducts(
      categoryId: categoryId,
      page: page,
      limit: limit,
    );
  }
}
