import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remote);
  final ProductRemoteDataSource _remote;

  @override
  Future<Result<List<Product>>> getProducts({
    String? categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final list = await _remote.getProducts(
        categoryId: categoryId,
        page: page,
        limit: limit,
      );
      return Success(list.map((e) => e.toEntity()).toList());
    } on AppException catch (e) {
      return Error(_mapException(e));
    }
  }

  @override
  Future<Result<Product>> getProductById(String id) async {
    try {
      final model = await _remote.getProductById(id);
      return Success(model.toEntity());
    } on AppException catch (e) {
      return Error(_mapException(e));
    } catch (e) {
      return Error(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<Category>>> getCategories() async {
    try {
      final list = await _remote.getCategories();
      return Success(list.map((e) => e.toEntity()).toList());
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
