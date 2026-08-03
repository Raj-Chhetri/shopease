import 'user_model.dart';

class RegisterResponse {
  final bool success;
  final String message;
  final String token;
  final UserModel user;

  RegisterResponse({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    final data = json["data"];

    return RegisterResponse(
      success: json["success"],
      message: json["message"],
      token: data["token"],
      user: UserModel.fromJson(data["user"]),
    );
  }
}