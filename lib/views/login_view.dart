

// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:shopease/views/forgot_password_view.dart';
// import 'package:shopease/views/homescreen.dart';
// import 'package:shopease/views/register_view.dart';
// import 'package:shopease/widgets/Screentitle.dart';
// import 'package:shopease/widgets/emailfield.dart';


// import 'package:shopease/widgets/button_widget.dart';
// import 'package:shopease/widgets/passwordfield_widget.dart';

// class LoginView extends StatelessWidget {
//   const LoginView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
    
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 22.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
          
//               // / back icon and title
//               ScreenTitle(
//                 text: "LOGIN"
//               ),
          
//               // Email
//               EmailField(
//                 text: "Email", 
//                 hintText: "Enter your email", 
//                 icon: Icons.email,
//               ),
          
          
//               // password
//               PasswordFieldWidget(
//                 text: "Password", 
//                 hintText: "Enter your password"
//               ),
              
          
//               // forget text
//               Row(
//                 children: [
//                   Spacer(),
//                   TextButton(
//                     onPressed: () {
//                       Get.to(() => ForgotPasswordView());
//                     },
//                     child: Text(
//                       "Forgot Password?",
//                       style: TextStyle(
//                         color: Color(0xFF6D28FF),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
          
//               Gap(28),
          
//               // login button
//              ButtonWidget(
//               buttonText: "Login", 
//               backgroundColor:  Color(0xFF6D28FF),
//               onPressed: () {
//                 Get.offAll(() => HomeScreen());
//               }, 
//               color: Colors.white,
//             ),
          
//               Gap(25),
          
//               // sign Up
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Don't have an account?",
//                     style: TextStyle(
//                       fontSize: 15, 
//                       color: Colors.black
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Get.to(() => RegisterView());
//                     },
//                     child: Text(
//                       " Sign Up",
//                       style: TextStyle(
//                         color: Color(0xFF6D28FF),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
          
          
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/views/forgot_password_view.dart';
import 'package:shopease/views/homescreen.dart';
import 'package:shopease/views/main_navigation_screen.dart';
import 'package:shopease/views/register_view.dart';
import 'package:shopease/widgets/Screentitle.dart';
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
  static const Color _primaryColor = Color(0xFF6D28FF);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Please enter your email address';
    }

    if (!GetUtils.isEmail(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Please enter your password';
    }

    if (password.length < 6) {
      return 'Password must contain at least 6 characters';
    }

    return null;
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Temporary delay until backend authentication is ready.
      await Future<void>.delayed(const Duration(milliseconds: 900));

      if (!mounted) return;

      Get.offAll(
        () => const MainNavigationScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 400),
      );
    } catch (_) {
      if (!mounted) return;

      Get.snackbar(
        'Login failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _openForgotPassword() {
    FocusScope.of(context).unfocus();

    Get.to(
      () => const ForgotPasswordView(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 350),
    );
  }

  void _openRegister() {
    FocusScope.of(context).unfocus();

    Get.to(
      () => const RegisterView(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children:[ LayoutBuilder(
            builder: (context, constraints) {
              final isCompactHeight = constraints.maxHeight < 650;
              final horizontalPadding = constraints.maxWidth < 360 ? 16.0 : 22.0;
          
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 460,
                      ),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                    child: Text(
                                      'LOGIN',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 27,
                                        height: 1.2,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
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
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [
                                    AutofillHints.email,
                                  ],
                                  validator: _validateEmail,
                                  onFieldSubmitted: (_) {
                                    _passwordFocusNode.requestFocus();
                                  },
                                ),
                                const SizedBox(height: 24),
                                PasswordFieldWidget(
                                  text: 'Password',
                                  hintText: 'Enter your password',
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  textInputAction: TextInputAction.done,
                                  validator: _validatePassword,
                                  onFieldSubmitted: (_) => _login(),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed:
                                        _isLoading
                                            ? null
                                            : _openForgotPassword,
                                    style: TextButton.styleFrom(
                                      foregroundColor: _primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 8,
                                      ),
                                      minimumSize: const Size(0, 44),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: isCompactHeight ? 18 : 28,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ButtonWidget(
                                    buttonText:
                                        _isLoading ? 'Logging in...' : 'Login',
                                    backgroundColor: _primaryColor,
                                    color: Colors.white,
                                    onPressed: _isLoading ? null : _login,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Flexible(
                                      child: Text(
                                        "Don't have an account?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed:
                                          _isLoading ? null : _openRegister,
                                      style: TextButton.styleFrom(
                                        foregroundColor: _primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        minimumSize: const Size(0, 44),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.paddingOf(context).bottom + 20,
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
              child: IconButton(
                onPressed: _isLoading ? null : Get.back,
                tooltip: 'Back',
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 26,
                  color: Colors.black,
                ),
              ),
            ),
        ]
        ),
      ),
    );
  }
}