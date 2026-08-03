import 'user_model.dart';

class LoginResponse {
  final bool success;
  final String message;
  final String token;
  final UserModel user;

  LoginResponse({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json["data"];

    return LoginResponse(
      success: json["success"],
      message: json["message"],
      token: data["token"],
      user: UserModel.fromJson(data["user"]),
    );
  }
}