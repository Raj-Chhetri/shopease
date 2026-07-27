import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopease/views/login_view.dart';
import 'package:shopease/widgets/passwordfield_widget.dart';

class ChangepasswordScreen extends StatelessWidget {
  const ChangepasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                // ==================== HEADER ====================
                Row(
                  children: [
                    // Clean Circle Back Button (Same as Settings)
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? const Color(
                                  0xFF3A3A3C,
                                ) // Dark gray like Settings
                              : const Color(0xFFE5E5EA), // Light gray
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Center(
                        child: Text(
                          "CHANGE PASSWORD",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: null, // Follows theme (white in dark mode)
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 48),
                  ],
                ),

                const SizedBox(height: 40),

                PasswordFieldWidget(
                  text: 'New Password',
                  hintText: 'Enter new Password',
                ),
                const SizedBox(height: 20),

                PasswordFieldWidget(
                  text: "Confirm Password ",
                  hintText: "Re-enter new Password",
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6D28FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Get.snackbar(
                        "Success",
                        "Password changed successfully",
                        duration: const Duration(seconds: 2),
                      );

                      Future.delayed(const Duration(seconds: 2), () {
                        Get.offAll(() => const LoginView());
                      });
                    },
                    child: const Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}