import '../../domain/entities/order.dart';
import '../../domain/entities/order_status.dart';
import 'product_model.dart';

class OrderItemModel {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double total;

  const OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['product_id'] as String? ?? json['productId'] as String,
      productName: json['product_name'] as String? ?? json['productName'] as String,
      quantity: json['quantity'] as int,
      unitPrice: (json['unit_price'] as num?)?.toDouble() ?? (json['unitPrice'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }

  OrderItem toEntity() => OrderItem(
        productId: productId,
        productName: productName,
        quantity: quantity,
        unitPrice: unitPrice,
        total: total,
      );
}

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.items,
    required super.subtotal,
    super.tax = 0,
    super.shipping = 0,
    required super.total,
    required super.status,
    super.paymentIntentId,
    super.shippingAddressId,
    required super.createdAt,
    super.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final itemsList = json['items'] as List<dynamic>? ?? json['order_items'] as List<dynamic>? ?? [];
    final items = itemsList
        .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();
    final statusStr = json['status'] as String? ?? 'created';
    return OrderModel(
      id: json['id'] as String,
      userId: json['user_id'] as String? ?? json['userId'] as String,
      items: items,
      subtotal: (json['subtotal'] as num).toDouble(),
      tax: (json['tax'] as num?)?.toDouble() ?? 0,
      shipping: (json['shipping'] as num?)?.toDouble() ?? 0,
      total: (json['total'] as num).toDouble(),
      status: OrderStatus.fromString(statusStr),
      paymentIntentId: json['payment_intent_id'] as String? ?? json['paymentIntentId'] as String?,
      shippingAddressId:
          json['shipping_address_id'] as String? ?? json['shippingAddressId'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String? ?? json['createdAt'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : json['updatedAt'] != null
              ? DateTime.tryParse(json['updatedAt'] as String)
              : null,
    );
  }

  Order toEntity() => this;
}
