import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/changepassword2_model.dart';

class ChangePassword2Service {
  static const String baseUrl = "https://shopease.sudamhub.com/api";

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      validateStatus: (status) => status! < 500,
    ),
  );

  /// Load token from SharedPreferences
  Future<void> _setToken() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    if (token == null || token.isEmpty) {
      throw Exception("User is not logged in.");
    }

    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  Future<ChangePassword2Model> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      // Load latest token
      await _setToken();

      print("======================================");
      print("CHANGE PASSWORD REQUEST");
      print("URL: $baseUrl/profile/password");
      print("AUTHORIZATION: ${_dio.options.headers["Authorization"]}");
      print("BODY:");
      print({
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
      });
      print("======================================");

      final response = await _dio.put(
        "/profile/password",
        data: {
          "current_password": currentPassword,
          "new_password": newPassword,
          "new_password_confirmation": newPasswordConfirmation,
        },
      );

      print("======================================");
      print("CHANGE PASSWORD RESPONSE");
      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.data}");
      print("======================================");

      return ChangePassword2Model.fromJson(response.data);
    } on DioException catch (e) {
      print("======================================");
      print("CHANGE PASSWORD API ERROR");
      print("STATUS: ${e.response?.statusCode}");
      print("BODY: ${e.response?.data}");
      print("======================================");

      String message = "Password update failed.";

      if (e.response?.data is Map) {
        message =
            e.response?.data["message"] ??
            e.message ??
            "Password update failed.";
      } else if (e.message != null) {
        message = e.message!;
      }

      return ChangePassword2Model(success: false, message: message, data: null);
    } catch (e) {
      print("======================================");
      print("CHANGE PASSWORD UNKNOWN ERROR");
      print(e);
      print("======================================");

      return ChangePassword2Model(
        success: false,
        message: e.toString(),
        data: null,
      );
    }
  }
}
