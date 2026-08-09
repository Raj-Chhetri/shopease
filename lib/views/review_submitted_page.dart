import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewSubmittedPage extends StatelessWidget {
  final String productName;
  final String orderNumber;
  final String reviewText;
  final int rating;
  final String imageUrl;

  const ReviewSubmittedPage({
    super.key,
    required this.productName,
    required this.orderNumber,
    required this.reviewText,
    required this.rating,
    required this.imageUrl,
  });

  static const Color primaryColor = Color(0xFF6D28FF);

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
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 28,
          ),
        ),
        title: const Text(
          'Review Submitted',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Column(
                children: [
                  // SUCCESS ICON
                  Container(
                    width: 94,
                    height: 94,
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.10),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // TITLE
                  const Text(
                    'Thanks for the review!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // SUBTITLE
                  Text(
                    'Your feedback on $productName '
                    'is now live and helps other shoppers decide.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.45,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 26),

                  // PRODUCT + ORDER CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // PRODUCT IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: _ProductImage(
                                imageUrl: imageUrl,
                              ),
                            ),

                            const SizedBox(width: 12),

                            // PRODUCT DETAILS
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    'Order #$orderNumber',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: theme
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // VERIFIED PURCHASE
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 9,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withValues(
                                        alpha: 0.10,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_circle_rounded,
                                          size: 14,
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Verified Purchase',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Divider(
                          height: 1,
                          color: theme.colorScheme.outlineVariant,
                        ),

                        const SizedBox(height: 14),

                        // RATING
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: List.generate(
                              5,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 3,
                                  ),
                                  child: Icon(
                                    index < rating
                                        ? Icons.star_rounded
                                        : Icons.star_border_rounded,
                                    color: index < rating
                                        ? const Color(0xFFFFB800)
                                        : theme
                                            .colorScheme
                                            .onSurfaceVariant,
                                    size: 24,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // REVIEW TEXT
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            reviewText,
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.45,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // BACK TO ORDERS
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Back to Orders',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // VIEW MY REVIEWS
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                       onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        side: const BorderSide(
                          color: primaryColor,
                          width: 1.4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'View My Reviews',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imageUrl;

  const _ProductImage({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      height: 82,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: imageUrl.trim().isEmpty
          ? const Icon(
              Icons.image_not_supported_outlined,
              size: 30,
            )
          : Image.network(
              imageUrl,
              width: 82,
              height: 82,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.image_not_supported_outlined,
                  size: 30,
                );
              },
            ),
    );
  }
}