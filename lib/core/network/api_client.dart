import 'package:dio/dio.dart';

import '../config/environment_config.dart';
import '../error/exceptions.dart';
import '../logger/app_logger.dart';
import '../services/storage_service.dart';

/// Base API client using Dio.
/// - Attaches JWT to requests
/// - Handles 401 and token refresh (structure only; implement refresh when backend is ready)
/// - Centralized error mapping to [AppException]
class ApiClient {
  ApiClient({
    required StorageService storageService,
    required AppLogger logger,
    Dio? dio,
  })  : _storage = storageService,
        _logger = logger,
        _dio = dio ?? Dio() {
    _dio.options.baseUrl = EnvironmentConfig.current.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    _dio.interceptors.addAll([
      _AuthInterceptor(_storage),
      _ErrorInterceptor(_logger),
      LogInterceptor(
        requestBody: EnvironmentConfig.current.enableLogging,
        responseBody: EnvironmentConfig.current.enableLogging,
        logPrint: (obj) => _logger.debug(obj.toString()),
      ),
    ]);
  }

  final StorageService _storage;
  final AppLogger _logger;
  final Dio _dio;

  Dio get dio => _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  AppException _mapDioException(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = e.response?.data is Map
        ? (e.response!.data as Map)['message']?.toString() ?? e.message ?? 'Network error'
        : e.message ?? 'Network error';

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return NetworkException(message: message);
    }
    if (statusCode == 401) {
      return AuthException(message: message, statusCode: statusCode);
    }
    if (statusCode != null && statusCode >= 400 && statusCode < 500) {
      return ValidationException(message: message, statusCode: statusCode);
    }
    return ServerException(message: message, statusCode: statusCode);
  }
}

class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._storage);
  final StorageService _storage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.getString(StorageKeys.accessToken);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401: optionally trigger token refresh and retry (implement when backend supports refresh).
    if (err.response?.statusCode == 401) {
      // await refreshTokenAndRetry(err, handler);
    }
    handler.next(err);
  }
}

class _ErrorInterceptor extends Interceptor {
  _ErrorInterceptor(this._logger);
  final AppLogger _logger;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error(
      'API Error: ${err.requestOptions.path}',
      err,
      err.stackTrace,
    );
    handler.next(err);
  }
}
