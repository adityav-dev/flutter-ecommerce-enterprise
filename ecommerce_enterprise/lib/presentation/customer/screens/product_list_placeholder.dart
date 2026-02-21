import 'package:flutter/material.dart';

/// Placeholder for customer product listing screen.
/// Wire to GetProductsUseCase and GetCategoriesUseCase for category filtering.
class ProductListPlaceholder extends StatelessWidget {
  const ProductListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: const Center(
        child: Text(
          'Product listing + category filter → use GetProductsUseCase, GetCategoriesUseCase',
        ),
      ),
    );
  }
}
