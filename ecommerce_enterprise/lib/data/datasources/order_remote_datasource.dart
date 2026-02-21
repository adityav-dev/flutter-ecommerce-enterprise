import '../../core/network/api_client.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> placeOrder({
    required String shippingAddressId,
    String? paymentIntentId,
  });
  Future<List<OrderModel>> getMyOrders({int page = 1, int limit = 20});
  Future<OrderModel> getOrderById(String id);
  Future<OrderModel> cancelOrder(String orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  OrderRemoteDataSourceImpl(this._client);
  final ApiClient _client;

  @override
  Future<OrderModel> placeOrder({
    required String shippingAddressId,
    String? paymentIntentId,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/orders',
      data: {
        'shipping_address_id': shippingAddressId,
        if (paymentIntentId != null) 'payment_intent_id': paymentIntentId,
      },
    );
    if (response.data == null) throw Exception('Failed to place order');
    return OrderModel.fromJson(response.data!);
  }

  @override
  Future<List<OrderModel>> getMyOrders({int page = 1, int limit = 20}) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/orders',
      queryParameters: {'page': page, 'limit': limit},
    );
    final data = response.data;
    if (data == null) return [];
    final list = data['data'] as List<dynamic>? ?? data['orders'] as List<dynamic>? ?? [];
    return list
        .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<OrderModel> getOrderById(String id) async {
    final response = await _client.get<Map<String, dynamic>>('/orders/$id');
    if (response.data == null) throw Exception('Order not found');
    return OrderModel.fromJson(response.data!);
  }

  @override
  Future<OrderModel> cancelOrder(String orderId) async {
    final response = await _client.put<Map<String, dynamic>>(
      '/orders/$orderId/cancel',
    );
    if (response.data == null) throw Exception('Failed to cancel order');
    return OrderModel.fromJson(response.data!);
  }
}
