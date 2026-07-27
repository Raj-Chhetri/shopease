import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/home_controller.dart';
import 'package:shopease/widgets/featured_carousel.dart';
import 'package:shopease/widgets/fillUp_widget.dart';
import 'package:shopease/widgets/for_you_pagination_footer.dart';
import 'package:shopease/widgets/home_header.dart';
import 'package:shopease/widgets/product_card.dart';
import 'package:shopease/widgets/responsive_product_grid.dart';
import 'package:shopease/widgets/section_title.dart';
import 'package:shopease/widgets/tags_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
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
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
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
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeHeader(
                              userName: 'Mahesh',
                              isDarkMode:
                                  theme.brightness == Brightness.dark,
                              onThemePressed: controller.toggleTheme,
                            ),
                            const SizedBox(height: 22),
                            FillupWidget(
                              hintText: 'Search products',
                              icon: Icons.search_rounded,
                              keyboardType: TextInputType.text,
                              onTap: controller.openSearch,
                              controller: controller.searchController,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (_) {},
                              onClear: controller.searchController.clear,
                            ),
                            const SizedBox(height: 18),
                            SizedBox(
                              height: 48,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.categories.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 10),
                                itemBuilder: (context, index) {
                                  final category =
                                      controller.categories[index];

                                  return TagsWidget(
                                    label: category.label,
                                    icon: category.icon,
                                    isSelected: index ==
                                        controller
                                            .selectedCategoryIndex.value,
                                    onPressed: () =>
                                        controller.selectCategory(index),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 28),
                            const SectionTitle(
                              title: 'Featured',
                              icon: CupertinoIcons.flame_fill,
                              iconColor: Color(0xFFFF7300),
                            ),
                            const SizedBox(height: 14),
                            FeaturedCarousel(
                              controller:
                                  controller.featuredPageController,
                              items: controller.featuredItems,
                              currentPage:
                                  controller.currentFeaturedPage.value,
                              onPageChanged:
                                  controller.setFeaturedPage,
                              onProductPressed:
                                  controller.openProductDetails,
                            ),
                            const SizedBox(height: 30),
                            const SectionTitle(
                              title: 'Top Picks',
                              icon: CupertinoIcons.heart_fill,
                              iconColor: Colors.redAccent,
                            ),
                            const SizedBox(height: 14),
                            SizedBox(
                              height: width < 360 ? 270 : 290,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.topPicks.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 14),
                                itemBuilder: (context, index) {
                                  final product =
                                      controller.topPicks[index];

                                  return SizedBox(
                                    width: width < 420 ? 170 : 195,
                                    child: ProductCard(
                                      productId: product.id,
                                      imageUrl: product.imageUrl,
                                      oldPrice: product.oldPrice,
                                      newPrice: product.newPrice,
                                      productTitle: product.title,
                                      isFavorite: controller
                                          .favoriteProductIds
                                          .contains(product.id),
                                      onTap: () =>
                                          controller.openProductDetails(
                                        product.id,
                                      ),
                                      onFavoritePressed: () =>
                                          controller.toggleFavorite(
                                        product.id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            const SectionTitle(
                              title: 'For You',
                              icon: CupertinoIcons.bag_fill,
                              iconColor: Color(0xFFFFB000),
                            ),
                            const SizedBox(height: 14),
                            ResponsiveProductGrid(
                              products: controller.forYouProducts,
                              availableWidth:
                                  width - (horizontalPadding * 2),
                              favoriteProductIds:
                                  controller.favoriteProductIds,
                              onProductPressed:
                                  controller.openProductDetails,
                              onFavoritePressed:
                                  controller.toggleFavorite,
                            ),
                            const SizedBox(height: 20),
                            ForYouPaginationFooter(
                              isLoading:
                                  controller.isLoadingMoreForYou.value,
                              hasMore: controller.hasMoreForYou.value,
                              hasProducts:
                                  controller.forYouProducts.isNotEmpty,
                            ),
                          ],
                        ),
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
