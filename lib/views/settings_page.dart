import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopease/controller/app_controller.dart';
import 'package:shopease/views/change_password2.dart';
import 'package:shopease/views/notification_page.dart';
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
        elevation: 0,
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),

        title: Text(
          "settings".tr,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final padding = width > 800 ? 40.0 : 16.0;

            return SingleChildScrollView(
              padding: EdgeInsets.all(padding),

              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 750),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "preferences".tr,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Obx(
                        () => _SettingsCard(
                          children: [
                            _SettingsSwitchTile(
                              icon: Icons.dark_mode_outlined,
                              title: "dark_mode".tr,
                              subtitle: "enable_dark_mode".tr,
                              value: controller.isDark.value,
                              onChanged: controller.changeTheme,
                            ),

                            const _SettingsDivider(),

                            _SettingsNavigationTile(
                              icon: Icons.notifications_outlined,
                              title: "notifications".tr,
                              subtitle: "view_notifications".tr,
                              onTap: () {
                                Get.to(
                                  () => NotificationPage(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                            ),

                            const _SettingsDivider(),

                            _LanguageTile(controller: controller),
                          ],
                        ),
                      ),

                      const SizedBox(height: 35),

                      Text(
                        "account_legal".tr,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 18),
                      _SettingsCard(
                        children: [
                          _SettingsNavigationTile(
                            icon: Icons.lock_outline,
                            title: "change_password".tr,
                            subtitle: "update_your_password".tr,
                            onTap: () {
                              Get.to(() => ChangePassword2());
                            },
                          ),

                          const _SettingsDivider(),

                          _SettingsNavigationTile(
                            icon: Icons.privacy_tip_outlined,
                            title: "privacy".tr,
                            subtitle: "privacy_subtitle".tr,
                            onTap: () {
                              Get.to(() => const PrivacyPolicyPage());
                            },
                          ),

                          const _SettingsDivider(),

                          _SettingsNavigationTile(
                            icon: Icons.description_outlined,
                            title: "terms".tr,
                            subtitle: "terms_subtitle".tr,
                            onTap: () {
                              Get.to(() => const TermsConditionsPage());
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

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
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
    return const Padding(
      padding: EdgeInsets.only(left: 82),
      child: Divider(height: 1),
    );
  }
}

class _SettingsIcon extends StatelessWidget {
  final IconData icon;

  const _SettingsIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF312E81) : const Color(0xFFF3EDFF),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: SettingsPage.primary, size: 26),
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
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            _SettingsIcon(icon: icon),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            Switch.adaptive(
              value: value,
              activeColor: SettingsPage.primary,
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

  const _LanguageTile({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          const _SettingsIcon(icon: Icons.language_outlined),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "language".tr,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "choose_language".tr,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          SizedBox(
            width: 150,
            child: Obx(
              () => DropdownButtonFormField<String>(
                value: controller.language.value,
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: [
                  DropdownMenuItem(value: "English", child: Text("english".tr)),
                  DropdownMenuItem(value: "Nepali", child: Text("nepali".tr)),
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
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            _SettingsIcon(icon: icon),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right_rounded,
              size: 30,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}
