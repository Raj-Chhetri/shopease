import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/views/edit_profile_screen.dart';
import 'package:shopease/views/order_history_view.dart';
import 'package:shopease/views/settings_page.dart';
import 'package:shopease/views/wishlist_view.dart';

const Color kPrimaryPurple = Color(0xFF6D28FF);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String _userName = 'John Doe';
  static const String _userEmail = 'john@gmail.com';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Profile'.tr,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth < 700 ? 18.0 : 32.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                18,
                horizontalPadding,
                116,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ProfileHeader(
                        userName: _userName,
                        userEmail: _userEmail,
                      ),
                      const SizedBox(height: 28),
                      _ProfileMenuTile(
                        icon: Icons.edit_rounded,
                        label: 'Edit Profile'.tr,
                        onTap: () {
                          Get.to(() => const EditProfileScreen());
                        },
                      ),
                      const SizedBox(height: 12),
                      _ProfileMenuTile(
                        icon: Icons.shopping_bag_rounded,
                        label: 'My Orders'.tr,
                        onTap: () {
                          Get.to(() => const OrderHistoryView());
                        },
                      ),
                      const SizedBox(height: 12),
                      _ProfileMenuTile(
                        icon: Icons.favorite_rounded,
                        label: 'Wishlist'.tr,
                        onTap: () {
                          Get.to(
                            () => const Wishlistview(
                              showBackButton: true,
                            ),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 250),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _ProfileMenuTile(
                        icon: Icons.settings_rounded,
                        label: 'Settings'.tr,
                        onTap: () {
                          Get.to(() => const SettingsPage());
                        },
                      ),
                      const SizedBox(height: 12),
                      _ProfileMenuTile(
                        icon: Icons.logout_rounded,
                        label: 'Logout'.tr,
                        iconColor: theme.colorScheme.error,
                        labelColor: theme.colorScheme.error,
                        onTap: () => _confirmLogout(context),
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

  void _confirmLogout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final theme = Theme.of(dialogContext);

        return AlertDialog(
          backgroundColor: theme.colorScheme.surface,
          title: Text(
            'Logout'.tr,
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
          content: Text(
            'Are you sure you want to logout?'.tr,
            style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Cancel'.tr),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                // TODO: Call POST /api/logout and return to login screen.
              },
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: Colors.white,
              ),
              child: Text('Logout'.tr),
            ),
          ],
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String userName;
  final String userEmail;

  const _ProfileHeader({
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Container(
            width: 142,
            height: 142,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark
                  ? kPrimaryPurple.withValues(alpha: 0.18)
                  : const Color(0xFFF0E9FF),
              border: Border.all(color: kPrimaryPurple, width: 5),
            ),
            child: Icon(
              Icons.person_rounded,
              size: 88,
              color: isDark ? Colors.white : kPrimaryPurple,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            userName,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            userEmail,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  const _ProfileMenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final resolvedIconColor = iconColor ?? kPrimaryPurple;

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor != null
                      ? resolvedIconColor.withValues(alpha: 0.12)
                      : (isDark
                          ? kPrimaryPurple.withValues(alpha: 0.22)
                          : const Color(0xFFF0E9FF)),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? (isDark ? Colors.white : kPrimaryPurple),
                  size: 25,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: labelColor ?? theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurfaceVariant,
                size: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
