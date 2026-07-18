import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final int productId;
  final String imageUrl;
  final String productTitle;
  final String? oldPrice;
  final String newPrice;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const ProductCard({
    super.key,
    required this.productId,
    required this.imageUrl,
    required this.newPrice,
    required this.productTitle,
    this.oldPrice,
    this.isFavorite = false,
    this.onTap,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(17),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: theme.colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.15,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;

                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      },
                      errorBuilder: (_, __, ___) {
                        return ColoredBox(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 40,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: theme.colorScheme.surface.withValues(
                          alpha: 0.88,
                        ),
                        shape: const CircleBorder(),
                        child: IconButton(
                          onPressed: onFavoritePressed,
                          tooltip: isFavorite
                              ? 'Remove from wishlist'
                              : 'Add to wishlist',
                          visualDensity: VisualDensity.compact,
                          iconSize: 21,
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            child: Icon(
                              isFavorite
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              key: ValueKey(isFavorite),
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rs. $newPrice',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF16A000),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (oldPrice != null && oldPrice!.trim().isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        'Rs. $oldPrice',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.redAccent,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
