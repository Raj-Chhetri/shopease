import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification_models.dart';

class NotificationService {
  late final Dio _dio;

  NotificationService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://shopease.sudamhub.com/api",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        validateStatus: (status) => status! < 500,
      ),
    );
  }

  /// Read token from SharedPreferences
  Future<void> _setToken() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    if (token == null || token.isEmpty) {
      throw Exception("User is not logged in.");
    }

    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  /// Get all notifications
  Future<NotificationListModel> getNotifications() async {
    try {
      await _setToken();

      final response = await _dio.get("/notifications");

      if (response.statusCode == 200) {
        return NotificationListModel.fromJson(response.data);
      }

      throw Exception(response.data.toString());
    } on DioException catch (e) {
      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  /// Get notification detail
  Future<NotificationDetailModel> getNotification(int id) async {
    try {
      await _setToken();

      final response = await _dio.get("/notifications/$id");

      if (response.statusCode == 200) {
        return NotificationDetailModel.fromJson(response.data);
      }

      throw Exception(response.data.toString());
    } on DioException catch (e) {
      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  /// Mark one notification as read
  Future<MarkOneReadModel> markOneRead(int id) async {
    try {
      await _setToken();

      final response = await _dio.patch("/notifications/$id/read");

      if (response.statusCode == 200) {
        return MarkOneReadModel.fromJson(response.data);
      }

      throw Exception(response.data.toString());
    } on DioException catch (e) {
      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  /// Mark one notification as unread
  Future<MarkOneUnreadModel> markOneUnread(int id) async {
    try {
      await _setToken();

      final response = await _dio.patch("/notifications/$id/unread");

      if (response.statusCode == 200) {
        return MarkOneUnreadModel.fromJson(response.data);
      }

      throw Exception(response.data.toString());
    } on DioException catch (e) {
      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  /// Mark all notifications as read
  Future<MarkAllReadModel> markAllRead() async {
    try {
      await _setToken();

      final response = await _dio.patch("/notifications/read-all");

      if (response.statusCode == 200) {
        return MarkAllReadModel.fromJson(response.data);
      }

      throw Exception(response.data.toString());
    } on DioException catch (e) {
      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }
}
