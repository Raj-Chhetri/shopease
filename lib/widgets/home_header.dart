import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopease/theme/app_theme.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final bool isDarkMode;
  final VoidCallback onThemePressed;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.isDarkMode,
    required this.onThemePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Welcome to ',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'ShopEase!',
                    style: GoogleFonts.itim(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Hello, ',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '$userName.',
                    style: GoogleFonts.itim(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                  Text(
                    ' Greetings!',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Material(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
          child: IconButton(
            onPressed: onThemePressed,
            tooltip: isDarkMode ? 'Use light mode' : 'Use dark mode',
            icon: Icon(
              isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: isDarkMode ? Colors.amber : AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
