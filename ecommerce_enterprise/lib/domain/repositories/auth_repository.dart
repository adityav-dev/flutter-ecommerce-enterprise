import '../entities/auth_response.dart';
import '../../core/utils/result.dart';

abstract class AuthRepository {
  Future<Result<AuthResponse>> login(String email, String password);
  Future<Result<void>> logout();
  Future<Result<AuthResponse>> refreshToken();
  Future<bool> isLoggedIn();
  Future<String?> getAccessToken();
}
