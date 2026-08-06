import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopease/controller/home_controller.dart';
import 'package:shopease/controller/profile_controller.dart';
import 'package:shopease/models/home_product.dart';
import 'package:shopease/theme/app_theme.dart';
import 'package:shopease/widgets/featured_card.dart';
import 'package:shopease/widgets/fillUp_widget.dart';
import 'package:shopease/widgets/product_card.dart';
import 'package:shopease/widgets/tags_widget.dart';

String
_getFirstName(
  String? fullName,
) {
  final normalized =
      (fullName ??
              '')
          .trim();
  if (normalized.isEmpty) {
    return 'there';
  }

  final parts = normalized
      .split(
        RegExp(
          r'\s+',
        ),
      )
      .where(
        (
          part,
        ) => part.isNotEmpty,
      )
      .toList();
  return parts.isNotEmpty
      ? parts.first
      : 'there';
}

class HomeScreenView
    extends
        StatelessWidget {
  const HomeScreenView({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final HomeController controller =
        Get.find<
          HomeController
        >();
    final ProfileController profileController =
        Get.find<
          ProfileController
        >();
    final theme = Theme.of(
      context,
    );
    final width = MediaQuery.sizeOf(
      context,
    ).width;

    final horizontalPadding = switch (width) {
      < 360 => 14.0,
      < 700 => 18.0,
      < 1100 => 32.0,
      _ => 48.0,
    };

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: controller.refreshForYouProducts,
          child: CustomScrollView(
            controller: controller.scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  14,
                  horizontalPadding,
                  118,
                ),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 1200,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => _HomeHeader(
                              userName: _getFirstName(
                                profileController.userName,
                              ),
                              isDarkMode:
                                  theme.brightness ==
                                  Brightness.dark,
                              onThemePressed: controller.toggleTheme,
                            ),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          FillupWidget(
                            hintText: 'Search products',
                            icon: Icons.search_rounded,
                            keyboardType: TextInputType.text,
                            controller: controller.searchController,
                            textInputAction: TextInputAction.search,
                            readOnly: true,
                            onTap: controller.openSearch,
                            onSubmitted:
                                (
                                  _,
                                ) => controller.openSearch(),
                            onClear: controller.clearSearch,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          _CategoryList(
                            controller: controller,
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          const _SectionTitle(
                            title: 'Featured',
                            icon: CupertinoIcons.flame_fill,
                            iconColor: Color(
                              0xFFFF7300,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          _FeaturedSection(
                            controller: controller,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const _SectionTitle(
                            title: 'Top Picks',
                            icon: CupertinoIcons.heart_fill,
                            iconColor: Colors.redAccent,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          _TopPicksSection(
                            controller: controller,
                            screenWidth: width,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const _SectionTitle(
                            title: 'For You',
                            icon: CupertinoIcons.bag_fill,
                            iconColor: Color(
                              0xFFFFB000,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          _ForYouSection(
                            controller: controller,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryList
    extends
        StatelessWidget {
  final HomeController controller;

  const _CategoryList({
    required this.controller,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: 48,
      child: Obx(
        () {
          final selectedIndex = controller.selectedCategoryIndex.value;

          final categories = controller.displayedCategories.isNotEmpty
              ? controller.displayedCategories
              : controller.categories;

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder:
                (
                  _,
                  _,
                ) => const SizedBox(
                  width: 10,
                ),
            itemBuilder:
                (
                  context,
                  index,
                ) {
                  final category = categories[index];

                  return TagsWidget(
                    label: category.label,
                    icon: category.icon,
                    isSelected:
                        index ==
                        selectedIndex,
                    onPressed: () => controller.selectCategory(
                      index,
                    ),
                  );
                },
          );
        },
      ),
    );
  }
}

class _FeaturedSection
    extends
        StatelessWidget {
  final HomeController controller;

  const _FeaturedSection({
    required this.controller,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    if (controller.featuredItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Obx(
      () {
        final currentPage = controller.currentFeaturedPage.value;

        return Column(
          children: [
            SizedBox(
              height: 205,
              child: PageView.builder(
                controller: controller.featuredPageController,
                itemCount: controller.featuredItems.length,
                onPageChanged: controller.setFeaturedPage,
                physics: const BouncingScrollPhysics(),
                itemBuilder:
                    (
                      context,
                      index,
                    ) {
                      final item = controller.featuredItems[index];

                      return FeaturedCard(
                        imageUrl: item.imageUrl,
                        title: item.title,
                        subtitle: item.subtitle,
                        isActive:
                            index ==
                            currentPage,
                        onTap: () => controller.openProductDetails(
                          item.productId,
                        ),
                      );
                    },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.featuredItems.length,
                (
                  index,
                ) {
                  final selected =
                      index ==
                      currentPage;

                  return AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 220,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    width: selected
                        ? 22
                        : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppTheme.primary
                          : Theme.of(
                              context,
                            ).colorScheme.outline,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TopPicksSection
    extends
        StatelessWidget {
  final HomeController controller;
  final double screenWidth;

  const _TopPicksSection({
    required this.controller,
    required this.screenWidth,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height:
          screenWidth <
              360
          ? 270
          : 290,
      child: Obx(
        () {
          final favoriteIds = controller.favoriteProductIds.toSet();

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.topPicks.length,
            separatorBuilder:
                (
                  _,
                  _,
                ) => const SizedBox(
                  width: 14,
                ),
            itemBuilder:
                (
                  context,
                  index,
                ) {
                  final product = controller.topPicks[index];

                  return SizedBox(
                    width:
                        screenWidth <
                            420
                        ? 170
                        : 195,
                    child: _HomeProductCard(
                      product: product,
                      isFavorite: favoriteIds.contains(
                        product.id,
                      ),
                      onTap: () => controller.openProductDetails(
                        product.id,
                      ),
                      onFavoritePressed: () => controller.toggleFavorite(
                        product.id,
                      ),
                    ),
                  );
                },
          );
        },
      ),
    );
  }
}

class _ForYouSection
    extends
        StatelessWidget {
  final HomeController controller;

  const _ForYouSection({
    required this.controller,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Obx(
      () {
        final products = controller.forYouProducts.toList(
          growable: false,
        );
        final favoriteIds = controller.favoriteProductIds.toSet();
        final isLoading = controller.isLoadingMoreForYou.value;
        final hasMore = controller.hasMoreForYou.value;
        final errorMessage = controller.paginationError.value;

        return Column(
          children: [
            if (products.isNotEmpty)
              LayoutBuilder(
                builder:
                    (
                      context,
                      constraints,
                    ) {
                      return _ResponsiveProductGrid(
                        products: products,
                        availableWidth: constraints.maxWidth,
                        favoriteProductIds: favoriteIds,
                        onProductPressed: controller.openProductDetails,
                        onFavoritePressed: controller.toggleFavorite,
                      );
                    },
              ),
            const SizedBox(
              height: 20,
            ),
            _ForYouPaginationFooter(
              isLoading: isLoading,
              hasMore: hasMore,
              hasProducts: products.isNotEmpty,
              errorMessage: errorMessage,
              onLoadMore: controller.loadMoreForYouProducts,
              onRetry: controller.retryPagination,
            ),
          ],
        );
      },
    );
  }
}

class _ForYouPaginationFooter
    extends
        StatelessWidget {
  final bool isLoading;
  final bool hasMore;
  final bool hasProducts;
  final String? errorMessage;
  final VoidCallback onLoadMore;
  final VoidCallback onRetry;

  const _ForYouPaginationFooter({
    required this.isLoading,
    required this.hasMore,
    required this.hasProducts,
    required this.errorMessage,
    required this.onLoadMore,
    required this.onRetry,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );

    if (errorMessage !=
        null) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Column(
          children: [
            Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(
                Icons.refresh_rounded,
              ),
              label: const Text(
                'Try again',
              ),
            ),
          ],
        ),
      );
    }

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Center(
          child: SizedBox(
            width: 26,
            height: 26,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
            ),
          ),
        ),
      );
    }

    if (hasMore) {
      return Center(
        child: OutlinedButton.icon(
          onPressed: onLoadMore,
          icon: const Icon(
            Icons.expand_more_rounded,
          ),
          label: Text(
            hasProducts
                ? 'Show more'
                : 'Load products',
          ),
        ),
      );
    }

    if (hasProducts) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Center(
          child: Text(
            "You've reached the end 🎉",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Center(
        child: Text(
          'No products are available.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _ResponsiveProductGrid
    extends
        StatelessWidget {
  final List<
    HomeProduct
  >
  products;
  final double availableWidth;
  final Set<
    int
  >
  favoriteProductIds;
  final ValueChanged<
    int
  >
  onProductPressed;
  final ValueChanged<
    int
  >
  onFavoritePressed;

  const _ResponsiveProductGrid({
    required this.products,
    required this.availableWidth,
    required this.favoriteProductIds,
    required this.onProductPressed,
    required this.onFavoritePressed,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final int columns;

    if (availableWidth >=
        1050) {
      columns = 4;
    } else if (availableWidth >=
        720) {
      columns = 3;
    } else {
      columns = 2;
    }

    const double spacing = 14;

    final double itemWidth =
        (availableWidth -
            spacing *
                (columns -
                    1)) /
        columns;
    final double itemHeight =
        (itemWidth /
            1.1) +
        130;

    return Wrap(
      spacing: spacing,
      runSpacing: 18,
      children: products
          .map(
            (
              product,
            ) {
              return SizedBox(
                width: itemWidth,
                height: itemHeight,
                child: _HomeProductCard(
                  product: product,
                  isFavorite: favoriteProductIds.contains(
                    product.id,
                  ),
                  onTap: () => onProductPressed(
                    product.id,
                  ),
                  onFavoritePressed: () {
                    onFavoritePressed(
                      product.id,
                    );
                  },
                ),
              );
            },
          )
          .toList(
            growable: false,
          ),
    );
  }
}

class _HomeProductCard
    extends
        StatelessWidget {
  final HomeProduct product;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoritePressed;

  const _HomeProductCard({
    required this.product,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoritePressed,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return ProductCard(
      productId: product.id,
      image: product.imageUrl,
      oldPrice: product.oldPrice,
      newPrice: product.newPrice,
      productTitle: product.title,
      isFavorite: isFavorite,
      onTap: onTap,
      onFavoritePressed: onFavoritePressed,
    );
  }
}

class _HomeHeader
    extends
        StatelessWidget {
  final String userName;
  final bool isDarkMode;
  final VoidCallback onThemePressed;

  const _HomeHeader({
    required this.userName,
    required this.isDarkMode,
    required this.onThemePressed,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Welcome to ',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'ShopEase!',
                    style: GoogleFonts.itim(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Hello, ',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '$userName.',
                    style: GoogleFonts.itim(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                  Text(
                    ' Greetings!',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Material(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(
            14,
          ),
          child: IconButton(
            onPressed: onThemePressed,
            tooltip: isDarkMode
                ? 'Use light mode'
                : 'Use dark mode',
            icon: Icon(
              isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: isDarkMode
                  ? Colors.amber
                  : AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle
    extends
        StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const _SectionTitle({
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );
    final titleSize =
        MediaQuery.sizeOf(
              context,
            ).width <
            360
        ? 27.0
        : 32.0;

    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: titleSize,
              height: 1.15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Icon(
          icon,
          color: iconColor,
          size: titleSize,
        ),
      ],
    );
  }
}
