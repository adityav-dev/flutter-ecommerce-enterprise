import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/environment_config.dart';
import 'core/logger/app_logger.dart';
import 'core/network/api_client.dart';
import 'core/services/storage_service.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/cart_remote_datasource.dart';
import 'data/datasources/order_remote_datasource.dart';
import 'data/datasources/payment_remote_datasource.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'data/datasources/wishlist_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/cart_repository_impl.dart';
import 'data/repositories/order_repository_impl.dart';
import 'data/repositories/payment_repository_impl.dart';
import 'data/repositories/product_repository_impl.dart';
import 'data/repositories/wishlist_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/cart_repository.dart';
import 'domain/repositories/order_repository.dart';
import 'domain/repositories/payment_repository.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/repositories/wishlist_repository.dart';
import 'domain/usecases/auth/login_usecase.dart';
import 'domain/usecases/auth/logout_usecase.dart';
import 'domain/usecases/cart/add_to_cart_usecase.dart';
import 'domain/usecases/cart/get_cart_usecase.dart';
import 'domain/usecases/cart/remove_from_cart_usecase.dart';
import 'domain/usecases/order/get_my_orders_usecase.dart';
import 'domain/usecases/order/place_order_usecase.dart';
import 'domain/usecases/product/get_categories_usecase.dart';
import 'domain/usecases/product/get_products_usecase.dart';
import 'domain/usecases/wishlist/add_to_wishlist_usecase.dart';
import 'domain/usecases/wishlist/get_wishlist_usecase.dart';

final GetIt sl = GetIt.instance;

Future<void> initInjection({
  EnvironmentConfig? environmentConfig,
}) async {
  // Environment
  if (environmentConfig != null) {
    EnvironmentConfig.initialize(environmentConfig);
  } else {
    EnvironmentConfig.initialize(EnvironmentConfigs.dev);
  }

  // Core
  sl.registerLazySingleton<AppLogger>(() => AppLoggerImpl());
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<StorageService>(() => StorageServiceImpl(prefs));
  sl.registerLazySingleton<ApiClient>(() => ApiClient(
        storageService: sl<StorageService>(),
        logger: sl<AppLogger>(),
      ));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiClient>(), sl<StorageService>()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton<WishlistRemoteDataSource>(
    () => WishlistRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(sl<ApiClient>()),
  );
  sl.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(sl<ApiClient>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>(), sl<StorageService>()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl<ProductRemoteDataSource>()),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(sl<CartRemoteDataSource>()),
  );
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(sl<WishlistRemoteDataSource>()),
  );
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(sl<OrderRemoteDataSource>()),
  );
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(sl<PaymentRemoteDataSource>()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetProductsUseCase(sl<ProductRepository>()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl<ProductRepository>()));
  sl.registerLazySingleton(() => GetCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => GetWishlistUseCase(sl<WishlistRepository>()));
  sl.registerLazySingleton(() => AddToWishlistUseCase(sl<WishlistRepository>()));
  sl.registerLazySingleton(() => PlaceOrderUseCase(sl<OrderRepository>()));
  sl.registerLazySingleton(() => GetMyOrdersUseCase(sl<OrderRepository>()));
}
