import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final int productId;
  final String? image;
  final String productTitle;
  final String newPrice;
  final String? oldPrice;

  final double? rating;
  final int? ratingCount;

  final bool isFavorite;

  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const ProductCard({
    super.key,
    required this.productId,
    required this.image,
    required this.productTitle,
    required this.newPrice,
    this.oldPrice,
    this.rating,
    this.ratingCount,
    this.isFavorite = false,
    this.onTap,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Column(
            children: [
              /// IMAGE
              AspectRatio(
                aspectRatio: 1.1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (image != null && image!.isNotEmpty)
                      Image.network(
                        image!,
                        fit: BoxFit.cover,

                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;

                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },

                        errorBuilder: (_, _, _) {
                          return _placeholder(theme);
                        },
                      )
                    else
                      _placeholder(theme),

                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: Colors.white.withValues(alpha: .9),
                        shape: const CircleBorder(),
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          iconSize: 20,
                          onPressed: onFavoritePressed,
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
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

              /// DETAILS
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// PRODUCT NAME
                      Text(
                        productTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// RATING
                      if (rating != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "${rating!.toStringAsFixed(1)} (${ratingCount ?? 0})",
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),

                      const Spacer(),

                      /// PRICE
                      Text(
                        "Rs. $newPrice",
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: const Color(0xff169B00),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      if (oldPrice != null && oldPrice!.isNotEmpty)
                        Text(
                          "Rs. $oldPrice",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholder(ThemeData theme) {
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.image_not_supported_outlined,
        color: theme.colorScheme.onSurfaceVariant,
        size: 45,
      ),
    );
  }
}
