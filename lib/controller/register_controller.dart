import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/routes/app_routes.dart';
import 'package:shopease/services/auth_service.dart';
import 'package:shopease/views/login_view.dart';

class RegisterController extends GetxController {
  final AuthService _authService = AuthService();

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  final RxBool isLoading = false.obs;

  String? validateName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) {
      return 'Please enter your name';
    }

    if (name.length < 2) {
      return 'Name must contain at least 2 characters';
    }

    return null;
  }

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
      return 'Please enter a password';
    }

    if (password.length < 6) {
      return 'Password must contain at least 6 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Include at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Include at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Include at least one number';
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  Future<void> register() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (isLoading.value) return;

    isLoading.value = true;

    try {
      final response = await _authService.register(
        name: nameController.text.trim(),
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );


      // Save after a successful Register
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool("remember_me", true);
      await prefs.setString("token", response.token);
      await prefs.setString("email", response.user.email);




      Get.snackbar(
        "Success",
        response.message,
        snackPosition: SnackPosition.BOTTOM,
      );

      
      Get.offAllNamed(AppRoutes.mainNavigation);
    } catch (e) {
      Get.snackbar(
        "Registration Failed",
        e.toString().replaceFirst("Exception: ", ""),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void openLogin() {
    FocusManager.instance.primaryFocus?.unfocus();

    Get.offAll(
      () => const LoginView(),
      transition: Transition.leftToRight,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();

    super.onClose();
  }
}
