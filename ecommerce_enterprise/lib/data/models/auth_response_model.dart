import '../../domain/entities/auth_response.dart';
import 'user_model.dart';

class AuthResponseModel extends AuthResponse {
  const AuthResponseModel({
    required super.accessToken,
    super.refreshToken,
    required super.user,
    super.expiresIn,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['token'] as String? ?? json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      expiresIn: json['expires_in'] as int? ?? json['expiresIn'] as int?,
    );
  }

  AuthResponse toEntity() => this;
}
