import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/forgot_password_model.dart';
import '../services/forgot_password_service.dart';
import '../views/Verifyotp.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final emailFocus = FocusNode();

  final isLoading = false.obs;

  final ForgotPasswordService _service = ForgotPasswordService();

  String? validateEmail(String? value) {
    final email = value?.trim() ?? "";

    if (email.isEmpty) {
      return "Please enter your email address";
    }

    if (!GetUtils.isEmail(email)) {
      return "Please enter a valid email address";
    }

    return null;
  }

  Future<void> sendOtp() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    isLoading.value = true;

    try {
      final model = ForgotPasswordModel(
        email: emailController.text.trim(),
      );

      final success = await _service.sendOtp(model);

      if (success) {
        Get.to(
          () => Verifyotp(
            email: model.email,
          ),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 350),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    emailFocus.dispose();
    super.onClose();
  }
}