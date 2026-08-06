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

class AppController extends GetxController {
  final RxBool isDark = false.obs;
  final RxBool notification = true.obs;
  final RxString language = 'English'.obs;

  void changeTheme(bool value) {
    isDark.value = value;

    Get.changeThemeMode(
      value ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void toggleTheme() {
    changeTheme(!isDark.value);
  }

  void changeNotification(bool value) {
    notification.value = value;
  }

  void changeLanguage(String value) {
    language.value = value;

    final locale = value == 'Nepali'
        ? const Locale('ne', 'NP')
        : const Locale('en', 'US');

    Get.updateLocale(locale);
  }
}
