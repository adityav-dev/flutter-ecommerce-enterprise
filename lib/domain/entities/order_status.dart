import 'package:equatable/equatable.dart';

/// Order lifecycle states for the e-commerce flow.
/// See README for full lifecycle explanation.
enum OrderStatusEnum {
  created,
  paymentPending,
  paymentSuccess,
  confirmed,
  shipped,
  delivered,
  cancelled,
  refunded,
}

class OrderStatus extends Equatable {
  final OrderStatusEnum value;
  final String displayName;

  const OrderStatus(this.value, this.displayName);

  static const created = OrderStatus(OrderStatusEnum.created, 'Created');
  static const paymentPending = OrderStatus(OrderStatusEnum.paymentPending, 'Payment Pending');
  static const paymentSuccess = OrderStatus(OrderStatusEnum.paymentSuccess, 'Payment Success');
  static const confirmed = OrderStatus(OrderStatusEnum.confirmed, 'Confirmed');
  static const shipped = OrderStatus(OrderStatusEnum.shipped, 'Shipped');
  static const delivered = OrderStatus(OrderStatusEnum.delivered, 'Delivered');
  static const cancelled = OrderStatus(OrderStatusEnum.cancelled, 'Cancelled');
  static const refunded = OrderStatus(OrderStatusEnum.refunded, 'Refunded');

  static OrderStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'created':
        return created;
      case 'payment_pending':
        return paymentPending;
      case 'payment_success':
        return paymentSuccess;
      case 'confirmed':
        return confirmed;
      case 'shipped':
        return shipped;
      case 'delivered':
        return delivered;
      case 'cancelled':
        return cancelled;
      case 'refunded':
        return refunded;
      default:
        return created;
    }
  }

  @override
  List<Object?> get props => [value];
}
