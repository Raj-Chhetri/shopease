import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification_model.dart';
import '../models/notification_setting.dart';

class NotificationService {
  final String baseUrl =
      "https://shopease.sudamhub.com/api/"; // Change later for live server

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // 1. GET Get Notification
  Future<List<AppNotification>> getNotifications({
    bool isRead = false,
    int perPage = 15,
  }) async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/notifications?is_read=$isRead&per_page=$perPage"),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> list = data['data'] ?? [];
      return list.map((item) => AppNotification.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  // 2. PUT Mark All Notification
  Future<void> markAllAsRead() async {
    final token = await _getToken();
    await http.put(
      Uri.parse("$baseUrl/notifications/mark-all"),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  // 3. GET Notification Settings
  Future<NotificationSetting> getNotificationSettings() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/notification-settings"),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return NotificationSetting.fromJson(data['data'] ?? data);
    }
    throw Exception('Failed to load settings');
  }

  // 4. POST Toggle notification on/off
  Future<void> toggleNotification(String type, bool enabled) async {
    final token = await _getToken();
    await http.post(
      Uri.parse("$baseUrl/notifications/toggle"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'type': type, 'enabled': enabled}),
    );
  }

  // 5. PUT Update notification setting
  Future<void> updateNotificationSettings(NotificationSetting setting) async {
    final token = await _getToken();
    await http.put(
      Uri.parse("$baseUrl/notification-settings"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'push_enabled': setting.pushEnabled,
        'email_enabled': setting.emailEnabled,
        'order_updates': setting.orderUpdates,
        'promotions': setting.promotions,
      }),
    );
  }

  // 6. GET Notification status
  Future<Map<String, dynamic>> getNotificationStatus() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/notifications/status"),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'] ?? {};
    }
    throw Exception('Failed to load status');
  }
}
