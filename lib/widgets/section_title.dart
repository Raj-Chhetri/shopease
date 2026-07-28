import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const SectionTitle({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleSize = MediaQuery.sizeOf(context).width < 360 ? 27.0 : 32.0;

    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: titleSize,
              height: 1.15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          icon,
          color: iconColor,
          size: titleSize,
        ),
      ],
    );
  }
}
