import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    super.slug,
    super.parentId,
    super.productCount = 0,
    super.isActive = true,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String?,
      parentId: json['parent_id'] as String? ?? json['parentId'] as String?,
      productCount: json['product_count'] as int? ?? json['productCount'] as int? ?? 0,
      isActive: json['is_active'] as bool? ?? json['isActive'] as bool? ?? true,
    );
  }

  Category toEntity() => this;
}
