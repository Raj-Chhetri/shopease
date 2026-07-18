// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';

// import 'package:shopease/views/login_view.dart';
// import 'package:shopease/widgets/Screentitle.dart';

// import 'package:shopease/widgets/passwordfield_widget.dart';

// class ChangepasswordScreen extends StatelessWidget {
//   const ChangepasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(22),
//           child: Column(
//             children: [
//           ScreenTitle(text: "CHANGE PASSWORD"),
//            PasswordFieldWidget(text: 'New Password', hintText: 'Enter new Password',),
//            PasswordFieldWidget(text: "Confirm Password ", hintText: "Re-enter new Password"),
//            Row(
//         children: [
//           Expanded(
//             child: FilledButton.icon(
//               style: FilledButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 60),
//                 backgroundColor:  Color(0xFF6D28FF),
//                 side: BorderSide(color: Colors.grey.shade300),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadiusGeometry.circular(15),
//                 ),
//                 elevation: 0,
                
//               ),
//               onPressed: (){
//                 Get.snackbar(
//                   "Sucess",
//                    "Password changed sucessfully",
//                    duration: const Duration(seconds: 2)
//                    );
                
//                 Future.delayed(Duration(seconds: 2),(){
//                   Get.offAll(()=>LoginView());
//                 });
//               },
              
//               label: Text(
//                 "Change Password",
//                 style: TextStyle(
//                   fontSize: 21,
//                   fontWeight: FontWeight.bold,
//                   color:Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//             )
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
import 'package:shopease/widgets/passwordfield_widget.dart';

class ChangepasswordScreen extends StatefulWidget {
  const ChangepasswordScreen({
    super.key,
    required this.email
  });

  final String email;

  @override
  State<ChangepasswordScreen> createState() =>
      _ChangepasswordScreenState();
}

class _ChangepasswordScreenState extends State<ChangepasswordScreen> {
  static const Color _primaryColor = Color(0xFF6D28FF);

  final _formKey = GlobalKey<FormState>();

  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _isLoading = false;

  String? _validateNewPassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Please enter a new password';
    }

    if (password.length < 8) {
      return 'Password must contain at least 8 characters';
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
    final confirmPassword = value ?? '';

    if (confirmPassword.isEmpty) {
      return 'Please confirm your new password';
    }

    if (confirmPassword != _newPasswordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  Future<void> _changePassword() async {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Replace this delay with the password-reset API request later.
      await Future<void>.delayed(
        const Duration(milliseconds: 900),
      );

      if (!mounted) return;

      Get.snackbar(
        'Success',
        'Password changed successfully',
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

      await Future<void>.delayed(
        const Duration(seconds: 2),
      );

      if (!mounted) return;

      Get.offAll(
        () => const LoginView(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 350),
      );
    } catch (_) {
      if (!mounted) return;

      Get.snackbar(
        'Unable to change password',
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

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    _newPasswordFocusNode.dispose();
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'CHANGE PASSWORD',
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
                              PasswordFieldWidget(
                                text: 'New Password',
                                hintText: 'Enter new password',
                                controller: _newPasswordController,
                                focusNode: _newPasswordFocusNode,
                                textInputAction:
                                    TextInputAction.next,
                                autofillHints: const [
                                  AutofillHints.newPassword,
                                ],
                                validator: _validateNewPassword,
                                onFieldSubmitted: (_) {
                                  _confirmPasswordFocusNode
                                      .requestFocus();
                                },
                              ),
                              const SizedBox(height: 24),
                              PasswordFieldWidget(
                                text: 'Confirm Password',
                                hintText: 'Re-enter new password',
                                controller:
                                    _confirmPasswordController,
                                focusNode:
                                    _confirmPasswordFocusNode,
                                textInputAction:
                                    TextInputAction.done,
                                autofillHints: const [
                                  AutofillHints.newPassword,
                                ],
                                validator:
                                    _validateConfirmPassword,
                                onFieldSubmitted: (_) {
                                  _changePassword();
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
                              const SizedBox(height: 32),
                              SizedBox(
                                width: double.infinity,
                                child: ButtonWidget(
                                  buttonText: _isLoading
                                      ? 'Changing Password...'
                                      : 'Change Password',
                                  backgroundColor: _primaryColor,
                                  color: Colors.white,
                                  onPressed: _isLoading
                                      ? null
                                      : () async {
                                          await _changePassword();
                                        },
                                ),
                              ),
                            ],
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
          ],
        ),
      ),
    );
  }
}
