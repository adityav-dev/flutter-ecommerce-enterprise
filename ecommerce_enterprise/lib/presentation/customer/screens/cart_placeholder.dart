import 'package:flutter/material.dart';

/// Placeholder for customer cart screen.
/// Wire to GetCartUseCase, AddToCartUseCase, RemoveFromCartUseCase.
class CartPlaceholder extends StatelessWidget {
  const CartPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: const Center(
        child: Text(
          'Cart → GetCartUseCase, AddToCartUseCase, RemoveFromCartUseCase',
        ),
      ),
    );
  }
}
