import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String? slug;
  final String? parentId;
  final int productCount;
  final bool isActive;

  const Category({
    required this.id,
    required this.name,
    this.slug,
    this.parentId,
    this.productCount = 0,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [id, name];
}
