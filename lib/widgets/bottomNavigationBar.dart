import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shopease/theme/app_theme.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int cartItemCount;

  const BottomNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.cartItemCount = 0,
  });

  static const List<_NavigationItem> _items = [
    _NavigationItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      label: 'Home',
    ),
    _NavigationItem(
      icon: Icons.grid_view_outlined,
      selectedIcon: Icons.grid_view_rounded,
      label: 'Categories',
    ),
    _NavigationItem(
      icon: Icons.favorite_border_rounded,
      selectedIcon: Icons.favorite_rounded,
      label: 'Wishlist',
    ),
    _NavigationItem(
      icon: Icons.shopping_cart_outlined,
      selectedIcon: Icons.shopping_cart_rounded,
      label: 'Cart',
    ),
    _NavigationItem(
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        bottomInset > 0 ? bottomInset + 6 : 14,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            height: 66,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.94),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.16),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: List.generate(_items.length, (index) {
                final item = _items[index];
                final isSelected = currentIndex == index;

                Widget icon = Icon(
                  isSelected ? item.selectedIcon : item.icon,
                  size: 27,
                );

                if (index == 3 && cartItemCount > 0) {
                  icon = Badge(
                    backgroundColor: Colors.redAccent,
                    textColor: Colors.white,
                    label: Text(
                      cartItemCount > 99 ? '99+' : '$cartItemCount',
                    ),
                    child: icon,
                  );
                }

                return Expanded(
                  child: Semantics(
                    button: true,
                    selected: isSelected,
                    label: item.label,
                    child: InkWell(
                      onTap: () => onTap(index),
                      borderRadius: BorderRadius.circular(24),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.primary.withValues(
                                  alpha: isDark ? 0.24 : 0.16,
                                )
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            child: IconTheme(
                              key: ValueKey('$index-$isSelected-$isDark'),
                              data: IconThemeData(
                                color: isSelected
                                    ? (isDark
                                        ? Colors.white
                                        : AppTheme.primary)
                                    : theme.colorScheme.onSurfaceVariant,
                              ),
                              child: icon,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _NavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}
