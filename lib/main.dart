import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/bindings/initial_binding.dart';
import 'package:shopease/controller/app_controller.dart';
import 'package:shopease/translation/app_translation.dart';
import 'package:shopease/theme/app_theme.dart';
import 'package:shopease/views/Splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(
    AppController(),
    permanent: true,
  );

  runApp(const ShopEaseApp());
}

class ShopEaseApp extends StatelessWidget {
  const ShopEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();

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

        initialBinding: InitialBinding(),

        home: const Splashscreen(),
      ),
    );
  }
}