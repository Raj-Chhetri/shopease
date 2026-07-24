import 'package:dio/dio.dart';
import '../models/notification.dart';
import '../models/notification_settings.dart';

class NotificationService {
  final String baseUrl = 'https://shopease.sudamhub.com/api';
  final String token;

  late final Dio _dio;

  NotificationService({required this.token}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  // 1. GET Get Notification
  Future<List<Notification>> getNotifications() async {
    try {
      final response = await _dio.get('/notifications');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Notification.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load notifications: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }

  // 2. PUT Mark All Notification
  Future<bool> markAllAsRead() async {
    try {
      final response = await _dio.put('/notifications/mark-all');

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      throw Exception('Failed to mark all as read: $e');
    }
  }

  // 3. GET Notification Settings
  Future<NotificationSettings> getNotificationSettings() async {
    try {
      final response = await _dio.get('/notifications/settings');

      if (response.statusCode == 200) {
        return NotificationSettings.fromJson(response.data);
      } else {
        throw Exception('Failed to load settings: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching settings: $e');
    }
  }

  // 4. POST toggle notification on/off
  Future<bool> toggleNotification(bool enable) async {
    try {
      final response = await _dio.post(
        '/notifications/toggle',
        data: {'enabled': enable},
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw Exception('Failed to toggle notification: $e');
    }
  }

  // 5. PUT update notification setting
  Future<NotificationSettings> updateNotificationSetting(
    NotificationSettings settings,
  ) async {
    try {
      final response = await _dio.put(
        '/notifications/settings',
        data: settings.toJson(),
      );

      if (response.statusCode == 200) {
        return NotificationSettings.fromJson(response.data);
      } else {
        throw Exception('Failed to update settings: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating settings: $e');
    }
  }

  // 6. GET Notification status
  Future<Map<String, dynamic>> getNotificationStatus() async {
    try {
      final response = await _dio.get('/notifications/status');

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to get status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting notification status: $e');
    }
  }

  // Helper Methods
  Future<void> refreshNotifications() async {
    await getNotifications();
  }

  void updateToken(String newToken) {
    _dio.options.headers['Authorization'] = 'Bearer $newToken';
  }
}
