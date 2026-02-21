import 'package:equatable/equatable.dart';

import 'cart_item.dart';

/// Shopping cart entity: list of items and computed totals.
class Cart extends Equatable {
  final String? id;
  final String? userId;
  final List<CartItem> items;
  final DateTime? updatedAt;

  const Cart({
    this.id,
    this.userId,
    this.items = const [],
    this.updatedAt,
  });

  int get itemCount => items.fold(0, (int sum, i) => sum + i.quantity);
  double get subtotal => items.fold(0.0, (sum, i) => sum + i.lineTotal);

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  @override
  List<Object?> get props => [id, userId, items, updatedAt];
}
