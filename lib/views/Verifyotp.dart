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
import 'package:shopease/controller/Auth_controller.dart';
import 'package:shopease/widgets/otp_input_field.dart';


import '../widgets/button_widget.dart';


class Verifyotp extends StatelessWidget {
  Verifyotp({
    super.key,
    required this.email,
  });

  final String email;

  final ForgotPasswordController controller =
      Get.find<ForgotPasswordController>();

  static const Color primaryColor = Color(0xFF6D28FF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: theme.scaffoldBackgroundColor,
          foregroundColor: theme.colorScheme.onSurface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: controller.isLoading.value
                ? null
                : () => Get.back(),
            icon: const Icon(Icons.arrow_back_rounded),
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
                      constraints:
                          const BoxConstraints(maxWidth: 500),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [

                          Text(
                            "VERIFY OTP",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontFamily: "Poppins",
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            "We have sent a verification code to\n${controller.maskedEmail}",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              height: 1.5,
                              fontFamily: "Poppins",
                            ),
                          ),

                          const SizedBox(height: 30),

                          _buildOtpFields(context),

                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child: controller.otpError.value == null
                                ? const SizedBox(height: 24)
                                : Padding(
                                    padding: const EdgeInsets.only(
                                      top: 12,
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      controller.otpError.value!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                          ),

                          ButtonWidget(
                            buttonText: controller.isLoading.value
                                ? "Verifying..."
                                : "Verify",
                            backgroundColor: primaryColor,
                            color: Colors.white,
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.verifyOtpMethod,
                          ),

                          const SizedBox(height: 18),

                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [

                              Text(
                                "Didn't receive the code?",
                                style: theme.textTheme.bodyMedium,
                              ),

                              TextButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : controller.resendOtp,
                                child: const Text(
                                  "Resend",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
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
              );
            },
          ),
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
          (availableWidth - spacing * (ForgotPasswordController.otpLength - 1)) /
              ForgotPasswordController.otpLength;

      final fieldWidth = calculatedWidth.clamp(38.0, 64.0);

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          ForgotPasswordController.otpLength,
          (index) {
            return Padding(
              padding: EdgeInsets.only(
                right: index ==
                        ForgotPasswordController.otpLength - 1
                    ? 0
                    : spacing,
              ),
              child: SizedBox(
                width: fieldWidth,
                child: OtpInputField(
                  controller: controller.otpControllers[index],
                  focusNode: controller.otpFocusNodes[index],
                  autofocus: index == 0,
                  isLastField:
                      index == ForgotPasswordController.otpLength - 1,

                  onChanged: (value) {
                    controller.handleOtpChanged(index, value);
                  },

                  onBackspace: () {
                    controller.handleBackspace(index);
                  },

                  onSubmitted: () {
                    if (index ==
                        ForgotPasswordController.otpLength - 1) {
                      controller.verifyOtp();
                    } else {
                      controller.otpFocusNodes[index + 1]
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


