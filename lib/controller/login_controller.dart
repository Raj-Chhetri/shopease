import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/routes/app_routes.dart';
import 'package:shopease/services/auth_service.dart';
import 'package:shopease/views/forgot_password_view.dart';
import 'package:shopease/views/register_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  final RxBool isLoading = false.obs;
  final RxBool rememberMe = false.obs;

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Please enter your email address';
    }

    if (!GetUtils.isEmail(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Please enter your password';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  Future<void> login({
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (isLoading.value) return;

    // Capture plain values before awaiting. The view may be removed while the
    // request is in flight, so the controller must not retain or read disposed
    // TextEditingController instances afterwards.
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedPassword = password.trim();

    isLoading.value = true;

    try {
      final response = await _authService.login(
        email: normalizedEmail,
        password: normalizedPassword,
      );

      // Save token immediately after successful login
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.token);

      // Optional: Save email if Remember Me is checked
      if (rememberMe.value) {
        await prefs.setBool('remember_me', true);
        await prefs.setString('email', normalizedEmail);
      } else {
        await prefs.remove('remember_me');
        await prefs.remove('email');
      }

      Get.snackbar(
        'Success',
        response.message,
        snackPosition: SnackPosition.TOP,
      );

      
      Get.offAllNamed(AppRoutes.mainNavigation);
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void openRegister() {
    Get.offAll(
      () => const RegisterView(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  void openForgotPassword() {
    Get.to(
      () => ForgotPasswordView(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<String> loadRememberedEmail() async {
    final prefs = await SharedPreferences.getInstance();

    // Preserve the existing behavior: prefill the saved email, but leave the
    // checkbox unchecked until the user opts in again.
    rememberMe.value = false;
    return prefs.getString('email') ?? '';
  }
}
