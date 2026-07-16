// // TODO Implement this library.
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PrivacyPolicyPage extends StatelessWidget {
//   const PrivacyPolicyPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF6C3EF4), // Same blue as your heading
//         foregroundColor: Colors.white, // Back button & title color
//         title: Text("privacy".tr),
//         centerTitle: false,
//       ),

//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             double maxWidth;

//             if (constraints.maxWidth >= 1200) {
//               maxWidth = 900;
//             } else if (constraints.maxWidth >= 800) {
//               maxWidth = 750;
//             } else {
//               maxWidth = constraints.maxWidth;
//             }

//             return Center(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(maxWidth: maxWidth),
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 24,
//                   ),
//                   child: SelectableText.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: "${"privacy".tr}\n\n",
//                           style: TextStyle(
//                             fontSize: 26,
//                             fontWeight: FontWeight.bold,

//                             color: const Color.from(
//                               alpha: 0,
//                               red: 0,
//                               green: 0,
//                               blue: 0,
//                             ),
//                           ),
//                         ),

//                         TextSpan(
//                           text: "privacy_content".tr,
//                           style: TextStyle(
//                             fontSize: 27,
//                             fontWeight: FontWeight.bold,
//                             height: 1.7, // ✅ Correct
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({
    super.key,
  });

  static const Color _primaryColor = Color(0xFF6D28FF);

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
          'privacy'.tr,
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
                      _LegalHeader(
                        icon: Icons.privacy_tip_outlined,
                        title: 'privacy'.tr,
                        description:
                            'Learn how ShopEase collects, uses and protects your information.',
                      ),
                      const SizedBox(height: 28),
                      SelectableText(
                        'privacy_content'.tr,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 16,
                          height: 1.75,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const _LegalNotice(),
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

class _LegalHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _LegalHeader({
    required this.icon,
    required this.title,
    required this.description,
  });

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
            child: Icon(
              icon,
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
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  description,
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

class _LegalNotice extends StatelessWidget {
  const _LegalNotice();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'This policy should be reviewed and approved before the app is released publicly.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}