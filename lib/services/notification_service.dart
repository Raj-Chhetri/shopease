import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../models/notification_model.dart';

class NotificationService {
  late final Dio _dio;
  final storage = GetStorage();

  NotificationService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://shopease.sudamhub.com/api/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Automatically attach token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = storage.read('token');
          if (token != null && token.toString().isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  // ==================== REAL API ====================

  /// Get all notifications
  Future<Map<String, dynamic>> getNotifications() async {
    final response = await _dio.get('notifications');
    return response.data;
  }

  /// Mark one as read
  Future<void> markAsRead(int id) async {
    await _dio.patch('notifications/$id/read');
  }

  /// Mark one as unread
  Future<void> markAsUnread(int id) async {
    await _dio.patch('notifications/$id/unread');
  }

  /// Mark all as read
  Future<void> markAllAsRead() async {
    await _dio.patch('notifications/read-all');
  }
}
