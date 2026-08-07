import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/search_product_controller.dart';
import 'package:shopease/services/search_product_service.dart';
import 'package:shopease/services/wishlist_service.dart';
import 'package:shopease/views/product_detail.dart';
import 'package:shopease/widgets/filter_button.dart';
import 'package:shopease/widgets/product_card.dart';
import 'package:shopease/controller/wishlist_controller.dart';

class SearchScreen extends StatefulWidget {
  final int? initialCategoryId;
  final String? initialCategoryName;

  const SearchScreen({
    super.key,
    this.initialCategoryId,
    this.initialCategoryName,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  final TextEditingController minRatingController = TextEditingController();
  final TextEditingController maxRatingController = TextEditingController();
  final WishlistService _wishlistService = WishlistService();

  Timer? debounce;

  late final SearchProductController controller;
  late final WishlistController wishlistController;
  late final String _controllerTag;

  @override
  void initState() {
    super.initState();

    _controllerTag = 'search-${identityHashCode(this)}';
    controller = Get.put(
      SearchProductController(SearchProductService()),
      tag: _controllerTag,
    );

    wishlistController = Get.isRegistered<WishlistController>()
        ? Get.find<WishlistController>()
        : Get.put(WishlistController(), permanent: true);

    if (widget.initialCategoryName != null) {
      searchController.text = widget.initialCategoryName!;
    }

    if (widget.initialCategoryId != null) {
      controller.searchProducts(
        queryParameters: {"category_id": widget.initialCategoryId},
      );
    }
  }

  void search(String value) {
    debounce?.cancel();

    debounce = Timer(const Duration(milliseconds: 500), () {
      final keyword = value.trim();

      if (keyword.isEmpty) {
        controller.clearSearch();
        return;
      }

      controller.searchProducts(queryParameters: {"q": keyword});
    });
  }

  @override
  void dispose() {
    debounce?.cancel();

    searchController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    minRatingController.dispose();
    maxRatingController.dispose();
    Get.delete<SearchProductController>(tag: _controllerTag);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('search_products_title'.tr)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: TextField(
              controller: searchController,
              onChanged: search,
              decoration: InputDecoration(
                hintText: '${'search_products'.tr}...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 50,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              children: [
                FilterButton(
                  icon: Icons.category_outlined,
                  title: 'category'.tr,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              title: Text('electronics'.tr),
                              onTap: () {
                                Navigator.pop(context);
                                controller.searchProducts(
                                  queryParameters: {"category": "Electronics"},
                                );
                              },
                            ),
                            ListTile(
                              title: Text('books'.tr),
                              onTap: () {
                                Navigator.pop(context);
                                controller.searchProducts(
                                  queryParameters: {"category": "Books"},
                                );
                              },
                            ),
                            ListTile(
                              title: Text('clothing'.tr),
                              onTap: () {
                                Navigator.pop(context);
                                controller.searchProducts(
                                  queryParameters: {"category": "Clothing"},
                                );
                              },
                            ),
                            ListTile(
                              title: Text('home_garden'.tr),
                              onTap: () {
                                Navigator.pop(context);
                                controller.searchProducts(
                                  queryParameters: {
                                    "category": "Home and Garden",
                                  },
                                );
                              },
                            ),
                            ListTile(
                              title: Text('sports'.tr),
                              onTap: () {
                                Navigator.pop(context);
                                controller.searchProducts(
                                  queryParameters: {"category": "Sports"},
                                );
                              },
                            ),
                            ListTile(
                              title: Text('general'.tr),
                              onTap: () {
                                Navigator.pop(context);
                                controller.searchProducts(
                                  queryParameters: {"category": "General"},
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                const SizedBox(width: 10),

                FilterButton(
                  icon: Icons.attach_money,
                  title: 'price'.tr,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 20,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: minPriceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'minimum_price'.tr,
                                ),
                              ),

                              const SizedBox(height: 15),

                              TextField(
                                controller: maxPriceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'maximum_price'.tr,
                                ),
                              ),

                              const SizedBox(height: 20),

                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  controller.searchProducts(
                                    queryParameters: {
                                      "q": searchController.text.trim(),
                                      "min_price": minPriceController.text,
                                      "max_price": maxPriceController.text,
                                    },
                                  );
                                },
                                child: Text('apply'.tr),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(width: 10),

                FilterButton(
                  icon: Icons.star_outline,
                  title: 'rating'.tr,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 20,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: minRatingController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                decoration: InputDecoration(
                                  labelText: 'minimum_rating'.tr,
                                ),
                              ),

                              const SizedBox(height: 15),

                              TextField(
                                controller: maxRatingController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                decoration: InputDecoration(
                                  labelText: 'maximum_rating'.tr,
                                ),
                              ),

                              const SizedBox(height: 20),

                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  controller.searchProducts(
                                    queryParameters: {
                                      "q": searchController.text.trim(),
                                      "min_rating": minRatingController.text,
                                      "max_rating": maxRatingController.text,
                                    },
                                  );
                                },
                                child: Text('apply'.tr),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(width: 10),

                FilterButton(
                  icon: Icons.refresh,
                  title: 'clear'.tr,
                  onPressed: () {
                    searchController.clear();
                    minPriceController.clear();
                    maxPriceController.clear();
                    minRatingController.clear();
                    maxRatingController.clear();

                    controller.clearSearch();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          const SizedBox(width: 10),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.error.value != null) {
                return Center(child: Text(controller.error.value!));
              }

              if (controller.products.isEmpty) {
                return Center(
                  child: Text(
                    'no_products_found'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
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
                        oldPrice: product.originalPrice?.toStringAsFixed(2),

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
          ),
        ],
      ),
    );
  }
}
