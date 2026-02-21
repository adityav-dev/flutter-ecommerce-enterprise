import '../../repositories/auth_repository.dart';
import '../../../core/utils/result.dart';

class LogoutUseCase {
  LogoutUseCase(this._repository);
  final AuthRepository _repository;

  Future<Result<void>> call() => _repository.logout();
}
