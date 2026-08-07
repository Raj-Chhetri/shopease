import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopease/controller/category_controller.dart';
import 'package:shopease/controller/home_controller.dart';
import 'package:shopease/controller/profile_controller.dart';
import 'package:shopease/controller/wishlist_controller.dart';
import 'package:shopease/models/featured_item.dart';
import 'package:shopease/models/home_product.dart';
import 'package:shopease/theme/app_theme.dart';
import 'package:shopease/utils/localization_utils.dart';
import 'package:shopease/widgets/featured_carousel.dart';
import 'package:shopease/widgets/fillUp_widget.dart';
import 'package:shopease/widgets/product_card.dart';
import 'package:shopease/widgets/tags_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final profileController = Get.find<ProfileController>();

    final categoryController = Get.isRegistered<CategoryController>()
        ? Get.find<CategoryController>()
        : Get.put(CategoryController(), permanent: true);

    final wishlistController = Get.isRegistered<WishlistController>()
        ? Get.find<WishlistController>()
        : Get.put(WishlistController(), permanent: true);

    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;

    final horizontalPadding = switch (width) {
      < 360 => 14.0,
      < 700 => 18.0,
      < 1100 => 32.0,
      _ => 48.0,
    };

    Future<void> refreshHome() async {
      await Future.wait([
        homeController.refreshForYouProducts(),
        categoryController.loadCategories(),
        wishlistController.loadWishlist(),
        profileController.loadProfile(),
      ]);
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: refreshHome,
          child: CustomScrollView(
            controller: homeController.scrollController,
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
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => _HomeHeader(
                              userName: profileController.userName.trim(),
                              isDarkMode:
                                  theme.brightness == Brightness.dark,
                              onThemePressed: homeController.toggleTheme,
                            ),
                          ),
                          const SizedBox(height: 22),
                          FillupWidget(
                            hintText: 'search_products'.tr,
                            icon: Icons.search_rounded,
                            keyboardType: TextInputType.text,
                            controller: homeController.searchController,
                            textInputAction: TextInputAction.search,
                            readOnly: true,
                            onTap: homeController.openSearch,
                            onSubmitted: (_) => homeController.openSearch(),
                            onClear: homeController.clearSearch,
                          ),
                          const SizedBox(height: 18),
                          _BackendCategoryList(
                            controller: categoryController,
                          ),
                          _WishlistFeaturedSection(
                            wishlistController: wishlistController,
                            homeController: homeController,
                          ),
                          const SizedBox(height: 30),
                          _SectionTitle(
                            title: 'top_picks'.tr,
                            icon: CupertinoIcons.heart_fill,
                            iconColor: Colors.redAccent,
                          ),
                          const SizedBox(height: 14),
                          _TopPicksSection(
                            controller: homeController,
                            screenWidth: width,
                          ),
                          const SizedBox(height: 30),
                          _SectionTitle(
                            title: 'for_you'.tr,
                            icon: CupertinoIcons.bag_fill,
                            iconColor: const Color(0xFFFFB000),
                          ),
                          const SizedBox(height: 14),
                          _ForYouSection(controller: homeController),
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

class _BackendCategoryList extends StatelessWidget {
  final CategoryController controller;

  const _BackendCategoryList({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final categories = controller.categories.toList(growable: false);
      final isLoading = controller.isLoading.value;
      final errorMessage = controller.errorMessage.value;

      if (isLoading && categories.isEmpty) {
        return const SizedBox(
          height: 48,
          child: Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      }

      if (errorMessage != null && categories.isEmpty) {
        return SizedBox(
          height: 48,
          child: Align(
            alignment: Alignment.centerLeft,
            child: TagsWidget(
              label: 'try_again'.tr,
              icon: Icons.refresh_rounded,
              onPressed: controller.loadCategories,
            ),
          ),
        );
      }

      if (categories.isEmpty) {
        return const SizedBox.shrink();
      }

      return SizedBox(
        height: 48,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          separatorBuilder: (_, _) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final category = categories[index];

            return TagsWidget(
              label: localizeCategoryName(category.name),
              icon: _categoryIcon(category.name),
              onPressed: () => controller.openCategory(category),
            );
          },
        ),
      );
    });
  }

  IconData _categoryIcon(String categoryName) {
    return switch (categoryName.trim().toLowerCase()) {
      'electronics' => Icons.devices_rounded,
      'books' => Icons.menu_book_rounded,
      'clothing' || 'fashion' => Icons.checkroom_rounded,
      'home & garden' ||
      'home and garden' => Icons.home_work_outlined,
      'sports' => Icons.sports_soccer_rounded,
      'wearables' => Icons.watch_rounded,
      'shoes' => Icons.directions_run_rounded,
      'smartphones' => Icons.smartphone_rounded,
      _ => Icons.category_outlined,
    };
  }
}

class _WishlistFeaturedSection extends StatefulWidget {
  final WishlistController wishlistController;
  final HomeController homeController;

  const _WishlistFeaturedSection({
    required this.wishlistController,
    required this.homeController,
  });

  @override
  State<_WishlistFeaturedSection> createState() =>
      _WishlistFeaturedSectionState();
}

