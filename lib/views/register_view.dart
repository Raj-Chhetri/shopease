import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/register_controller.dart';
import 'package:shopease/widgets/button_widget.dart';
import 'package:shopease/widgets/emailfield.dart';
import 'package:shopease/widgets/passwordfield_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  static const Color _primaryColor = Color(0xFF6D28FF);

  // final RegisterController controller = Get.put(RegisterController());

  final RegisterController controller = Get.put(
    RegisterController(),
    permanent: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding = constraints.maxWidth < 360
                    ? 16.0
                    : 22.0;

                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    72,
                    horizontalPadding,
                    24,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 96,
                    ),

                    // register text
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 460),
                        child: AutofillGroup(
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'register'.tr,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 27,
                                    height: 1.2,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                const SizedBox(height: 40),

                                // Name
                                EmailField(
                                  text: 'name'.tr,
                                  hintText: 'enter_name'.tr,
                                  icon: Icons.person_rounded,
                                  controller: controller.nameController,
                                  focusNode: controller.nameFocusNode,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [AutofillHints.name],
                                  validator: controller.validateName,
                                  onFieldSubmitted: (_) {
                                    controller.emailFocusNode.requestFocus();
                                  },
                                ),

                                const SizedBox(height: 24),

                                // Email
                                EmailField(
                                  text: 'email'.tr,
                                  hintText: 'enter_email'.tr,
                                  icon: Icons.email_rounded,
                                  controller: controller.emailController,
                                  focusNode: controller.emailFocusNode,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [AutofillHints.email],
                                  validator: controller.validateEmail,
                                  onFieldSubmitted: (_) {
                                    controller.passwordFocusNode.requestFocus();
                                  },
                                ),

                                const SizedBox(height: 24),

                                // Password
                                PasswordFieldWidget(
                                  text: 'password'.tr,
                                  hintText: 'enter_password'.tr,
                                  controller: controller.passwordController,
                                  focusNode: controller.passwordFocusNode,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [
                                    AutofillHints.newPassword,
                                  ],
                                  validator: controller.validatePassword,
                                  onFieldSubmitted: (_) {
                                    controller.confirmPasswordFocusNode
                                        .requestFocus();
                                  },
                                ),

                                const SizedBox(height: 24),

                                // confirm Password
                                PasswordFieldWidget(
                                  text: 'confirm_password'.tr,
                                  hintText: 'confirm_your_password'.tr,
                                  controller:
                                      controller.confirmPasswordController,
                                  focusNode:
                                      controller.confirmPasswordFocusNode,
                                  textInputAction: TextInputAction.done,
                                  autofillHints: const [
                                    AutofillHints.newPassword,
                                  ],
                                  validator: controller.validateConfirmPassword,
                                  onFieldSubmitted: (_) {
                                    controller.register();
                                  },
                                ),

                                const SizedBox(height: 12),

                                // Use at least 8 characters with uppercase, lowercase and a number. text
                                Text(
                                  'password_strength_hint'.tr,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 1.5,
                                    color: Color(0xFF6B7280),
                                    fontFamily: 'Poppins',
                                  ),
                                ),

                                const SizedBox(height: 30),

                                // Create Account button
                                Obx(
                                  () => ButtonWidget(
                                    buttonText: controller.isLoading.value
                                        ? 'creating_account'.tr
                                        : 'create_account'.tr,
                                    backgroundColor: _primaryColor,
                                    color: Colors.white,
                                    onPressed: controller.isLoading.value
                                        ? null
                                        : () async {
                                            await controller.register();
                                          },
                                  ),
                                ),

                                const SizedBox(height: 18),

                                // Already have an account? and Log in text
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'already_have_account'.tr,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () => TextButton(
                                        onPressed: controller.isLoading.value
                                            ? null
                                            : controller.openLogin,
                                        style: TextButton.styleFrom(
                                          foregroundColor: _primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                          ),
                                        ),
                                        child: Text(
                                          'login'.tr,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            Positioned(
              top: 0,
              left: 8,
              child: Obx(
                () => IconButton(
                  onPressed: controller.isLoading.value ? null : Get.back,
                  tooltip: 'Back',
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 26,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
