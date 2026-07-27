import 'package:flutter/material.dart';

class ForYouPaginationFooter extends StatelessWidget {
  final bool isLoading;
  final bool hasMore;
  final bool hasProducts;

  const ForYouPaginationFooter({
    super.key,
    required this.isLoading,
    required this.hasMore,
    required this.hasProducts,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: SizedBox(
            width: 26,
            height: 26,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
        ),
      );
    }

    if (!hasMore && hasProducts) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            "You've reached the end 🎉",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
