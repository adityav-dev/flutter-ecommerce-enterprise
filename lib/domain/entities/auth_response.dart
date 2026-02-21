import 'package:equatable/equatable.dart';

import 'user.dart';

class AuthResponse extends Equatable {
  final String accessToken;
  final String? refreshToken;
  final User user;
  final int? expiresIn;

  const AuthResponse({
    required this.accessToken,
    this.refreshToken,
    required this.user,
    this.expiresIn,
  });

  @override
  List<Object?> get props => [accessToken, user];
}
