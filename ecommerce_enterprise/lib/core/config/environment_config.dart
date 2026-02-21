/// Environment configuration for dev / staging / production.
/// Set via build flavors or environment variables before app init.
enum AppEnvironment { dev, staging, production }

class EnvironmentConfig {
  final AppEnvironment environment;
  final String baseUrl;
  final bool useMockData;
  final bool enableLogging;
  final String? stripePublishableKey;

  const EnvironmentConfig({
    required this.environment,
    required this.baseUrl,
    this.useMockData = false,
    this.enableLogging = true,
    this.stripePublishableKey,
  });

  static EnvironmentConfig get current => _instance!;
  static EnvironmentConfig? _instance;

  static void initialize(EnvironmentConfig config) {
    _instance = config;
  }

  bool get isDev => environment == AppEnvironment.dev;
  bool get isProduction => environment == AppEnvironment.production;
}

/// Predefined configs for quick setup.
class EnvironmentConfigs {
  static const dev = EnvironmentConfig(
    environment: AppEnvironment.dev,
    baseUrl: 'https://api-dev.example.com',
    useMockData: true,
    enableLogging: true,
    stripePublishableKey: 'pk_test_xxx',
  );

  static const staging = EnvironmentConfig(
    environment: AppEnvironment.staging,
    baseUrl: 'https://api-staging.example.com',
    useMockData: false,
    enableLogging: true,
    stripePublishableKey: 'pk_test_xxx',
  );

  static const production = EnvironmentConfig(
    environment: AppEnvironment.production,
    baseUrl: 'https://api.example.com',
    useMockData: false,
    enableLogging: false,
    stripePublishableKey: 'pk_live_xxx',
  );
}
