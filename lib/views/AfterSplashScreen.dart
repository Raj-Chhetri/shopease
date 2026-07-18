// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:shopease/views/login_view.dart';
// import 'package:shopease/views/register_view.dart';
// import 'package:shopease/widgets/button_widget.dart';

// class Aftersplashscreen extends StatelessWidget {
//   const Aftersplashscreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      body: Container(
//         color: Color(0xFF6D28FF),
//         child: Padding(
//           padding: const EdgeInsets.all(22.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset("assets/images/shopeasebag.png",height: 60,width: 64,),
//                 Text("ShopEase",style: TextStyle(
//                   fontSize: 50,
//                   color: Colors.white,
//                   fontFamily: 'Poppins'
//                   ),
//                   ),
//                   Text("Shop Smarter,Live Better...",style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'Poppins'),),
//                   Gap(15),
//                   Image.asset("assets/images/Splashimage.png",height: 150,),
//                   Gap(20),
//                   ButtonWidget(buttonText: "Log In",
//                                 backgroundColor: Color.fromARGB(255, 253, 252, 253),
//                                 onPressed: (){Get.to(()=>LoginView(),
//                                 transition: Transition.rightToLeftWithFade);
//                   },
//                    color: Color(0xFF6D28FF),
//                    ),
//                   Gap(20),
//                   ButtonWidget(buttonText: "Sign Up", backgroundColor: const Color.fromARGB(255, 254, 255, 253), onPressed: (){
//                     Get.to(()=>RegisterView(),
//                     transition: Transition.rightToLeftWithFade);
//                   }, color: Color(0xFF6D28FF),),
//               ],
//             ),
//           ),
//         ),
//       )
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/views/login_view.dart';
import 'package:shopease/views/register_view.dart';
import 'package:shopease/widgets/button_widget.dart';

class Aftersplashscreen extends StatefulWidget {
  const Aftersplashscreen({super.key});

  @override
  State<Aftersplashscreen> createState() => _AftersplashscreenState();
}

class _AftersplashscreenState extends State<Aftersplashscreen>
    with SingleTickerProviderStateMixin {
  static const Color _primaryColor = Color(0xFF6D28FF);

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _imageScaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _imageScaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _animationController.forward();
  }

  void _openLogin() {
    Get.to(
      () => const LoginView(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 400),
    );
  }

  void _openRegister() {
    Get.to(
      () => const RegisterView(),
      transition: Transition.rightToLeftWithFade,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            final double screenHeight = constraints.maxHeight;

            final bool isCompactHeight = screenHeight < 650;
            final bool isTablet = screenWidth >= 600;

            final double horizontalPadding =
                isTablet ? 40 : screenWidth < 360 ? 16 : 22;

            final double logoSize =
                (screenWidth * 0.16).clamp(54.0, isTablet ? 84.0 : 68.0);

            final double titleSize =
                (screenWidth * 0.12).clamp(38.0, isTablet ? 60.0 : 50.0);

            final double illustrationHeight =
                isCompactHeight
                    ? 120
                    : (screenHeight * 0.22).clamp(
                      140.0,
                      isTablet ? 240.0 : 190.0,
                    );

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isCompactHeight ? 20 : 28,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      constraints.maxHeight -
                      (isCompactHeight ? 40 : 56),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 430,
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/shopeasebag.png',
                              width: logoSize,
                              height: logoSize,
                              fit: BoxFit.contain,
                              errorBuilder: (
                                BuildContext context,
                                Object error,
                                StackTrace? stackTrace,
                              ) {
                                return Icon(
                                  Icons.shopping_bag_rounded,
                                  size: logoSize,
                                  color: Colors.white,
                                );
                              },
                            ),
                            const SizedBox(height: 8),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'ShopEase',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: titleSize,
                                  height: 1,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Shop Smarter, Live Better...',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isTablet ? 16 : 14,
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(
                                  alpha: 0.9,
                                ),
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              height: isCompactHeight ? 14 : 22,
                            ),
                            ScaleTransition(
                              scale: _imageScaleAnimation,
                              child: Image.asset(
                                'assets/images/Splashimage.png',
                                height: illustrationHeight,
                                width: double.infinity,
                                fit: BoxFit.contain,
                                errorBuilder: (
                                  BuildContext context,
                                  Object error,
                                  StackTrace? stackTrace,
                                ) {
                                  return SizedBox(
                                    height: illustrationHeight,
                                    child: const Icon(
                                      Icons.shopping_cart_rounded,
                                      size: 110,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: isCompactHeight ? 20 : 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ButtonWidget(
                                buttonText: 'Log In',
                                backgroundColor: Colors.white,
                                color: _primaryColor,
                                onPressed: _openLogin,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ButtonWidget(
                                buttonText: 'Sign Up',
                                backgroundColor: Colors.white,
                                color: _primaryColor,
                                onPressed: _openRegister,
                              ),
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
      ),
    );
  }
}