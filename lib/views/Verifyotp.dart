// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:shopease/views/changepassword_screen.dart';
// import 'package:shopease/widgets/Screentitle.dart';
// import 'package:shopease/widgets/button_widget.dart';
// import 'package:shopease/widgets/otpfield.dart';

// class Verifyotp extends StatefulWidget {
//   const Verifyotp({super.key});

//   @override
//   State<Verifyotp> createState() => _VerifyotpState();
// }

// class _VerifyotpState extends State<Verifyotp> {
//   final focus1=FocusNode();
//   final focus2=FocusNode();
//   final focus3=FocusNode();
//   final focus4=FocusNode();

//   final controller1=TextEditingController();
//   final controller2=TextEditingController();
//   final controller3=TextEditingController();
//   final controller4=TextEditingController();





//    @override
//   void dispose() {
//     controller1.dispose();
//     controller2.dispose();
//     controller3.dispose();
//     controller4.dispose();



//     focus1.dispose();
//     focus2.dispose();
//     focus3.dispose();
//     focus4.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Padding(
//         padding: const EdgeInsets.all(22.0),
//         child: Column(
//           children: [
//             ScreenTitle(text: "VERIFY OTP"),
//             Text("We have sent a verification code at example@gmail.com",
//             textAlign: TextAlign.center,),
//            Gap(10),
//            Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               OtpField(
//                 currentfocus: focus1,
//                  nextfocus: focus2,
//                   controller: controller1,
//                  ),
//               OtpField(
//                 currentfocus: focus2,
//                 previousfocus: focus1,
//                 nextfocus: focus3,
//                  controller:controller2,
//               ),
//               OtpField(
//                 currentfocus: focus3,
//                 nextfocus: focus4,
//                 previousfocus: focus2, 
//                 controller: controller3,),
//               OtpField(
//                 currentfocus: focus4,
//                 previousfocus: focus3,
//                  controller: controller4,)
//             ],
//            ),
//            Gap(20),
           
//            ButtonWidget(buttonText: "Verify", backgroundColor:  Color(0xFF6D28FF), onPressed: () {Get.off(()=>ChangepasswordScreen());  }, color: Colors.white,)

//           ],
          
          
//         ),
//       )
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopease/views/changepassword_screen.dart';
import 'package:shopease/widgets/button_widget.dart';

class Verifyotp extends StatefulWidget {
  final String email;

  const Verifyotp({
    super.key,
    required this.email,
  });

  @override
  State<Verifyotp> createState() => _VerifyotpState();
}

class _VerifyotpState extends State<Verifyotp> {
  static const Color _primaryColor = Color(0xFF6D28FF);
  static const int _otpLength = 6;

  final List<TextEditingController> _controllers = List.generate(
    _otpLength,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(
    _otpLength,
    (_) => FocusNode(),
  );

  bool _isVerifying = false;
  bool _isResending = false;
  String? _errorMessage;

  String get _otp {
    return _controllers
        .map((controller) => controller.text)
        .join();
  }

  bool get _isOtpComplete {
    return _otp.length == _otpLength &&
        _controllers.every(
          (controller) => controller.text.length == 1,
        );
  }

  String get _maskedEmail {
    final email = widget.email.trim();
    final separatorIndex = email.lastIndexOf('@');

    if (separatorIndex <= 0 ||
        separatorIndex == email.length - 1) {
      return email;
    }

    final username = email.substring(0, separatorIndex);
    final domain = email.substring(separatorIndex + 1);

    if (username.length == 1) {
      return '${username[0]}***@$domain';
    }

    if (username.length == 2) {
      return '${username[0]}***@$domain';
    }

    return '${username.substring(0, 2)}***@$domain';
  }

  void _handleOtpChanged(
    int index,
    String value,
  ) {
    setState(() {
      _errorMessage = null;
    });

    final digits = value.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    if (digits.length > 1) {
      _fillOtpFromPaste(
        digits,
        startIndex: index,
      );
      return;
    }

    if (digits.isNotEmpty) {
      if (_controllers[index].text != digits) {
        _controllers[index]
          ..text = digits
          ..selection = TextSelection.collapsed(
            offset: digits.length,
          );
      }

      if (index < _otpLength - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        FocusScope.of(context).unfocus();
      }
    }

    if (_isOtpComplete) {
      FocusScope.of(context).unfocus();
    }
  }

  void _fillOtpFromPaste(
    String value, {
    int startIndex = 0,
  }) {
    final digits = value.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    if (digits.isEmpty) {
      return;
    }

    final availableLength = _otpLength - startIndex;
    final limitedDigits = digits.substring(
      0,
      digits.length > availableLength
          ? availableLength
          : digits.length,
    );

    for (
      int offset = 0;
      offset < limitedDigits.length;
      offset++
    ) {
      final controllerIndex = startIndex + offset;

      _controllers[controllerIndex]
        ..text = limitedDigits[offset]
        ..selection = const TextSelection.collapsed(
          offset: 1,
        );
    }

    setState(() {
      _errorMessage = null;
    });

    final nextIndex = startIndex + limitedDigits.length;

    if (nextIndex >= _otpLength) {
      FocusScope.of(context).unfocus();
    } else {
      _focusNodes[nextIndex].requestFocus();
    }
  }

  void _handleBackspace(int index) {
    if (_controllers[index].text.isNotEmpty) {
      _controllers[index].clear();

      setState(() {
        _errorMessage = null;
      });

      return;
    }

    if (index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();

      setState(() {
        _errorMessage = null;
      });
    }
  }

  FocusNode _firstEmptyFocusNode() {
    for (int index = 0; index < _controllers.length; index++) {
      if (_controllers[index].text.isEmpty) {
        return _focusNodes[index];
      }
    }

    return _focusNodes.first;
  }

  Future<void> _verifyOtp() async {
    FocusScope.of(context).unfocus();

    if (!_isOtpComplete) {
      setState(() {
        _errorMessage =
            'Please enter the complete $_otpLength-digit code.';
      });

      _firstEmptyFocusNode().requestFocus();
      return;
    }

    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });

