import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/bindings/home_binding.dart';
import 'package:shopease/bindings/initial_binding.dart';
import 'package:shopease/controller/app_controller.dart';
import 'package:shopease/routes/app_routes.dart';
import 'package:shopease/theme/app_theme.dart';
import 'package:shopease/translation/app_translation.dart';
import 'package:shopease/views/AfterSplashScreen.dart';
import 'package:shopease/views/Splashscreen.dart';
import 'package:shopease/views/login_view.dart';
import 'package:shopease/views/main_navigation_screen.dart';
import 'package:shopease/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put<AppController>(
    AppController(),
    permanent: true,
  );

  runApp(const ShopEaseApp());
}

class ShopEaseApp extends StatelessWidget {
  const ShopEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.find<AppController>();

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShopEase',

        translations: AppTranslations(),

        locale: controller.language.value == 'Nepali'
            ? const Locale('ne', 'NP')
            : const Locale('en', 'US'),

        fallbackLocale: const Locale('en', 'US'),

        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: controller.isDark.value
            ? ThemeMode.dark
            : ThemeMode.light,

        // Global dependencies, including payment-related dependencies.
        initialBinding: InitialBinding(),

        initialRoute: AppRoutes.splash,

        getPages: [
          GetPage(
            name: AppRoutes.splash,
            page: () => const Splashscreen(),
          ),

          GetPage(
            name: AppRoutes.afterSplash,
            page: () => const Aftersplashscreen(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 450),
          ),

          GetPage(
            name: AppRoutes.login,
            page: () => const LoginView(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 400),
          ),

          GetPage(
            name: AppRoutes.register,
            page: () => const RegisterView(),
            transition: Transition.rightToLeftWithFade,
            transitionDuration: const Duration(milliseconds: 400),
          ),

          GetPage(
            name: AppRoutes.mainNavigation,
            page: () => const MainNavigationScreen(),
            binding: HomeBinding(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 350),
          ),
        ],
      ),
    );
  }
}