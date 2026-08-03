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

import '../controller/Auth_controller.dart';
import '../widgets/button_widget.dart';
import '../widgets/emailfield.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  static const Color primaryColor = Color(0xFF6D28FF);

  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
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
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  "FORGOT PASSWORD",
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),

                              const SizedBox(height: 40),

                              EmailField(
                                text: "Email",
                                hintText: "Enter your email",
                                icon: Icons.mail,
                                controller:
                                    controller.emailController,
                                focusNode:
                                    controller.emailFocus,
                                keyboardType:
                                    TextInputType.emailAddress,
                                textInputAction:
                                    TextInputAction.done,
                                autofillHints: const [
                                  AutofillHints.email,
                                ],
                                validator:
                                    controller.validateEmail,
                                onFieldSubmitted: (_) {
                                  controller.sendOtp();
                                },
                              ),

                              const SizedBox(height: 28),

                              SizedBox(
                                width: double.infinity,
                                child: Obx(
                                  () => ButtonWidget(
                                    buttonText:
                                        controller
                                                .isLoading
                                                .value
                                            ? "Sending..."
                                            : "Next",
                                    backgroundColor:
                                        primaryColor,
                                    color: Colors.white,
                                  
                                    onPressed:
                                       controller
                                               .isLoading
                                                .value
                                            ? null
                                            : controller
                                                .sendOtp,
                                  ),
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
              child: Obx(
                () => IconButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : Get.back,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
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