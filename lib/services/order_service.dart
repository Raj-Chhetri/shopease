import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/models/order_model.dart';
import 'package:shopease/services/dio_service.dart';

class OrderService {
  final Dio _dio = DioService().dio;

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<OrderModel>> getOrders() async {
    final token = await _getToken();

    if (token == null || token.isEmpty) {
      throw Exception('User is not logged in.');
    }

    final response = await _dio.get(
      '/orders',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final responseData = response.data;

    final List<dynamic> orderList =
        responseData is Map<String, dynamic>
            ? (responseData['data'] ?? [])
            : [];

    return orderList
        .whereType<Map<String, dynamic>>()
        .map((e) => OrderModel.fromJson(e))
        .toList();
  }

  Future<void> cancelOrder(int orderId) async {
    final token = await _getToken();

    if (token == null || token.isEmpty) {
      throw Exception('User is not logged in.');
    }

    await _dio.put(
      '/orders/$orderId/cancel',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<void> returnOrder(
    int orderId, {
    String note = 'I want to return this order',
  }) async {
    final token = await _getToken();

    if (token == null || token.isEmpty) {
      throw Exception('User is not logged in.');
    }

    await _dio.post(
      '/orders/$orderId/return',
      data: {
        'note': note,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future addReview({
    required int orderId,
    required int productId,
    required int rating,
    required String comment,
  }) async {
    final token = await _getToken();

    if (token == null || token.isEmpty) {
      throw Exception('User is not logged in.');
    }

    await _dio.post(
      '/orders/$orderId/review',
      data: {
        'product_id': productId,
        'rating': rating,
        'comment': comment,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}








