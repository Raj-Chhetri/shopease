import 'package:dio/dio.dart';
import 'package:shopease/models/notification_models.dart';

import '../models/notification_models.dart';

class NotificationService {
  static const String token =
      "332|yIOlvXeuRDmdnG7D2OW1fEzejkDd60m6TslCR3eB91f859f3";

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://shopease.sudamhub.com/api",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      validateStatus: (status) => status! < 500,
    ),
  );

  Future<NotificationListModel> getNotifications() async {
    try {
      final response = await _dio.get("/notifications");

      if (response.statusCode == 200) {
        return NotificationListModel.fromJson(response.data);
      }

      throw Exception(response.data.toString());
    } on DioException catch (e) {
      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  Future<NotificationDetailModel> getNotification(int id) async {
    try {
      final response = await _dio.get("/notifications/$id");

      if (response.statusCode == 200) {
        return NotificationDetailModel.fromJson(response.data);
      }

      throw Exception(response.data.toString());
    } on DioException catch (e) {
      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  Future<MarkOneReadModel> markOneRead(int id) async {
    try {
      final response = await _dio.patch("/notifications/$id/read");

      if (response.statusCode == 200) {
        return MarkOneReadModel.fromJson(response.data);
      }

      throw Exception(response.data.toString());
    } on DioException catch (e) {
      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  Future<MarkOneUnreadModel> markOneUnread(int id) async {
    try {
      final response = await _dio.patch("/notifications/$id/unread");

      if (response.statusCode == 200) {
        return MarkOneUnreadModel.fromJson(response.data);
      }

      throw Exception(response.data.toString());
    } on DioException catch (e) {
      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  Future<MarkAllReadModel> markAllRead() async {
    try {
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
