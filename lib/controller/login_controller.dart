import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/services/auth_service.dart';
import 'package:shopease/views/forgot_password_view.dart';
import 'package:shopease/views/main_navigation_screen.dart';
import 'package:shopease/views/register_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final RxBool isLoading = false.obs;

  final RxBool rememberMe = false.obs;

  // Validators
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

  // Login
  Future<void> login() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    // Prevent multiple requests
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      final response = await _authService.login(
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text.trim(),
      );

      // Save after a successful login
      final prefs = await SharedPreferences.getInstance();

      if (rememberMe.value) {
        await prefs.setBool('remember_me', true);
        await prefs.setString('email', emailController.text.trim());

        // Better: Save the API token instead of the password.
        await prefs.setString('token', response.token);
      } else {
        await prefs.remove('remember_me');
        await prefs.remove('email');
        await prefs.remove('token');
      }

      Get.snackbar(
        'Success',
        response.message,
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAll(
        () => const MainNavigationScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 300),
      );
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigation
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

  // Dispose
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();

    super.onClose();
  }

  // Load saved data when the controller starts
  @override
  void onInit() {
    super.onInit();
    loadRememberMe();
  }

  Future<void> loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();

    emailController.text = prefs.getString("email") ?? "";

    // Always start unchecked
    rememberMe.value = false;
  }
}
