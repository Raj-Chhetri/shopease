import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/models/order_tracking_step.dart';
import 'package:shopease/services/dio_service.dart';

class OrderTrackingService {
  final DioService _dioService = DioService();

  Future<List<OrderTrackingStep>> getOrderTracking(
    int orderId,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await _dioService.dio.get(
        '/orders/$orderId/tracking',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      final responseData = response.data;

      if (responseData is! Map<String, dynamic>) {
        throw Exception('Invalid tracking response.');
      }

      final trackingData = responseData['data'];

      if (trackingData is! List) {
        return [];
      }

      return trackingData
          .whereType<Map<String, dynamic>>()
          .map(
            (item) => OrderTrackingStep.fromJson(item),
          )
          .toList();
    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData is Map<String, dynamic>) {
        final message = responseData['message']?.toString();

        if (message != null && message.isNotEmpty) {
          throw Exception(message);
        }
      }

      throw Exception(
        'Unable to load tracking information.',
      );
    } catch (e) {
      throw Exception(
        e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}