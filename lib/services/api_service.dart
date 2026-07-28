import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio dio;
  final storage = GetStorage();

  ApiService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://shopease.sudamhub.com/api/",
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    // Auto attach token
    dio.interceptors.add(
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

  // ==================== AUTH ====================
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await dio.post(
      'auth/login',
      data: {'email': email, 'password': password},
    );
    return response.data;
  }

  // ==================== NOTIFICATIONS ====================

  Future<Map<String, dynamic>> getNotifications() async {
    final response = await dio.get('notifications');
    return response.data;
  }

  Future<void> markNotificationAsRead(int id) async {
    await dio.patch('notifications/$id/read');
  }

  Future<void> markNotificationAsUnread(int id) async {
    await dio.patch('notifications/$id/unread');
  }

  Future<void> markAllNotificationsAsRead() async {
    await dio.patch('notifications/read-all');
  }
}
