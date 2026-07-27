import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/change_password_model.dart';
import 'package:shopease/models/verify_otp_model.dart';
import 'package:shopease/views/Verifyotp.dart';
import 'package:shopease/views/changepassword_screen.dart';
import 'package:shopease/views/login_view.dart';

import '../models/forgotpassword_model.dart';
import '../services/auth_service.dart';

class ForgotPasswordController extends GetxController { 
  final formKey = GlobalKey<FormState>();
  
  final AuthService _authService = AuthService();

  final forgotpassword=ForgotPasswordModel(success: false, message: null, data: null).obs;

  final emailController = TextEditingController();

  final emailFocus = FocusNode();

  final isLoading = false.obs;

  //Variables for change password

  final changepasswordcontroller=TextEditingController();

  final confirmpasswordcontroller=TextEditingController();

  final changepasswordfocus=FocusNode();

  final confirmpasswordfocus=FocusNode();

  final changePassword=ChangePasswordModel(success: false, message: null, data: null).obs;

  // ---------------- VERIFY OTP ----------------

static const int otpLength = 6;

final verifyOtp = VerifyOtp(
  success: false,
  message: null,
  data: null,
).obs;

final otpControllers = List.generate(
  otpLength,
  (_) => TextEditingController(),
);

final otpFocusNodes = List.generate(
  otpLength,
  (_) => FocusNode(),
);

final otpError = RxnString();

//Getters
String get otp =>
    otpControllers.map((e) => e.text).join();

bool get isOtpComplete =>
    otp.length == otpLength &&
    otpControllers.every((e) => e.text.length == 1);

String get maskedEmail {
  final email = emailController.text.trim();

  final separator = email.lastIndexOf("@");

  if (separator <= 0 ||
      separator == email.length - 1) {
    return email;
  }

  final username = email.substring(0, separator);

  final domain = email.substring(separator + 1);

  if (username.length <= 2) {
    return "${username[0]}***@$domain";
  }

  return "${username.substring(0, 2)}***@$domain";
}
void handleOtpChanged(
  int index,
  String value,
) {
  otpError.value = null;

  if (value.isNotEmpty && index < otpLength - 1) {
    otpFocusNodes[index + 1].requestFocus();
  }
}

void handleBackspace(int index) {
  if (otpControllers[index].text.isNotEmpty) {
    otpControllers[index].clear();
    return;
  }

  if (index > 0) {
    otpControllers[index - 1].clear();
    otpFocusNodes[index - 1].requestFocus();
  }
}
///


 // final AuthService _service = AuthService();
//Email validation 
  String? validateEmail(String? value) {
    final email = value?.trim() ?? "";

    if (email.isEmpty) {
      return "Please enter your email address";
    }

    if (!GetUtils.isEmail(email)) {
      return "Please enter a valid email address";
    }

    return null;
  }

  //Password validation

  String? validatePassword(String? value){
    final password=value ?? "";

    if (password.isEmpty){
      return "Please enter new  password";
    }

    if(password.length<8){
      return "Password must contain at least 8 characters";
    }
      if (!RegExp(r'[A-Z]').hasMatch(password)) {
    return "Include at least one uppercase letter";
  }

  if (!RegExp(r'[a-z]').hasMatch(password)) {
    return "Include at least one lowercase letter";
  }

  if (!RegExp(r'[0-9]').hasMatch(password)) {
    return "Include at least one number";
  }

  return null;

  }

  String? validateconfirmPassword(String? value){
    if(value==null || value.isEmpty){
      return "Please enter the password";
    }
    if (value != confirmpasswordcontroller.text){
      return "Passwords do not match";
    }

    return null;

  }
  ///METHODS
  
  Future<void> verifyOtpMethod() async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (!isOtpComplete) {
    otpError.value = "Please enter the complete OTP.";
    return;
  }

  try {
    isLoading(true);

    final response = await AuthService.verifyOtp(
      email: emailController.text.trim(),
      otp: otp,
    );
    

    verifyOtp.value = response;

    if (response.success == true) {
      Get.off(
        () => ChangepasswordScreen(
          email: emailController.text.trim(),
        ),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 350),
      );
    } else {
      otpError.value =
          response.message ?? "Invalid OTP";
    }
  } finally {
    isLoading(false);
  }
}

 Future<void> sendOtp() async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (!(formKey.currentState?.validate() ?? false)) {
    return;
  }

  try {
    isLoading(true);

    final response = await AuthService.forgotpassword(
      emailController.text.trim(),
    );

    forgotpassword.value = response;

    if (response.success == true) {
      Get.to(
        () => Verifyotp(
          email: emailController.text.trim(),
        ),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 350),
      );
    } else {
      Get.snackbar(
        "Error",
        response.message ?? "Failed to send OTP",
      );
    }
  } finally {
    isLoading(false);
  }
}
Future<void> resendOtp() async {
  try {
    isLoading(true);

    final response = await _authService.resendOtp(
      emailController.text.trim(),
    );

    if (response.success == true) {
      // Clear all OTP fields
      for (final controller in otpControllers) {
        controller.clear();
      }

      // Focus on the first field
      otpFocusNodes.first.requestFocus();

      Get.snackbar(
        "Success",
        "OTP sent successfully",
      );
    } else {
      Get.snackbar(
        "Error",
        response.message ?? "Unable to resend OTP",
      );
    }
  } finally {
    isLoading(false);
  }
}



Future forgotPassword() async{
  try{
    isLoading(true);
    var response=await AuthService.forgotpassword(emailController.text);

  }
 
  finally{
    isLoading(false);

  }
}
 Future<void> changePasswordMethod({
    required String email,
   }) async {
     FocusManager.instance.primaryFocus?.unfocus();

    if (!(formKey.currentState?.validate() ?? false)) {
    return;
  }


    try {
     isLoading(true);

     final response=await _authService.changepassword(
      email: email,
       changepassword: changepasswordcontroller.text.trim(),
        confirmchangepassword: confirmpasswordcontroller.text.trim()
        );
        changePassword.value=response;

        if(response.success==true){
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

      Future.delayed(
        const Duration(seconds:2),
      (){
        Get.offAll(()=>LoginView());
      }
      );
      }

        else{
           Get.snackbar(
        'Unable to change password',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
        }

     
    } finally {
      isLoading(false);
    }
  }
 @override
void onClose() {
  emailController.dispose();
  emailFocus.dispose();
  changepasswordcontroller.dispose();
  confirmpasswordcontroller.dispose();
  changepasswordfocus.dispose();
  confirmpasswordfocus.dispose();

  for (final controller in otpControllers) {
    controller.dispose();
  }

  for (final node in otpFocusNodes) {
    node.dispose();
  }

  super.onClose();
}
}