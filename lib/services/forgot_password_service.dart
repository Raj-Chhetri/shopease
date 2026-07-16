import '../models/forgot_password_model.dart';

class ForgotPasswordService {
  Future<bool> sendOtp(ForgotPasswordModel model) async {
    // Replace this with API call

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    return true;
  }
}