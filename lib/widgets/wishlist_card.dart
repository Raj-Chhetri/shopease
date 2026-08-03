import 'package:flutter/material.dart';

class WishlistCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double currentPrice;
  final double? oldPrice;
  final bool isRemoving;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  const WishlistCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.currentPrice,
    required this.onFavoriteTap,
    required this.onTap,
    this.oldPrice,
    this.isRemoving = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          // mainAxisSize.min + a square AspectRatio image (instead of
          // Expanded(flex: 2)) means this card sizes itself to its content
          // rather than fighting the parent's fixed cell height — this is
          // what was causing the bottom RenderFlex overflow.
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _WishlistImage(imageUrl: imageUrl),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Material(
                        color: theme.colorScheme.surface.withValues(
                          alpha: 0.95,
                        ),
                        shape: const CircleBorder(),
                        elevation: 2,
                        child: IconButton(
                          onPressed: isRemoving ? null : onFavoriteTap,
                          tooltip: 'Remove from wishlist',
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          iconSize: 18,
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          icon: isRemoving
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                  size: 18,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        // Both prices are now Flexible + ellipsis, so a
                        // long price string truncates instead of causing
                        // a horizontal RenderFlex overflow.
                        Flexible(
                          child: Text(
                            'Rs. ${_formatPrice(currentPrice)}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        if (oldPrice != null && oldPrice! > currentPrice) ...[
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'Rs. ${_formatPrice(oldPrice!)}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
  }
}

class _WishlistImage extends StatelessWidget {
  final String imageUrl;

  const _WishlistImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (imageUrl.trim().isEmpty) {
      return _buildFallback(theme);
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return ColoredBox(
          color: theme.colorScheme.surfaceContainerHighest,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
      errorBuilder: (_, _, _) => _buildFallback(theme),
    );
  }

  Widget _buildFallback(ThemeData theme) {
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 40,
          color: Colors.grey,
        ),
      ),
    );
  }
}
