// import 'package:flutter/material.dart';

// class CategoryCard extends StatelessWidget {
//   final String title;
//   final String? imageUrl;
//   final String? assetImage;
//   final int productCount;
//   final Color backgroundColor;
//   final VoidCallback? onTap;

//   const CategoryCard({
//     super.key,
//     required this.title,
//     required this.backgroundColor,
//     this.imageUrl,
//     this.assetImage,
//     this.productCount = 0,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Material(
//       color: backgroundColor,
//       borderRadius: BorderRadius.circular(20),
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(
//               color: theme.colorScheme.outlineVariant.withValues(alpha: 0.45),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.06),
//                 blurRadius: 12,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(child: Center(child: _buildImage(context))),
//               const SizedBox(height: 10),
//               Text(
//                 title,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       productCount > 0
//                           ? '$productCount products'
//                           : 'View products',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: theme.textTheme.bodySmall?.copyWith(
//                         color: theme.colorScheme.onSurfaceVariant,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Container(
//                     width: 30,
//                     height: 30,
//                     decoration: BoxDecoration(
//                       color: theme.colorScheme.surface.withValues(alpha: 0.9),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.arrow_forward_rounded,
//                       size: 17,
//                       color: theme.colorScheme.primary,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildImage(BuildContext context) {
//     final theme = Theme.of(context);

//     if (imageUrl != null && imageUrl!.trim().isNotEmpty) {
//       return Image.network(
//         imageUrl!,
//         fit: BoxFit.contain,
//         errorBuilder: (_, __, ___) {
//           return _fallbackIcon(theme);
//         },
//         loadingBuilder: (context, child, loadingProgress) {
//           if (loadingProgress == null) return child;

//           return const Center(child: CircularProgressIndicator(strokeWidth: 2));
//         },
//       );
//     }

//     if (assetImage != null && assetImage!.isNotEmpty) {
//       return Image.asset(
//         assetImage!,
//         fit: BoxFit.contain,
//         errorBuilder: (_, __, ___) {
//           return _fallbackIcon(theme);
//         },
//       );
//     }

//     return _fallbackIcon(theme);
//   }

//   Widget _fallbackIcon(ThemeData theme) {
//     return Icon(
//       Icons.category_outlined,
//       size: 64,
//       color: theme.colorScheme.primary,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String? icon;
  final String? assetImage;
  final int productCount;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.backgroundColor,
    this.icon,
    this.assetImage,
    this.productCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.45),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Center(child: _buildImage(context))),

              const SizedBox(height: 10),

              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      _productCountText(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 17,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the correct product count text.
  String _productCountText() {
    if (productCount == 0) {
      return 'no_products'.tr;
    }

    if (productCount == 1) {
      return 'one_product'.tr;
    }

    return 'products_count'.trParams({'count': '$productCount'});
  }

  Widget _buildImage(BuildContext context) {
    final theme = Theme.of(context);

    if (icon != null && icon!.trim().isNotEmpty) {
      final imagePath = icon!.startsWith("http")
          ? icon!
          : "https://shopease.sudamhub.com/$icon";

      return Image.network(
        imagePath,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        },
        errorBuilder: (_, _, _) {
          return _buildAssetOrFallback(theme);
        },
      );
    }

    return _buildAssetOrFallback(theme);
  }

  Widget _buildAssetOrFallback(ThemeData theme) {
    if (assetImage != null && assetImage!.isNotEmpty) {
      return Image.asset(
        assetImage!,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) {
          return _fallbackIcon(theme);
        },
      );
    }

    return _fallbackIcon(theme);
  }

  Widget _fallbackIcon(ThemeData theme) {
    return Icon(
      Icons.category_outlined,
      size: 64,
      color: theme.colorScheme.primary,
    );
  }
}
