import '../../repositories/product_repository.dart';
import '../../../core/utils/result.dart';
import '../../entities/category.dart';

class GetCategoriesUseCase {
  GetCategoriesUseCase(this._repository);
  final ProductRepository _repository;

  Future<Result<List<Category>>> call() => _repository.getCategories();
}
