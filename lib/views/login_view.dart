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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

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

    slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    animationController.forward();
    _restoreRememberedEmail();
  }

  Future<void> _restoreRememberedEmail() async {
    final email = await controller.loadRememberedEmail();

    if (!mounted) return;

    _emailController.text = email;
  }

  void _login() {
    controller.login(
      formKey: _formKey,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    animationController.dispose();
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
                final horizontalPadding = constraints.maxWidth < 360
                    ? 16.0
                    : 22.0;

                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),

                    // Login text
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 460),
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: SlideTransition(
                            position: slideAnimation,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'login'.tr.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 40),

                                  // Email
                                  EmailField(
                                    text: 'email'.tr,
                                    hintText: 'enter_email'.tr,
                                    icon: Icons.email_rounded,
                                    controller: _emailController,
                                    focusNode: _emailFocus,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [AutofillHints.email],
                                    validator: controller.validateEmail,
                                    onFieldSubmitted: (_) {
                                      _passwordFocus.requestFocus();
                                    },
                                  ),

                                  const SizedBox(height: 24),

                                  // Password
                                  PasswordFieldWidget(
                                    text: 'password'.tr,
                                    hintText: 'enter_password'.tr,
                                    controller: _passwordController,
                                    focusNode: _passwordFocus,
                                    textInputAction: TextInputAction.done,
                                    validator: controller.validatePassword,
                                    onFieldSubmitted: (_) => _login(),
                                  ),

                                  const SizedBox(height: 8),

                                  // Remember me and forgot password text
                                  Row(
                                    children: [
                                      Obx(
                                        () => Checkbox(
                                          value: controller.rememberMe.value,
                                          activeColor: primaryColor,
                                          onChanged: (value) {
                                            controller.rememberMe.value =
                                                value ?? false;
                                          },
                                        ),
                                      ),

                                      Text(
                                        'remember_me'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),

                                      Spacer(),

                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed:
                                              controller.openForgotPassword,
                                          style: TextButton.styleFrom(
                                            foregroundColor: primaryColor,
                                          ),
                                          child: Text('forgot_password'.tr),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: isCompactHeight ? 18 : 28),

                                  // Login button
                                  Obx(
                                    () => SizedBox(
                                      width: double.infinity,
                                      child: ButtonWidget(
                                        buttonText: controller.isLoading.value
                                            ? 'logging_in'.tr
                                            : 'login'.tr,
                                        backgroundColor: primaryColor,
                                        color: Colors.white,
                                        onPressed: controller.isLoading.value
                                            ? null
                                            : _login,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  // Don't have an account? and sign up text
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'no_account'.tr,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: controller.openRegister,
                                        style: TextButton.styleFrom(
                                          foregroundColor: primaryColor,
                                        ),
                                        child: Text(
                                          'sign_up'.tr,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height:
                                        MediaQuery.paddingOf(context).bottom +
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
