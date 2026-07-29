// wishlist_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/wishlist_controller.dart';
import '../widgets/wishlist_card.dart';
import 'product_detail.dart';

class WishlistView extends StatelessWidget {
  final bool showBackButton;

  const WishlistView({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController(), permanent: false);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: showBackButton
            ? IconButton(
                onPressed: Get.back,
                tooltip: 'Back',
                icon: const Icon(Icons.arrow_back_rounded),
              )
            : null,
        title: Text(
          'My Wishlist',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return _WishlistErrorState(
              message: controller.errorMessage.value,
              onRetry: controller.loadWishlist,
            );
          }

          final visibleItems = controller.visibleWishlist;

          return Column(
            children: [
              if (controller.wishlist.isNotEmpty)
                SizedBox(
                  height: 58,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: controller.categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 9),
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      final isSelected =
                          category == controller.selectedCategory.value;

                      return ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (_) =>
                            controller.selectedCategory.value = category,
                        selectedColor: theme.colorScheme.primary,
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        side: BorderSide.none,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ),
              Expanded(
                child: visibleItems.isEmpty
                    ? _EmptyWishlistState(
                        hasWishlistItems: controller.wishlist.isNotEmpty,
                        onClearFilter: () =>
                            controller.selectedCategory.value = 'All',
                        onRefresh: controller.loadWishlist,
                      )
                    : RefreshIndicator(
                        onRefresh: controller.loadWishlist,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.maxWidth;
                            final horizontalPadding = width < 700 ? 10.0 : 24.0;

                            final crossAxisCount = switch (width) {
                              < 650 => 3,
                              < 950 => 3,
                              _ => 4,
                            };

                            return GridView.builder(
                              padding: EdgeInsets.fromLTRB(
                                horizontalPadding,
                                8,
                                horizontalPadding,
                                110,
                              ),
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: visibleItems.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.58,
                                  ),
                              itemBuilder: (context, index) {
                                final item = visibleItems[index];
                                return WishlistCard(
                                  imageUrl: item.imageUrl,
                                  productName: item.productName,
                                  currentPrice: item.currentPrice,
                                  oldPrice: item.oldPrice,
                                  isRemoving: controller.removingProductIds
                                      .contains(item.productId),
                                  onTap: () => controller.openProduct(item),
                                  onFavoriteTap: () =>
                                      controller.removeFromWishlist(item),
                                );
                              },
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _WishlistErrorState extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _WishlistErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRetry,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 150),
          Icon(
            Icons.cloud_off_rounded,
            size: 62,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 18),
          Center(
            child: FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyWishlistState extends StatelessWidget {
  final bool hasWishlistItems;
  final VoidCallback onClearFilter;
  final Future<void> Function() onRefresh;

  const _EmptyWishlistState({
    required this.hasWishlistItems,
    required this.onClearFilter,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          const SizedBox(height: 120),
          Icon(
            hasWishlistItems
                ? Icons.filter_alt_off_outlined
                : Icons.favorite_border_rounded,
            size: 72,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 18),
          Text(
            hasWishlistItems
                ? 'No products in this category'
                : 'Your wishlist is empty',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hasWishlistItems
                ? 'Choose another category to view your saved products.'
                : 'Products you save will appear here.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (hasWishlistItems) ...[
            const SizedBox(height: 20),
            Center(
              child: OutlinedButton(
                onPressed: onClearFilter,
                child: const Text('Show all'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
