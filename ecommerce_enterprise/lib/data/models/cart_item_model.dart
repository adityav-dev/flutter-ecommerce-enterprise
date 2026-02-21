import '../../domain/entities/cart_item.dart';
import 'product_model.dart';

class CartItemModel {
  final String productId;
  final ProductModel product;
  final int quantity;

  const CartItemModel({
    required this.productId,
    required this.product,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['product_id'] as String? ?? json['productId'] as String,
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
    );
  }

  CartItem toEntity() => CartItem(
        productId: productId,
        product: product,
        quantity: quantity,
      );
}
