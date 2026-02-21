import 'package:flutter/material.dart';

/// Placeholder for customer wishlist screen.
/// Wire to GetWishlistUseCase, AddToWishlistUseCase.
class WishlistPlaceholder extends StatelessWidget {
  const WishlistPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: const Center(
        child: Text(
          'Wishlist → GetWishlistUseCase, AddToWishlistUseCase',
        ),
      ),
    );
  }
}