    try {
      // Replace this delay with:
      // POST /api/auth/verify-otp
      //
      // Use the exact request field names expected by your backend.
      await Future<void>.delayed(
        const Duration(milliseconds: 800),
      );

      if (!mounted) {
        return;
      }

      // Temporary validation for UI testing.
      // Remove this after connecting the backend.
      if (_otp == '000000') {
        setState(() {
          _errorMessage =
              'The verification code is incorrect.';
        });

        _focusNodes.first.requestFocus();
        return;
      }

      Get.off(
        () => ChangepasswordScreen(
          email: widget.email,
        ),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 350),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorMessage =
            'We could not verify the code. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
      }
    }
  }

  Future<void> _resendCode() async {
    if (_isResending || _isVerifying) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isResending = true;
      _errorMessage = null;
    });

    try {
      // Replace with the resend OTP endpoint.
      await Future<void>.delayed(
        const Duration(milliseconds: 700),
      );

      if (!mounted) {
        return;
      }

      for (final controller in _controllers) {
        controller.clear();
      }

      _focusNodes.first.requestFocus();

      Get.snackbar(
        'Code sent',
        'A new verification code has been sent to ${widget.email}.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorMessage =
            'Unable to resend the code. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: _isVerifying
              ? null
              : () => Get.back(),
          tooltip: 'Back',
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding =
                constraints.maxWidth < 360 ? 16.0 : 22.0;

            return SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                32,
                horizontalPadding,
                28,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 60,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                    ),
                    child: AutofillGroup(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'VERIFY OTP',
                            textAlign: TextAlign.center,
                            style:
                                theme.textTheme.headlineMedium?.copyWith(
                              color:
                                  theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'We have sent a verification code to\n'
                            '$_maskedEmail',
                            textAlign: TextAlign.center,
                            style:
                                theme.textTheme.bodyLarge?.copyWith(
                              color: theme
                                  .colorScheme
                                  .onSurfaceVariant,
                              height: 1.5,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 32),
                          _buildOtpFields(context),
                          AnimatedSize(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            curve: Curves.easeOut,
                            child: _errorMessage == null
                                ? const SizedBox(height: 24)
                                : Padding(
                                    padding:
                                        const EdgeInsets.only(
                                      top: 12,
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      _errorMessage!,
                                      textAlign:
                                          TextAlign.center,
                                      style: const TextStyle(
                                        color:
                                            Colors.redAccent,
                                        fontSize: 13,
                                        fontWeight:
                                            FontWeight.w500,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                          ),
                          ButtonWidget(
                            buttonText: _isVerifying
                                ? 'Verifying...'
                                : 'Verify',
                            backgroundColor: _primaryColor,
                            color: Colors.white,
                            onPressed: _isVerifying
                                ? null
                                : _verifyOtp,
                          ),
                          const SizedBox(height: 18),
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment:
                                WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Didn't receive the code?",
                                style: theme
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  color: theme
                                      .colorScheme
                                      .onSurfaceVariant,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              TextButton(
                                onPressed:
                                    _isVerifying || _isResending
                                        ? null
                                        : _resendCode,
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      _primaryColor,
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                ),
                                child: Text(
                                  _isResending
                                      ? 'Sending...'
                                      : 'Resend',
                                  style: const TextStyle(
                                    fontWeight:
                                        FontWeight.w700,
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildOtpFields(BuildContext context) {
    const spacing = 8.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        final calculatedWidth =
            (availableWidth - spacing * (_otpLength - 1)) /
                _otpLength;

        final fieldWidth = calculatedWidth.clamp(
          38.0,
          64.0,
        );

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _otpLength,
            (index) {
              return Padding(
                padding: EdgeInsets.only(
                  right:
                      index == _otpLength - 1 ? 0 : spacing,
                ),
                child: SizedBox(
                  width: fieldWidth,
                  child: _OtpInputField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    autofocus: index == 0,
                    isLastField:
                        index == _otpLength - 1,
                    onChanged: (value) {
                      _handleOtpChanged(index, value);
                    },
                    onBackspace: () {
                      _handleBackspace(index);
                    },
                    onSubmitted: () {
                      if (index == _otpLength - 1) {
                        _verifyOtp();
                      } else {
                        _focusNodes[index + 1]
                            .requestFocus();
                      }
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final bool isLastField;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;
  final VoidCallback onSubmitted;

  const _OtpInputField({
    required this.controller,
    required this.focusNode,
    required this.autofocus,
    required this.isLastField,
    required this.onChanged,
    required this.onBackspace,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return KeyboardListener(
      focusNode: FocusNode(
        skipTraversal: true,
      ),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey ==
                LogicalKeyboardKey.backspace &&
            controller.text.isEmpty) {
          onBackspace();
        }
      },
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        keyboardType: TextInputType.number,
        textInputAction: isLastField
            ? TextInputAction.done
            : TextInputAction.next,
        textAlign: TextAlign.center,
        autofillHints: const [
          AutofillHints.oneTimeCode,
        ],
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(6),
        ],
        style: theme.textTheme.titleLarge?.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w800,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor:
              theme.colorScheme.surfaceContainerHighest,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: theme.colorScheme.outlineVariant,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: theme.colorScheme.outlineVariant,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: _VerifyotpState._primaryColor,
              width: 2,
            ),
          ),
        ),
        onChanged: onChanged,
        onFieldSubmitted: (_) => onSubmitted(),
      ),
    );
  }
}
 