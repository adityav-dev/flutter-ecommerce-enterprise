import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/services/storage_service.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._storage);
  final AuthRemoteDataSource _remote;
  final StorageService _storage;

  @override
  Future<Result<AuthResponse>> login(String email, String password) async {
    try {
      final auth = await _remote.login(email, password);
      return Success(auth.toEntity());
    } on AppException catch (e) {
      if (e is AuthException) return Error(AuthFailure(message: e.message, code: e.code));
      if (e is NetworkException) return Error(NetworkFailure(message: e.message, code: e.code));
      return Error(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _storage.remove(StorageKeys.accessToken);
      await _storage.remove(StorageKeys.refreshToken);
      await _storage.remove(StorageKeys.userId);
      return const Success(null);
    } catch (e) {
      return Error(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<AuthResponse>> refreshToken() async {
    try {
      final auth = await _remote.refreshToken();
      return Success(auth.toEntity());
    } on AppException catch (e) {
      if (e is AuthException) return Error(AuthFailure(message: e.message, code: e.code));
      return Error(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _storage.getString(StorageKeys.accessToken);
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getAccessToken() => _storage.getString(StorageKeys.accessToken);
}
