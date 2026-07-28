import 'package:dio/dio.dart';
import 'package:shopease/models/change_password_model.dart';
import 'package:shopease/models/forgotpassword_model.dart';
import 'package:shopease/models/login_response.dart';
import 'package:shopease/models/register_response.dart';
import 'package:shopease/models/verify_otp_model.dart';
import 'package:shopease/utils/Api_connect.dart';

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

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        "/auth/login",
        data: {
          "email": email.trim(),
          "password": password,
        },
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Login failed",
      );
    }
  }





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
    throw Exception(
      e.response?.data["message"] ??
          "Registration failed",
    );
  }
}






  static Future<ForgotPasswordModel> forgotpassword(
    String email,
) async {
  try {
    final response = await Apiconnect.dio.post(
      "auth/forgot-password",
      data: {
        "email": email,
      },
    );

    return ForgotPasswordModel.fromJson(response.data);
  } on DioException catch (e) {
    return ForgotPasswordModel(
      success: false,
      message: e.response?.data["message"] ??
          e.message ??
          "Something went wrong",
      data: null,
    );
  }
}
 static Future<VerifyOtp> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {

      final response = await Apiconnect.dio.post(
        "auth/verify-otp",
        data: {
          "email": email,
          "otp": otp,
          "type": "password_reset",
        },
        
      );
      
      return VerifyOtp.fromJson(response.data);
    } on DioException catch (e) {
      return VerifyOtp(
        success: false,
        message: e.response?.data["message"] ??
            e.message ??
            "Verification failed",
        data: null,
      );
    } catch (e) {
      return VerifyOtp(
        success: false,
        message: e.toString(),
        data: null,
      );
    }
  }
  //Service to change password
  Future<ChangePasswordModel> changepassword({
    required String email,
    required String changepassword,
    required String confirmchangepassword
  })async{
try{
  final response=await Apiconnect.dio.post("/auth/reset-password",
  data: {
    "email":email,
    "password":changepassword,
    "password_confirmation":confirmchangepassword
    }
    );
    return ChangePasswordModel.fromJson(response.data);

}
on DioException catch(e){
  return ChangePasswordModel(
    success: false,
     message:
          e.response?.data["message"] ??
          e.message ??
          "Password reset failed",
      data: null,
      );

}
  }
  
  //Service to resend the otp
    Future<ForgotPasswordModel> resendOtp(String email) async {
    try {
      final response = await Apiconnect.dio.post(
        "auth/forgot-password",
        data: {
          "email": email,
        },
      );

      return ForgotPasswordModel.fromJson(response.data);
    } on DioException catch (e) {
      return ForgotPasswordModel(
        success: false,
        message:
            e.response?.data["message"] ??
            e.message ??
            "Failed to resend OTP",
        data: null,
      );
    }
  }
}