import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/changepassword2_controller.dart';

class ChangePassword2 extends StatelessWidget {
  ChangePassword2({super.key});

  final ChangePassword2Controller controller = Get.put(
    ChangePassword2Controller(),
  );

  static const Color primaryColor = Color(0xFF6D28FF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),

        title: Text(
          "change_password".tr,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double pageWidth;

            if (constraints.maxWidth < 600) {
              pageWidth = constraints.maxWidth;
            } else if (constraints.maxWidth < 1000) {
              pageWidth = constraints.maxWidth * .75;
            } else {
              pageWidth = constraints.maxWidth * .55;
            }

            return Center(
              child: SizedBox(
                width: pageWidth,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 6, 24, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 6),

                      Obx(
                        () => _passwordField(
                          context: context,
                          controller: controller.currentPasswordController,
                          obscureText: controller.obscureCurrentPassword.value,
                          label: "current_password".tr,
                          hintText: "enter_current_password".tr,
                          onToggle: controller.toggleCurrentPassword,
                          textInputAction: TextInputAction.next,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Obx(
                        () => _passwordField(
                          context: context,
                          controller: controller.newPasswordController,
                          obscureText: controller.obscureNewPassword.value,
                          label: "new_password".tr,
                          hintText: "enter_new_password".tr,
                          onToggle: controller.toggleNewPassword,
                          textInputAction: TextInputAction.next,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Obx(
                        () => _passwordField(
                          context: context,
                          controller: controller.confirmPasswordController,
                          obscureText: controller.obscureConfirmPassword.value,
                          label: "confirm_password".tr,
                          hintText: "confirm_new_password".tr,
                          onToggle: controller.toggleConfirmPassword,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) {
                            if (!controller.isLoading.value) {
                              controller.changePassword();
                            }
                          },
                        ),
                      ),

                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 18,
                            color: primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "password_requirement".tr,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      Obx(
                        () => SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.changePassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              disabledBackgroundColor: primaryColor.withOpacity(
                                .6,
                              ),
                            ),
                            child: controller.isLoading.value
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    "change_password".tr,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //==============================================================
  // PASSWORD FIELD
  //==============================================================
  Widget _passwordField({
    required BuildContext context,
    required TextEditingController controller,
    required bool obscureText,
    required String label,
    required String hintText,
    required VoidCallback onToggle,
    required TextInputAction textInputAction,
    Function(String)? onSubmitted,
  }) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      obscureText: obscureText,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      style: theme.textTheme.bodyLarge,

      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,

        labelStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),

        hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),

        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(.5),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),

        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: primaryColor, width: 1.8),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 1.8),
        ),

        prefixIcon: const Icon(Icons.lock_outline_rounded),

        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              key: ValueKey(obscureText),
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
