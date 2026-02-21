import 'package:flutter/material.dart';

/// Admin product CRUD foundation placeholder.
/// Wire to ProductRepository (admin endpoints: create, update, delete product).
class AdminProductsPlaceholder extends StatelessWidget {
  const AdminProductsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin — Products')),
      body: const Center(
        child: Text(
          'Admin product CRUD → extend ProductRepository with create/update/delete',
        ),
      ),
    );
  }
}
