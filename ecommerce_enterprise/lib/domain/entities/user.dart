import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? role;
  final DateTime? createdAt;

  const User({
    required this.id,
    required this.email,
    this.name,
    this.role,
    this.createdAt,
  });

  bool get isAdmin => role?.toLowerCase() == 'admin';

  @override
  List<Object?> get props => [id, email];
}
