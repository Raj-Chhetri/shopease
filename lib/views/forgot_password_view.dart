// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopease/views/Verifyotp.dart';
// import 'package:shopease/widgets/Screentitle.dart';
// import 'package:shopease/widgets/button_widget.dart';
// import 'package:shopease/widgets/emailfield.dart';

// class ForgotPasswordView extends StatelessWidget {
//   const ForgotPasswordView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Padding(
//         padding: const EdgeInsets.all(22.0),
//         child: Column(
//           children: [
//             ScreenTitle(text: "FORGOT PASSWORD"),
//             EmailField(text: "Email",
//              hintText: "Enter your email",
//               icon: Icons.mail,
//               keyboardType: TextInputType.emailAddress,
//               ),
              
//             ButtonWidget(buttonText: "Next", backgroundColor: Color(0xFF6D28FF), onPressed: () {Get.to(()=>Verifyotp()); }, color: Colors.white,)
//           ],
//         ),
//       ) ,
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/views/Verifyotp.dart';
import 'package:shopease/widgets/button_widget.dart';
import 'package:shopease/widgets/emailfield.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  static const Color _primaryColor = Color(0xFF6D28FF);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  bool _isLoading = false;

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

  Future<void> _continueToVerification() async {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Replace this delay with the forgot-password API request later.
      await Future<void>.delayed(
        const Duration(milliseconds: 700),
      );

      if (!mounted) return;

      Get.to(
        () => Verifyotp(
          email: _emailController.text.trim(),
        ),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 350),
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
    _emailController.dispose();
    _emailFocusNode.dispose();
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
                                CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'FORGOT PASSWORD',
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
                                icon: Icons.mail_rounded,
                                controller: _emailController,
                                focusNode: _emailFocusNode,
                                keyboardType:
                                    TextInputType.emailAddress,
                                textInputAction:
                                    TextInputAction.done,
                                autofillHints: const [
                                  AutofillHints.email,
                                ],
                                validator: _validateEmail,
                                onFieldSubmitted: (_) {
                                  _continueToVerification();
                                },
                              ),
                              const SizedBox(height: 28),
                              SizedBox(
                                width: double.infinity,
                                child: ButtonWidget(
                                  buttonText:
                                      _isLoading
                                          ? 'Sending...'
                                          : 'Next',
                                  backgroundColor: _primaryColor,
                                  color: Colors.white,
                                  onPressed:
                                      _isLoading
                                          ? null
                                          : () async {
                                              await _continueToVerification();
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