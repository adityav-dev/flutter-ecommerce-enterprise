import 'package:equatable/equatable.dart';

import 'order_status.dart';
import 'product.dart';

class OrderItem extends Equatable {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double total;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });

  @override
  List<Object?> get props => [productId, quantity, unitPrice];
}

class Order extends Equatable {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double subtotal;
  final double tax;
  final double shipping;
  final double total;
  final OrderStatus status;
  final String? paymentIntentId;
  final String? shippingAddressId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    this.tax = 0,
    this.shipping = 0,
    required this.total,
    required this.status,
    this.paymentIntentId,
    this.shippingAddressId,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, userId, status, total, createdAt];
}
