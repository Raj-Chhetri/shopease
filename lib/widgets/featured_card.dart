// import 'package:flutter/material.dart';

// class FeaturedCard extends StatelessWidget {
//   final String imageUrl;
//   final String? title;
//   final String? subtitle;
//   final VoidCallback? onTap;

//   const FeaturedCard({
//     super.key,
//     required this.imageUrl,
//     this.title,
//     this.subtitle,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Material(
//       color: theme.colorScheme.surfaceContainerHighest,
//       borderRadius: BorderRadius.circular(22),
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: onTap,
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.network(
//               imageUrl,
//               fit: BoxFit.cover,
//               loadingBuilder: (context, child, progress) {
//                 if (progress == null) return child;

//                 return const Center(
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 );
//               },
//               errorBuilder: (_, _, _) {
//                 return ColoredBox(
//                   color: theme.colorScheme.surfaceContainerHighest,
//                   child: Icon(
//                     Icons.image_not_supported_outlined,
//                     color: theme.colorScheme.onSurfaceVariant,
//                     size: 46,
//                   ),
//                 );
//               },
//             ),
//             if (title != null || subtitle != null)
//               const DecoratedBox(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.transparent,
//                       Color(0xD9000000),
//                     ],
//                   ),
//                 ),
//               ),
//             if (title != null || subtitle != null)
//               Positioned(
//                 left: 18,
//                 right: 18,
//                 bottom: 16,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (title != null)
//                       Text(
//                         title!,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: theme.textTheme.titleLarge?.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                     if (subtitle != null) ...[
//                       const SizedBox(height: 3),
//                       Text(
//                         subtitle!,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: theme.textTheme.bodyMedium?.copyWith(
//                           color: Colors.white.withValues(alpha: 0.92),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class FeaturedCard extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final bool isActive;
  final VoidCallback? onTap;

  const FeaturedCard({
    super.key,
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.isActive = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasText = title != null || subtitle != null;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        right: 12,
        top: isActive ? 0 : 7,
        bottom: isActive ? 0 : 7,
      ),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        scale: isActive ? 1 : 0.98,
        child: Material(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(22),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;

                    return ColoredBox(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (_, _, _) {
                    return ColoredBox(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 46,
                      ),
                    );
                  },
                ),
                if (hasText)
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xD9000000),
                        ],
                      ),
                    ),
                  ),
                if (hasText)
                  Positioned(
                    left: 18,
                    right: 18,
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null && title!.trim().isNotEmpty)
                          Text(
                            title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            subtitle!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.92),
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
      ),
    );
  }
}
