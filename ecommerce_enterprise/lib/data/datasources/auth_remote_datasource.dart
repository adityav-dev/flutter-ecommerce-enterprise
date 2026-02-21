import '../../core/error/exceptions.dart';
import '../../core/network/api_client.dart';
import '../../core/services/storage_service.dart';
import '../models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(String email, String password);
  Future<AuthResponseModel> refreshToken();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._client, this._storage);
  final ApiClient _client;
  final StorageService _storage;

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    if (response.data == null) throw const ServerException(message: 'Empty response');
    final auth = AuthResponseModel.fromJson(response.data!);
    await _storage.setString(StorageKeys.accessToken, auth.accessToken);
    if (auth.refreshToken != null) {
      await _storage.setString(StorageKeys.refreshToken, auth.refreshToken!);
    }
    await _storage.setString(StorageKeys.userId, auth.user.id);
    return auth;
  }

  @override
  Future<AuthResponseModel> refreshToken() async {
    final refresh = await _storage.getString(StorageKeys.refreshToken);
    if (refresh == null || refresh.isEmpty) {
      throw const AuthException(message: 'No refresh token');
    }
    final response = await _client.post<Map<String, dynamic>>(
      '/auth/refresh',
      data: {'refresh_token': refresh},
    );
    if (response.data == null) throw const ServerException(message: 'Empty response');
    final auth = AuthResponseModel.fromJson(response.data!);
    await _storage.setString(StorageKeys.accessToken, auth.accessToken);
    if (auth.refreshToken != null) {
      await _storage.setString(StorageKeys.refreshToken, auth.refreshToken!);
    }
    return auth;
  }
}
