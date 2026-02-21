import 'package:shared_preferences/shared_preferences.dart';

/// Abstraction for persistent key-value storage.
/// Used for JWT token storage, user preferences, etc.
/// Implementation can be swapped for secure_storage in production.
abstract class StorageService {
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  Future<void> remove(String key);
  Future<void> clear();
  Future<bool> containsKey(String key);
}

class StorageServiceImpl implements StorageService {
  StorageServiceImpl(this._prefs);
  final SharedPreferences _prefs;

  @override
  Future<void> setString(String key, String value) => _prefs.setString(key, value);

  @override
  Future<String?> getString(String key) async => _prefs.getString(key);

  @override
  Future<void> remove(String key) => _prefs.remove(key);

  @override
  Future<void> clear() => _prefs.clear();

  @override
  Future<bool> containsKey(String key) async => _prefs.containsKey(key);
}

/// Keys used for token and auth-related storage.
class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String tokenExpiry = 'token_expiry';
  static const String userId = 'user_id';
}
