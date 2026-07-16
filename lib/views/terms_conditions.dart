// // TODO Implement this library.
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TermsConditionsPage extends StatelessWidget {
//   const TermsConditionsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(
//           0xFF6C3EF4,
//         ), // Same color as Privacy Policy
//         foregroundColor: Colors.white, // White title and back button
//         title: Text("terms".tr),
//         centerTitle: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),

//         child: Text(
//           "terms_content".tr,
//           style: const TextStyle(
//             fontSize: 27,
//             fontWeight: FontWeight.bold,
//             height: 1.7,
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          tooltip: 'Back',
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        title: Text(
          'terms'.tr,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding =
                constraints.maxWidth < 700 ? 20.0 : 40.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                20,
                horizontalPadding,
                44,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 850,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const _TermsHeader(),
                      const SizedBox(height: 28),
                      SelectableText(
                        'terms_content'.tr,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 16,
                          height: 1.75,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: theme
                              .colorScheme
                              .surfaceContainerHighest,
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.gavel_outlined,
                              color:
                                  theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'These terms should be reviewed by a qualified legal professional before ShopEase is released.',
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: theme.colorScheme
                                      .onSurfaceVariant,
                                  height: 1.45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TermsHeader extends StatelessWidget {
  const _TermsHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF6D28FF),
            Color(0xFF8B5CF6),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.description_outlined,
              color: Colors.white,
              size: 27,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'terms'.tr,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Please read these terms carefully before using ShopEase.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color:
                        Colors.white.withValues(alpha: 0.9),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}