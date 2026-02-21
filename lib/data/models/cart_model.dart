import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_item_model.dart';

class CartModel extends Cart {
  const CartModel({
    super.id,
    super.userId,
    super.items = const [],
    super.updatedAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>? ?? [];
    final items = itemsList
        .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();
    return CartModel(
      id: json['id'] as String?,
      userId: json['user_id'] as String? ?? json['userId'] as String?,
      items: items,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : json['updatedAt'] != null
              ? DateTime.tryParse(json['updatedAt'] as String)
              : null,
    );
  }

  Cart toEntity() => this;
}
