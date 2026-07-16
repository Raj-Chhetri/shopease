import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shopease/views/changepassword_screen.dart';
import 'package:shopease/widgets/Screentitle.dart';
import 'package:shopease/widgets/button_widget.dart';
import 'package:shopease/widgets/otpfield.dart';

class Verifyotp extends StatefulWidget {
  final String email;
  const Verifyotp({super.key,
  required this.email});

  @override
  State<Verifyotp> createState() => _VerifyotpState();
}

class _VerifyotpState extends State<Verifyotp> {
  final focus1=FocusNode();
  final focus2=FocusNode();
  final focus3=FocusNode();
  final focus4=FocusNode();

  final controller1=TextEditingController();
  final controller2=TextEditingController();
  final controller3=TextEditingController();
  final controller4=TextEditingController();





   @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();



    focus1.dispose();
    focus2.dispose();
    focus3.dispose();
    focus4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            ScreenTitle(text: "VERIFY OTP"),
            Text("We have sent a verification code at example@gmail.com",
            textAlign: TextAlign.center,),
           Gap(10),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OtpField(
                currentfocus: focus1,
                 nextfocus: focus2,
                  controller: controller1,
                 ),
              OtpField(
                currentfocus: focus2,
                previousfocus: focus1,
                nextfocus: focus3,
                 controller:controller2,
              ),
              OtpField(
                currentfocus: focus3,
                nextfocus: focus4,
                previousfocus: focus2, 
                controller: controller3,),
              OtpField(
                currentfocus: focus4,
                previousfocus: focus3,
                 controller: controller4,)
            ],
           ),
           Gap(20),
           
           ButtonWidget(buttonText: "Verify", backgroundColor:  Color(0xFF6D28FF), onPressed: () {Get.off(()=>ChangepasswordScreen());  }, color: Colors.white,)

          ],
          
          
        ),
      )
    );
  }
}


 