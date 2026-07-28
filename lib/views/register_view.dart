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

  final RegisterController controller = Get.put(RegisterController());

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
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 460),
                        child: AutofillGroup(
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'REGISTER',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 27,
                                    height: 1.2,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                const SizedBox(height: 40),

                                EmailField(
                                  text: 'Name',
                                  hintText: 'Enter your name',
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

                                EmailField(
                                  text: 'Email',
                                  hintText: 'Enter your email',
                                  icon: Icons.email_rounded,
                                  controller: controller.EmailController,
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

                                PasswordFieldWidget(
                                  text: 'Password',
                                  hintText: 'Enter your password',
                                  controller: controller.PasswordController,
                                  focusNode: controller.passwordFocusNode,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [
                                    AutofillHints.newPassword,
                                  ],
                                  validator: controller.validatePassword,
                                  onFieldSubmitted: (_) {
                                    controller.confirmPasswordFocusNode.requestFocus();
                                  },
                                ),

                                const SizedBox(height: 24),

                                PasswordFieldWidget(
                                  text: 'Confirm Password',
                                  hintText: 'Confirm your password',
                                  controller: controller.ConfirmPasswordController,
                                  focusNode: controller.confirmPasswordFocusNode,
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

                                const Text(
                                  'Use at least 8 characters with uppercase, lowercase and a number.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.5,
                                    color: Color(0xFF6B7280),
                                    fontFamily: 'Poppins',
                                  ),
                                ),

                                const SizedBox(height: 30),

                                Obx(
                                  () =>  ButtonWidget(
                                    buttonText: controller.isLoading.value
                                        ? 'Creating Account...'
                                        : 'Create Account',
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

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Flexible(
                                      child: Text(
                                        'Already have an account?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    Obx(
                                      () =>  TextButton(
                                        onPressed: controller.isLoading.value ? null : controller.openLogin,
                                        style: TextButton.styleFrom(
                                          foregroundColor: _primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                          ),
                                        ),
                                        child: const Text(
                                          'Log In',
                                          style: TextStyle(
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
                  onPressed: controller.isLoading.value
                      ? null
                      : Get.back,
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
