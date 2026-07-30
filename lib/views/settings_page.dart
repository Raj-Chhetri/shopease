// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopease/controller/app_controller.dart';
// import 'change_password2.dart';
// import 'privacy_policy.dart';
// import 'terms_conditions.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   static const Color primary = Color(0xFF6C3EF4);

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AppController>();

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final screenWidth = constraints.maxWidth;
//         final bool mobile = screenWidth < 600;
//         final bool tablet = screenWidth >= 600 && screenWidth < 900;
//         final bool desktop = screenWidth >= 900;

//         // Full screen width logic
//         double horizontalPadding = mobile ? 16 : 24;
//         if (desktop) horizontalPadding = 40;

//         return Scaffold(
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           body: SafeArea(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(
//                 horizontal: horizontalPadding,
//                 vertical: mobile ? 20 : 32,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // HEADER
//                   Row(
//                     children: [
//                       InkWell(
//                         borderRadius: BorderRadius.circular(50),
//                         onTap: () => Navigator.pop(context),
//                         child: Container(
//                           width: mobile ? 48 : 56,
//                           height: mobile ? 48 : 56,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Theme.of(context).cardColor,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withValues(alpha: .06),
//                                 blurRadius: 16,
//                                 offset: const Offset(0, 6),
//                               ),
//                             ],
//                           ),
//                           child: Icon(Icons.arrow_back, size: mobile ? 24 : 28),
//                         ),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: Text(
//                             "settings".tr,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: mobile ? 30 : 38,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: mobile ? 48 : 56),
//                     ],
//                   ),

//                   SizedBox(height: mobile ? 32 : 48),

//                   // SETTINGS SECTION
//                   Obx(
//                     () => _buildCard(
//                       context,
//                       child: Column(
//                         children: [
//                           _buildSwitchTile(
//                             context: context,
//                             icon: Icons.dark_mode_outlined,
//                             title: "dark".tr,
//                             value: controller.isDark.value,
//                             onChanged: controller.changeTheme,
//                             mobile: mobile,
//                           ),
//                           _divider(),
//                           _buildSwitchTile(
//                             context: context,
//                             icon: Icons.notifications_outlined,
//                             title: "notification".tr,
//                             value: controller.notification.value,
//                             onChanged: controller.changeNotification,
//                             mobile: mobile,
//                           ),
//                           _divider(),
//                           _buildLanguageTile(context, controller, mobile),
//                         ],
//                       ),
//                     ),
//                   ),

//                   SizedBox(height: mobile ? 28 : 36),

//                   // ACCOUNT & LEGAL SECTION
//                   _buildCard(
//                     context,
//                     child: Column(
//                       children: [
//                         _buildNavigationTile(
//                           context: context,
//                           icon: Icons.lock_outline_rounded,
//                           title: "change_password".tr,
//                           page: const ChangepasswordScreen(),
//                           mobile: mobile,
//                         ),
//                         _divider(),
//                         _buildNavigationTile(
//                           context: context,
//                           icon: Icons.privacy_tip_outlined,
//                           title: "privacy".tr,
//                           page: const PrivacyPolicyPage(),
//                           mobile: mobile,
//                         ),
//                         _divider(),
//                         _buildNavigationTile(
//                           context: context,
//                           icon: Icons.description_outlined,
//                           title: "terms".tr,
//                           page: const TermsConditionsPage(),
//                           mobile: mobile,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // CARD
//   Widget _buildCard(BuildContext context, {required Widget child}) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: .06),
//             blurRadius: 22,
//             offset: const Offset(0, 0,
//           ),
//           )
//         ],
//       ),
//       child: child,
//     );
//   }

//   // DIVIDER
//   Widget _divider() {
//     return const Padding(
//       padding: EdgeInsets.only(left: 82),
//       child: Divider(height: 1),
//     );
//   }

//   // SWITCH TILE
//   Widget _buildSwitchTile({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required bool value,
//     required ValueChanged<bool> onChanged,
//     required bool mobile,
//   }) {
//     return SizedBox(
//       height: mobile ? 76 : 84,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: mobile ? 20 : 24),
//         child: Row(
//           children: [
//             Container(
//               width: mobile ? 50 : 58,
//               height: mobile ? 50 : 58,
//               decoration: const BoxDecoration(
//                 color: Color(0xFFF4EEFF),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(icon, color: primary, size: mobile ? 25 : 30),
//             ),
//             SizedBox(width: mobile ? 18 : 22),
//             Expanded(
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: mobile ? 18 : 22,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () => onChanged(!value),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 220),
//                 width: 42,
//                 height: 24,
//                 padding: const EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                   color: value ? primary : const Color(0xFFD8D8D8),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: AnimatedAlign(
//                   duration: const Duration(milliseconds: 220),
//                   alignment: value
//                       ? Alignment.centerRight
//                       : Alignment.centerLeft,
//                   child: Container(
//                     width: 20,
//                     height: 20,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // LANGUAGE TILE
//   Widget _buildLanguageTile(
//     BuildContext context,
//     AppController controller,
//     bool mobile,
//   ) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return SizedBox(
//       height: mobile ? 76 : 84,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: mobile ? 20 : 24),
//         child: Row(
//           children: [
//             Container(
//               width: mobile ? 50 : 58,
//               height: mobile ? 50 : 58,
//               decoration: const BoxDecoration(
//                 color: Color(0xFFF4EEFF),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.language_outlined,
//                 color: primary,
//                 size: mobile ? 25 : 30,
//               ),
//             ),
//             SizedBox(width: mobile ? 18 : 22),
//             Expanded(
//               child: Text(
//                 "language".tr,
//                 style: TextStyle(
//                   fontSize: mobile ? 18 : 22,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             Container(
//               width: mobile ? 130 : 160,
//               height: mobile ? 42 : 48,
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 color: isDark ? Colors.grey.shade800 : Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Obx(
//                 () => DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     value: controller.language.value,
//                     isExpanded: true,
//                     icon: const Icon(Icons.keyboard_arrow_down),
//                     dropdownColor: isDark ? Colors.grey.shade900 : Colors.white,
//                     items: const [
//                       DropdownMenuItem(
//                         value: "English",
//                         child: Text("English"),
//                       ),
//                       DropdownMenuItem(value: "Nepali", child: Text("Nepali")),
//                     ],
//                     onChanged: (value) {
//                       if (value != null) controller.changeLanguage(value);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // NAVIGATION TILE
//   Widget _buildNavigationTile({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required Widget page,
//     required bool mobile,
//   }) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(20),
//       onTap: () =>
//           Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
//       child: SizedBox(
//         height: mobile ? 76 : 84,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: mobile ? 20 : 24),
//           child: Row(
//             children: [
//               Container(
//                 width: mobile ? 50 : 58,
//                 height: mobile ? 50 : 58,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFF4EEFF),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(icon, color: primary, size: mobile ? 25 : 30),
//               ),
//               SizedBox(width: mobile ? 18 : 22),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: mobile ? 18 : 22,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               Icon(
//                 Icons.chevron_right_rounded,
//                 size: mobile ? 28 : 34,
//                 color: Colors.grey.shade500,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/app_controller.dart';
import 'package:shopease/views/change_password2.dart';
import 'package:shopease/views/privacy_policy.dart';
import 'package:shopease/views/terms_conditions.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const Color primary = Color(0xFF6D28FF);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'settings'.tr,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final horizontalPadding = switch (width) {
              < 380 => 14.0,
              < 700 => 18.0,
              < 1000 => 32.0,
              _ => 48.0,
            };

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                20,
                horizontalPadding,
                40,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 760,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Preferences',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Personalise how ShopEase looks and behaves.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Obx(
                        () => _SettingsCard(
                          children: [
                            _SettingsSwitchTile(
                              icon: Icons.dark_mode_outlined,
                              title: 'dark'.tr,
                              subtitle: 'Use the dark application theme',
                              value: controller.isDark.value,
                              onChanged: controller.changeTheme,
                            ),
                            const _SettingsDivider(),
                            _SettingsSwitchTile(
                              icon: Icons.notifications_outlined,
                              title: 'notification'.tr,
                              subtitle:
                                  'Receive order and account notifications',
                              value: controller.notification.value,
                              onChanged:
                                  controller.changeNotification,
                            ),
                            const _SettingsDivider(),
                            _LanguageTile(
                              controller: controller,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Account and legal',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Manage account security and application policies.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _SettingsCard(
                        children: [
                          _SettingsNavigationTile(
                            icon: Icons.lock_outline_rounded,
                            title: 'change_password'.tr,
                            subtitle: 'Update your account password',
                            onTap: () {
                              Get.to(
                                () => const ChangepasswordScreen(),
                                transition: Transition.rightToLeft,
                              );
                            },
                          ),
                          const _SettingsDivider(),
                          _SettingsNavigationTile(
                            icon: Icons.privacy_tip_outlined,
                            title: 'privacy'.tr,
                            subtitle:
                                'Learn how your information is handled',
                            onTap: () {
                              Get.to(
                                () => const PrivacyPolicyPage(),
                                transition: Transition.rightToLeft,
                              );
                            },
                          ),
                          const _SettingsDivider(),
                          _SettingsNavigationTile(
                            icon: Icons.description_outlined,
                            title: 'terms'.tr,
                            subtitle:
                                'Read the ShopEase terms of use',
                            onTap: () {
                              Get.to(
                                () => const TermsConditionsPage(),
                                transition: Transition.rightToLeft,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
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

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 80,
      endIndent: 18,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}

class _SettingsIcon extends StatelessWidget {
  final IconData icon;

  const _SettingsIcon({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF3B2A66)
            : const Color(0xFFF0E9FF),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: const Color(0xFF6D28FF),
        size: 25,
      ),
    );
  }
}

class _SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        child: Row(
          children: [
            _SettingsIcon(icon: icon),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Switch.adaptive(
              value: value,
              activeTrackColor:
                  const Color(0xFF6D28FF),
              activeThumbColor: Colors.white,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final AppController controller;

  const _LanguageTile({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      child: Row(
        children: [
          const _SettingsIcon(
            icon: Icons.language_outlined,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'language'.tr,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Choose the application language'.tr,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 125,
            child: Obx(
              () => DropdownButtonFormField<String>(
                initialValue: controller.language.value,
                isExpanded: true,
                dropdownColor: theme.colorScheme.surface,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      theme.colorScheme.surfaceContainerHighest,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outlineVariant,
                    ),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'English',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'Nepali',
                    child: Text('Nepali'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    controller.changeLanguage(value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsNavigationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsNavigationTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        child: Row(
          children: [
            _SettingsIcon(icon: icon),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}