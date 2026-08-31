


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/Auth_controller.dart';
import 'package:shopease/widgets/button_widget.dart';
import 'package:shopease/widgets/passwordfield_widget.dart';

class ChangepasswordScreen extends StatelessWidget {
  ChangepasswordScreen({
    super.key,
    required this.email,
  });

  final String email;

  final ForgotPasswordController controller =
      Get.find<ForgotPasswordController>();

  static const Color primaryColor = Color(0xFF6D28FF);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: controller.isLoading.value
                ? null
                : () => Get.back(),
          ),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Form(
              key: controller.changepasswordformKey,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [

                  const SizedBox(height: 20),

                  const Text(
                    "CHANGE PASSWORD",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                  ),

                  const SizedBox(height: 40),

                  PasswordFieldWidget(
                    text: "New Password",
                    hintText: "Enter new password",
                    controller:
                        controller.changepasswordcontroller,
                    focusNode:
                        controller.changepasswordfocus,
                    validator:
                        controller.validatePassword,
                    textInputAction:
                        TextInputAction.next,
                    onFieldSubmitted: (_) {
                      controller
                          .confirmpasswordfocus
                          .requestFocus();
                    },
                  ),

                  const SizedBox(height: 25),

                  PasswordFieldWidget(
                    text: "Confirm Password",
                    hintText:
                        "Re-enter new password",
                    controller:
                        controller.confirmpasswordcontroller,
                    focusNode:
                        controller.confirmpasswordfocus,
                    validator:
                        controller
                            .validateconfirmPassword,
                    textInputAction:
                        TextInputAction.done,
                    onFieldSubmitted: (_) {
                      controller.changePasswordMethod(
                        email: email,
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Use at least 8 characters with uppercase, lowercase and a number.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 35),

                  ButtonWidget(
                    buttonText:
                        controller.isLoading.value
                            ? "Changing Password..."
                            : "Change Password",

                    backgroundColor: primaryColor,

                    color: Colors.white,

                    onPressed:
                        controller.isLoading.value
                            ? null
                            : () => controller
                                .changePasswordMethod(
                                  email: email,
                                ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
