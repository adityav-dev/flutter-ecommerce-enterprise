import '../../repositories/auth_repository.dart';
import '../../../core/utils/result.dart';
import '../../entities/auth_response.dart';

class LoginUseCase {
  LoginUseCase(this._repository);
  final AuthRepository _repository;

  Future<Result<AuthResponse>> call(String email, String password) {
    return _repository.login(email, password);
  }
}
