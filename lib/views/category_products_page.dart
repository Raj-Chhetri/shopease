// category_products_Page

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/product_controller.dart';
import 'package:shopease/views/product_detail.dart';
import 'package:shopease/widgets/product_card.dart';
import 'package:shopease/controller/wishlist_controller.dart';
import 'package:shopease/services/wishlist_service.dart';
import 'package:shopease/utils/localization_utils.dart';

class CategoryProductsPage
    extends
        StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryProductsPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<
    CategoryProductsPage
  >
  createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  late final ProductController controller;
  late final WishlistController wishlistController;
  final WishlistService _wishlistService = WishlistService();

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      ProductController(),
      tag: 'category-products-${widget.categoryId}',
    );

    wishlistController = Get.isRegistered<WishlistController>()
        ? Get.find<WishlistController>()
        : Get.put(WishlistController(), permanent: true);

    controller.fetchProductsByCategory(
      widget.categoryId,
    );
  }

  @override
  void dispose() {
    Get.delete<ProductController>(
      tag: 'category-products-${widget.categoryId}',
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(localizeCategoryName(widget.categoryName))),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.products.isEmpty) {
          return Center(child: Text('no_products_found'.tr));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            int crossAxisCount;
            const horizontalPadding = 16.0;
            const spacing = 12.0;

            if (width < 380) {
              // Small phones
              crossAxisCount = 2;
            } else if (width < 450) {
              // Normal phones
              crossAxisCount = 2;
            } else if (width < 650) {
              // Large phones
              crossAxisCount = 2;
            } else if (width < 950) {
              // Tablet / Small web
              crossAxisCount = 3;
            } else if (width < 1250) {
              // Desktop
              crossAxisCount = 4;
            } else {
              // Large desktop
              crossAxisCount = 5;
            }

            final itemWidth =
                (width -
                    horizontalPadding * 2 -
                    spacing * (crossAxisCount - 1)) /
                crossAxisCount;
            final cardHeight = itemWidth + 152;

            return GridView.builder(
              padding: const EdgeInsets.all(horizontalPadding),
              itemCount: controller.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                mainAxisExtent: cardHeight,
              ),
              itemBuilder: (context, index) {
                final product = controller.products[index];

                return ProductCard(
                  productId: product.id,
                  productTitle: product.name,
                  image: product.imageUrl,
                  newPrice: product.price.toStringAsFixed(2),
                  oldPrice: product.originalPrice.toStringAsFixed(2),
                  rating: product.ratingAvg,
                  ratingCount: product.ratingCount,
                  isFavorite: wishlistController.wishlist.any(
                    (item) => item.productId == product.id,
                  ),
                  onFavoritePressed: () async {
                    final success = await _wishlistService.addToWishlist(
                      product.id,
                    );

                    if (success) {
                      await wishlistController.loadWishlist();

                      Get.snackbar('success'.tr, 'added_to_wishlist'.tr);
                    } else {
                      Get.snackbar('error'.tr, 'unable_add_wishlist'.tr);
                    }
                  },

                  onTap: () {
                    Get.to(
                      () => ProductDetail(productId: product.id),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 250),
                    );
                  },
                );
              },
            );
          },
        );
      }),
    );
  }
}