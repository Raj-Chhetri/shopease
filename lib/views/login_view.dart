import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/login_controller.dart';
import 'package:shopease/widgets/button_widget.dart';
import 'package:shopease/widgets/emailfield.dart';
import 'package:shopease/widgets/passwordfield_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  static const Color primaryColor = Color(0xFF6D28FF);

  late final AnimationController animationController;
  late final Animation<double> fadeAnimation;
  late final Animation<Offset> slideAnimation;

  final LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    Get.delete<LoginController>();
    super.dispose();
  }

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
                final isCompactHeight = constraints.maxHeight < 650;
                final horizontalPadding =
                    constraints.maxWidth < 360 ? 16.0 : 22.0;

                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 460),
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: SlideTransition(
                            position: slideAnimation,
                            child: Form(
                              key: controller.FormKey,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 40),

                                  EmailField(
                                    text: 'Email',
                                    hintText: 'Enter your email',
                                    icon: Icons.email_rounded,
                                    controller:
                                        controller.EmailController,
                                    focusNode: controller.EmailFocus,
                                    keyboardType:
                                        TextInputType.emailAddress,
                                    textInputAction:
                                        TextInputAction.next,
                                    autofillHints: const [
                                      AutofillHints.email,
                                    ],
                                    validator:
                                        controller.validateEmail,
                                    onFieldSubmitted: (_) {
                                      controller.PasswordFocus
                                          .requestFocus();
                                    },
                                  ),

                                  const SizedBox(height: 24),

                                  PasswordFieldWidget(
                                    text: 'Password',
                                    hintText:
                                        'Enter your password',
                                    controller:
                                        controller.PasswordController,
                                    focusNode:
                                        controller.PasswordFocus,
                                    textInputAction:
                                        TextInputAction.done,
                                    validator:
                                        controller.validatePassword,
                                    onFieldSubmitted: (_) =>
                                        controller.login(),
                                  ),

                                  Align(
                                    alignment:
                                        Alignment.centerRight,
                                    child: TextButton(
                                      onPressed:
                                          controller.openForgotPassword,
                                      style: TextButton.styleFrom(
                                        foregroundColor:
                                            primaryColor,
                                      ),
                                      child: const Text(
                                        "Forgot Password?",
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: isCompactHeight
                                        ? 18
                                        : 28,
                                  ),

                                  Obx(
                                    () => SizedBox(
                                      width: double.infinity,
                                      child: ButtonWidget(
                                        buttonText:
                                            controller.isLoading.value
                                                ? "Logging in..."
                                                : "Login",
                                        backgroundColor:
                                            primaryColor,
                                        color: Colors.white,
                                        onPressed:
                                            controller.isLoading.value
                                                ? null
                                                : controller.login,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      const Flexible(
                                        child: Text(
                                          "Don't have an account?",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                "Poppins",
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed:
                                            controller.openRegister,
                                        style:
                                            TextButton.styleFrom(
                                          foregroundColor:
                                              primaryColor,
                                        ),
                                        child: const Text(
                                          "Sign Up",
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height:
                                        MediaQuery.paddingOf(
                                                  context,
                                                )
                                                .bottom +
                                            20,
                                  ),
                                ],
                              ),
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