class _WishlistFeaturedSectionState
    extends State<_WishlistFeaturedSection> {
  final PageController _pageController = PageController(
    viewportFraction: 0.92,
  );

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    if (_currentPage == index) return;

    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final wishlistItems = widget.wishlistController.wishlist.toList(
        growable: false,
      );

      if (wishlistItems.isEmpty) {
        return const SizedBox.shrink();
      }

      final carouselItems = wishlistItems
        .map(
          (item) => FeaturedItem(
            productId: item.productId,
            imageUrl: item.imageUrl,
            title: item.productName,
            subtitle: '',
          ),
        )
        .toList(growable: false);

      final safePage = _currentPage >= carouselItems.length
          ? carouselItems.length - 1
          : _currentPage;

      if (safePage != _currentPage) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;

          if (_pageController.hasClients) {
            _pageController.jumpToPage(safePage);
          }

          setState(() {
            _currentPage = safePage;
          });
        });
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          _SectionTitle(
            title: 'featured'.tr,
            icon: CupertinoIcons.flame_fill,
            iconColor: const Color(0xFFFF7300),
          ),
          const SizedBox(height: 14),
          FeaturedCarousel(
            controller: _pageController,
            items: carouselItems,
            currentPage: safePage,
            onPageChanged: _onPageChanged,
            onProductPressed:
                widget.homeController.openProductDetails,
          ),
        ],
      );
    });
  }
}

class _TopPicksSection extends StatelessWidget {
  final HomeController controller;
  final double screenWidth;

  const _TopPicksSection({
    required this.controller,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = screenWidth < 420 ? 170.0 : 195.0;

    // ProductCard reserves 142 logical pixels for its information area.
    // Matching the responsive grids prevents its price or rounded bottom
    // from being clipped.
    final cardHeight = cardWidth + 152;

    // Extra space preserves the Card elevation beneath each product.
    final sectionHeight = cardHeight + 10;

    return SizedBox(
      height: sectionHeight,
      child: Obx(() {
        final favoriteIds = controller.favoriteProductIds.toSet();

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          itemCount: controller.topPicks.length,
          separatorBuilder: (_, _) => const SizedBox(width: 14),
          itemBuilder: (context, index) {
            final product = controller.topPicks[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: _HomeProductCard(
                  product: product,
                  isFavorite: favoriteIds.contains(product.id),
                  onTap: () {
                    controller.openProductDetails(product.id);
                  },
                  onFavoritePressed: () {
                    controller.toggleFavorite(product.id);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class _ForYouSection extends StatelessWidget {
  final HomeController controller;

  const _ForYouSection({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final products = controller.forYouProducts.toList(growable: false);
      final favoriteIds = controller.favoriteProductIds.toSet();
      final isLoading = controller.isLoadingMoreForYou.value;
      final hasMore = controller.hasMoreForYou.value;
      final errorMessage = controller.paginationError.value;

      return Column(
        children: [
          if (products.isNotEmpty)
            LayoutBuilder(
              builder: (context, constraints) {
                return _ResponsiveProductGrid(
                  products: products,
                  availableWidth: constraints.maxWidth,
                  favoriteProductIds: favoriteIds,
                  onProductPressed: controller.openProductDetails,
                  onFavoritePressed: controller.toggleFavorite,
                );
              },
            ),
          const SizedBox(height: 20),
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
    });
  }
}

class _ForYouPaginationFooter extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text('try_again'.tr),
            ),
          ],
        ),
      );
    }

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: SizedBox(
            width: 26,
            height: 26,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
        ),
      );
    }

    if (hasMore) {
      return Center(
        child: OutlinedButton.icon(
          onPressed: onLoadMore,
          icon: const Icon(Icons.expand_more_rounded),
          label: Text(
            hasProducts ? 'show_more'.tr : 'load_products'.tr,
          ),
        ),
      );
    }

    if (hasProducts) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            'end_reached'.tr,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          'no_products_available'.tr,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _ResponsiveProductGrid extends StatelessWidget {
  final List<HomeProduct> products;
  final double availableWidth;
  final Set<int> favoriteProductIds;
  final ValueChanged<int> onProductPressed;
  final ValueChanged<int> onFavoritePressed;

  const _ResponsiveProductGrid({
    required this.products,
    required this.availableWidth,
    required this.favoriteProductIds,
    required this.onProductPressed,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final int columns;

    if (availableWidth >= 1050) {
      columns = 4;
    } else if (availableWidth >= 720) {
      columns = 3;
    } else {
      columns = 2;
    }

    const spacing = 14.0;

    final itemWidth =
        (availableWidth - spacing * (columns - 1)) / columns;

    final itemHeight = itemWidth + 152;

    return Wrap(
      spacing: spacing,
      runSpacing: 18,
      children: products
          .map(
            (product) => SizedBox(
              width: itemWidth,
              height: itemHeight,
              child: _HomeProductCard(
                product: product,
                isFavorite: favoriteProductIds.contains(product.id),
                onTap: () {
                  onProductPressed(product.id);
                },
                onFavoritePressed: () {
                  onFavoritePressed(product.id);
                },
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _HomeProductCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
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

class _HomeHeader extends StatelessWidget {
  final String userName;
  final bool isDarkMode;
  final VoidCallback onThemePressed;

  const _HomeHeader({
    required this.userName,
    required this.isDarkMode,
    required this.onThemePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasUserName = userName.isNotEmpty;

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
                    '${'welcome_to'.tr} ',
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
              const SizedBox(height: 4),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    hasUserName ? '${'hello'.tr}, ' : '${'hello'.tr}!',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                  if (hasUserName) ...[
                    Text(
                      '$userName.',
                      style: GoogleFonts.itim(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                    Text(
                      ' ${'greetings'.tr}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Material(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
          child: IconButton(
            onPressed: onThemePressed,
            tooltip: isDarkMode
                ? 'use_light_mode'.tr
                : 'use_dark_mode'.tr,
            icon: Icon(
              isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: isDarkMode ? Colors.amber : AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const _SectionTitle({
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleSize =
        MediaQuery.sizeOf(context).width < 360 ? 27.0 : 32.0;

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
        const SizedBox(width: 8),
        Icon(
          icon,
          color: iconColor,
          size: titleSize,
        ),
      ],
    );
  }
}