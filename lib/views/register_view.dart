// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopease/views/login_view.dart';
// import 'package:shopease/widgets/Screentitle.dart';
// import 'package:shopease/widgets/button_widget.dart';
// import 'package:shopease/widgets/emailfield.dart';
// import 'package:shopease/widgets/passwordfield_widget.dart';

// class RegisterView extends StatelessWidget {
//   const RegisterView({super.key});

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
    
//               // back icon and title
//               ScreenTitle(
//                 text: "Register"
//               ),
              
    
//               // Name
//               EmailField(
//                 text: "Name", 
//                 hintText: "Enter your name", 
//                 icon: Icons.person
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
    
    
//               // confirm password
//               PasswordFieldWidget(
//                 text: "Confirm Password", 
//                 hintText: "Confirm your password"
//               ),
    
    
//               // create account button
//               Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 50,
//                       width: double.infinity,
//                       child: ButtonWidget(
//                         buttonText: "Create Account",
//                         backgroundColor: Color(0xFF6D28FF), 
//                         onPressed: () { 
//                           Get.to(() => LoginView());
//                          }, color: Colors.white,
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
import 'package:shopease/views/login_view.dart';
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

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _isLoading = false;

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) {
      return 'Please enter your name';
    }

    if (name.length < 2) {
      return 'Name must contain at least 2 characters';
    }

    return null;
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  Future<void> _createAccount() async {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Replace this delay with the registration API request later.
      await Future<void>.delayed(
        const Duration(milliseconds: 800),
      );

      if (!mounted) return;

      Get.snackbar(
        'Account created',
        'Your account was created successfully',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        icon: const Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
        ),
      );

      Get.off(
        () => const LoginView(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 250),
      );
    } catch (_) {
      if (!mounted) return;

      Get.snackbar(
        'Registration failed',
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

  void _openLogin() {
    FocusScope.of(context).unfocus();

    Get.off(
      () => const LoginView(),
      transition: Transition.leftToRight,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

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
            // Positioned(
            //   top: 0,
            //   left: 8,
            //   child: IconButton(
            //     onPressed: _isLoading ? null : Get.back,
            //     tooltip: 'Back',
            //     icon: const Icon(
            //       Icons.arrow_back_rounded,
            //       size: 26,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding =
                    constraints.maxWidth < 360 ? 16.0 : 22.0;

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
                        constraints: const BoxConstraints(
                          maxWidth: 460,
                        ),
                        child: AutofillGroup(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
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
                                  controller: _nameController,
                                  focusNode: _nameFocusNode,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [
                                    AutofillHints.name,
                                  ],
                                  validator: _validateName,
                                  onFieldSubmitted: (_) {
                                    _emailFocusNode.requestFocus();
                                  },
                                ),

                                const SizedBox(height: 24),

                                EmailField(
                                  text: 'Email',
                                  hintText: 'Enter your email',
                                  icon: Icons.email_rounded,
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  keyboardType:
                                      TextInputType.emailAddress,
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
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [
                                    AutofillHints.newPassword,
                                  ],
                                  validator: _validatePassword,
                                  onFieldSubmitted: (_) {
                                    _confirmPasswordFocusNode
                                        .requestFocus();
                                  },
                                ),

                                const SizedBox(height: 24),

                                PasswordFieldWidget(
                                  text: 'Confirm Password',
                                  hintText: 'Confirm your password',
                                  controller:
                                      _confirmPasswordController,
                                  focusNode:
                                      _confirmPasswordFocusNode,
                                  textInputAction: TextInputAction.done,
                                  autofillHints: const [
                                    AutofillHints.newPassword,
                                  ],
                                  validator: _validateConfirmPassword,
                                  onFieldSubmitted: (_) {
                                    _createAccount();
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

                                ButtonWidget(
                                  buttonText: _isLoading
                                      ? 'Creating Account...'
                                      : 'Create Account',
                                  backgroundColor: _primaryColor,
                                  color: Colors.white,
                                  onPressed: _isLoading
                                      ? null
                                      : () async {
                                          await _createAccount();
                                        },
                                ),

                                const SizedBox(height: 18),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
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
                                    TextButton(
                                      onPressed:
                                          _isLoading ? null : _openLogin,
                                      style: TextButton.styleFrom(
                                        foregroundColor: _primaryColor,
                                        padding:
                                            const EdgeInsets.symmetric(
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
          ],
        ),
      ),
    );
  }
}