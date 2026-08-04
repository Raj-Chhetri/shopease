import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../services/changepassword2_service.dart';

class ChangePassword2Controller extends GetxController {
  final ChangePassword2Service _service = ChangePassword2Service();

  // ============================================================
  // TEXT CONTROLLERS
  // ============================================================

  final TextEditingController currentPasswordController =
      TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  // ============================================================
  // LOADING
  // ============================================================

  final RxBool isLoading = false.obs;

  // ============================================================
  // PASSWORD VISIBILITY
  // ============================================================

  final RxBool obscureCurrentPassword = true.obs;

  final RxBool obscureNewPassword = true.obs;

  final RxBool obscureConfirmPassword = true.obs;

  // ============================================================
  // CHANGE PASSWORD
  // ============================================================

  Future<void> changePassword() async {
    final currentPassword = currentPasswordController.text.trim();

    final newPassword = newPasswordController.text.trim();

    final confirmPassword = confirmPasswordController.text.trim();

    // ----------------------------------------------------------
    // VALIDATION
    // ----------------------------------------------------------

    if (currentPassword.isEmpty) {
      _showError('Please enter your current password.');
      return;
    }

    if (newPassword.isEmpty) {
      _showError('Please enter your new password.');
      return;
    }

    if (confirmPassword.isEmpty) {
      _showError('Please confirm your new password.');
      return;
    }

    if (newPassword.length < 8) {
      _showError('New password must be at least 8 characters.');
      return;
    }

    if (newPassword != confirmPassword) {
      _showError('New password and confirmation password do not match.');
      return;
    }

    // ----------------------------------------------------------
    // API REQUEST
    // ----------------------------------------------------------

    try {
      isLoading.value = true;

      final response = await _service.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPasswordConfirmation: confirmPassword,
      );

      print('======================================');
      print('CONTROLLER RESPONSE');
      print('SUCCESS: ${response.success}');
      print('MESSAGE: ${response.message}');
      print('======================================');

      // --------------------------------------------------------
      // SUCCESS
      // --------------------------------------------------------

      if (response.success) {
        Fluttertoast.showToast(
          msg: response.message.isNotEmpty
              ? response.message
              : 'Password updated successfully.',
          toastLength: Toast.LENGTH_SHORT,
        );

        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        Get.back();

        return;
      }

      // --------------------------------------------------------
      // API ERROR
      // --------------------------------------------------------

      _showError(
        response.message.isNotEmpty
            ? response.message
            : 'Unable to update password.',
      );
    } catch (e) {
      _showError(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  // ============================================================
  // TOGGLE CURRENT PASSWORD
  // ============================================================

  void toggleCurrentPassword() {
    obscureCurrentPassword.value = !obscureCurrentPassword.value;
  }

  // ============================================================
  // TOGGLE NEW PASSWORD
  // ============================================================

  void toggleNewPassword() {
    obscureNewPassword.value = !obscureNewPassword.value;
  }

  // ============================================================
  // TOGGLE CONFIRM PASSWORD
  // ============================================================

  void toggleConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  // ============================================================
  // ERROR
  // ============================================================

  void _showError(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}
