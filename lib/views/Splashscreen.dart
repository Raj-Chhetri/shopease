// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:shopease/views/AfterSplashScreen.dart';


// class Splashscreen extends StatefulWidget {
//   const Splashscreen({super.key});

//   @override
//   State<Splashscreen> createState() => _SplashscreenState();
// }

// class _SplashscreenState extends State<Splashscreen> {
//   void authcheck(){
//     Future.delayed(Duration(seconds: 3),(){
//       Get.off(()=>  Aftersplashscreen(),
//       transition: Transition.zoom
//       );
//     });
//   }
//   @override
//   void initState() {
   
//     super.initState();
//     authcheck();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Color(0xFF6D28FF),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset("assets/images/shopeasebag.png",height: 60,width: 64,),
//               Text("ShopEase",style: TextStyle(
//                 fontSize: 50,
//                 color: Colors.white,
//                 fontFamily: 'Poppins'
//                 ),
//                 ),
//                 Text("Shop Smarter,Live Better...",style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: 'Poppins' ),)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/views/AfterSplashScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  Timer? _navigationTimer;

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.75,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Get.off(
        () => const Aftersplashscreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 450),
      );
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6D28FF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final shortestSide = constraints.biggest.shortestSide;
            final isTablet = shortestSide >= 600;

            final logoSize =
                (constraints.maxWidth * 0.16).clamp(56.0, isTablet ? 90.0 : 72.0);

            final titleSize =
                (constraints.maxWidth * 0.12).clamp(36.0, isTablet ? 64.0 : 50.0);

            final subtitleSize =
                (constraints.maxWidth * 0.035).clamp(12.0, 17.0);

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Image.asset(
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
                        ),
                        const SizedBox(height: 10),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'ShopEase',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleSize,
                              height: 1.1,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Shop Smarter, Live Better...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: subtitleSize,
                            color: Colors.white.withValues(alpha: 0.9),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
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
    );
  }
}