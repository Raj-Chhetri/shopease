import 'package:dio/dio.dart';
import 'package:shopease/models/login_response.dart';
import 'package:shopease/models/register_response.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://shopease.sudamhub.com/api/",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  );

  

  // for login user
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        "/auth/login",
        data: {"email": email.trim(), "password": password},
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Login failed");
    }
  }



  // for register user
  Future<RegisterResponse> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    String? phone,
  }) async {
    try {
      final response = await _dio.post(
        "/auth/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": confirmPassword,
          "phone": phone,
        },
      );

      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Registration failed");
    }
  }
}
