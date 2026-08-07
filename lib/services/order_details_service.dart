import 'package:dio/dio.dart';
import 'package:shopease/models/order_details_model.dart';
import 'package:shopease/services/dio_service.dart';

class OrderDetailsService {
  final Dio _dio = DioService().dio;

  Future<OrderDetailsModel> getOrderDetails(int orderId) async {
    final response = await _dio.get(
      '/orders/$orderId',
      options: Options(
        headers: {
          'Authorization':
              'Bearer qHjhCLJ8qpZAS3f6HODAKwdRbGJEQ74OL9KHRM0od152e9f5',
        },
      ),
    );

return OrderDetailsModel.fromJson(
  response.data['data'],
);
  }

   Future<void> cancelOrder(int orderId) async {
    await _dio.put(
      '/orders/$orderId/cancel',
      options: Options(
        headers: {
          'Authorization':
              'Bearer qHjhCLJ8qpZAS3f6HODAKwdRbGJEQ74OL9KHRM0od152e9f5',
        },
      ),
    );
  }
}








