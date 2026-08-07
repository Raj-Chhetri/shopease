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

    return Card(
      elevation: 1.8,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (image != null && image!.isNotEmpty)
                    Image.network(
                      image!,
                      fit: BoxFit.cover,
                      cacheWidth: 600,
                      filterQuality: FilterQuality.medium,
                      errorBuilder: (_, _, _) => _placeholder(theme),
                    )
                  else
                    _placeholder(theme),

                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.white.withValues(alpha: .95),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: onFavoritePressed,
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Icon(
                            isFavorite
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            color: Colors.redAccent,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 142,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 6),

                    if (rating != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 15,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            rating!.toStringAsFixed(1),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            "($ratingCount)",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                    const Spacer(),

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
    );
  }

  Widget _placeholder(ThemeData theme) {
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.image_not_supported_outlined,
        color: theme.colorScheme.onSurfaceVariant,
        size: 42,
      ),
    );
  }
}
