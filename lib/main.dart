import 'package:flutter/material.dart';

import 'core/config/environment_config.dart';
import 'injection_container.dart';
import 'presentation/customer/screens/product_list_placeholder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection(environmentConfig: EnvironmentConfigs.dev);
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce Enterprise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ProductListPlaceholder(),
    );
  }
}
