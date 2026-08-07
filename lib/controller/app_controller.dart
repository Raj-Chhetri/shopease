// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AppController extends GetxController {
//   final RxBool isDark = false.obs;
//   final RxBool notification = true.obs;
//   final RxString language = 'English'.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     isDark.value = Get.isDarkMode;
//   }

//   void changeTheme(bool value) {
//     isDark.value = value;
//     Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
//   }

//   void toggleTheme() {
//     changeTheme(!isDark.value);
//   }

//   void changeNotification(bool value) {
//     notification.value = value;
//   }

//   void changeLanguage(String value) {
//     language.value = value;

//     Get.updateLocale(
//       value == 'Nepali'
//           ? const Locale('ne', 'NP')
//           : const Locale('en', 'US'),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  static const _languageKey = 'app_language';
  static const _darkModeKey = 'app_dark_mode';

  final RxBool isDark = false.obs;
  final RxBool notification = true.obs;
  final RxString language = 'English'.obs;

  Future<void> initialize() async {
    final preferences = await SharedPreferences.getInstance();
    language.value = preferences.getString(_languageKey) ?? 'English';
    isDark.value = preferences.getBool(_darkModeKey) ?? Get.isDarkMode;
  }

  void changeTheme(bool value) {
    isDark.value = value;
    SharedPreferences.getInstance().then(
      (preferences) => preferences.setBool(_darkModeKey, value),
    );

    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    changeTheme(!isDark.value);
  }

  void changeNotification(bool value) {
    notification.value = value;
  }

  void changeLanguage(String value) {
    language.value = value;
    SharedPreferences.getInstance().then(
      (preferences) => preferences.setString(_languageKey, value),
    );

    final locale = value == 'Nepali'
        ? const Locale('ne', 'NP')
        : const Locale('en', 'US');

    Get.updateLocale(locale);
  }
}
