// import 'package:flutter/material.dart';

// class WishlistCard extends StatelessWidget {
//   final String imageUrl;
//   final String productName;
//   final String currentPrice;
//   final String oldPrice;
//   final bool isFavorite;
//   final VoidCallback onFavoriteTap;

//   const WishlistCard({
//     super.key,
//     required this.imageUrl,
//     required this.productName,
//     required this.currentPrice,
//     required this.oldPrice,
//     required this.isFavorite,
//     required this.onFavoriteTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade300, width: 1.2),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Center(child: Image.network(imageUrl, fit: BoxFit.contain)),
//           ),

//           const SizedBox(height: 8),

//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   productName,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: onFavoriteTap,
//                 child: Icon(
//                   isFavorite ? Icons.favorite : Icons.favorite_border,
//                   color: Colors.red,
//                   size: 20,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 6),

//           Text(
//             currentPrice,
//             style: const TextStyle(
//               color: Colors.green,
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 2),

//           Text(
//             oldPrice,
//             style: const TextStyle(
//               color: Colors.grey,
//               fontSize: 12,
//               decoration: TextDecoration.lineThrough,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


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
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _WishlistImage(
                      imageUrl: imageUrl,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: theme.colorScheme.surface.withValues(
                          alpha: 0.9,
                        ),
                        shape: const CircleBorder(),
                        child: IconButton(
                          onPressed:
                              isRemoving ? null : onFavoriteTap,
                          tooltip: 'Remove from wishlist',
                          visualDensity: VisualDensity.compact,
                          icon: isRemoving
                              ? const SizedBox(
                                  width: 19,
                                  height: 19,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                  size: 21,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  10,
                  12,
                  12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rs. ${_formatPrice(currentPrice)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (oldPrice != null &&
                        oldPrice! > currentPrice) ...[
                      const SizedBox(height: 3),
                      Text(
                        'Rs. ${_formatPrice(oldPrice!)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
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

  String _formatPrice(double price) {
    return price.toStringAsFixed(
      price.truncateToDouble() == price ? 0 : 2,
    );
  }
}

class _WishlistImage extends StatelessWidget {
  final String imageUrl;

  const _WishlistImage({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (imageUrl.trim().isEmpty) {
      return _fallback(theme);
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (
        context,
        child,
        loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        return ColoredBox(
          color: theme.colorScheme.surfaceContainerHighest,
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      },
      errorBuilder: (_, __, ___) {
        return _fallback(theme);
      },
    );
  }

  Widget _fallback(ThemeData theme) {
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 46,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}